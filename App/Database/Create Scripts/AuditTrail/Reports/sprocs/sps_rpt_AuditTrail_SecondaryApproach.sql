IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_SecondaryApproach')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_SecondaryApproach';
		DROP  PROCEDURE  sps_rpt_AuditTrail_SecondaryApproach;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_SecondaryApproach';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_SecondaryApproach
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_SecondaryApproach.sql
**		Name: sps_rpt_AuditTrail_SecondaryApproach
**		Desc: 
**
**		Return values:
**
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		08/08/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality
**		11/05/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #ApproachInfo;
DROP TABLE IF EXISTS #TempYesNoNaILB;

/* Set UserOrgTZ Time Zone */
DECLARE @UserOrgTZ AS varchar(2) =
(
	SELECT vwAuditTrailTimeZone.TimeZoneAbbreviation 
	FROM vwAuditTrailOrganization
		JOIN vwAuditTrailTimeZone ON vwAuditTrailOrganization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
	WHERE OrganizationID = @UserOrgID
);

IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SELECT
			@ChangeStartDateTime = NULL,
			@ChangeEndDateTime = NULL;
	END
ELSE /* Adjust UserInputDateTime */
	BEGIN
		SELECT
			@ChangeStartDateTime =  DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeStartDateTime) * -1), @ChangeStartDateTime),
			@ChangeEndDateTime = DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeEndDateTime) * -1), @ChangeEndDateTime);
	END

/* Create Temp lookup table containing ILB 
	for reference to Yes, No, N/A and ILB */
SELECT YesNoNa_RefId, YesNoNa_RefName
INTO #TempYesNoNaILB
FROM vwAuditTrailYesNoNa_Ref
UNION
SELECT -2, 'ILB';



SELECT DISTINCT
/* SecondaryApproach * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, SecondaryApproach.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	SecondaryApproachChangePerson.PersonFirst + ' ' + SecondaryApproachChangePerson.PersonLast AS 'ChangeUser',
	SecondaryApproachChangeType.AuditLogTypeName AS 'ChangeType',
/* Hospital Approach */
	CASE WHEN SecondaryApproach.SecondaryHospitalApproach = -2 THEN 'ILB' ELSE HospitalApproach.ApproachTypeName END AS 'HospitalApproachType',
	CASE WHEN SecondaryApproach.SecondaryHospitalApproachedBy = -2 THEN 'ILB' ELSE HospitalApproachPerson.PersonFirst + ' ' + HospitalApproachPerson.PersonLast END AS 'HospitalApproachPerson',
	CASE SecondaryApproach.SecondaryHospitalOutcome
		WHEN -2 THEN 'ILB'
		WHEN 1 THEN 'Yes-Written'
		WHEN 2 THEN 'Yes-Verbal'
		WHEN 3 THEN 'No'
	END  AS 'HospitalApproachOutcome',
/* Informed Approach */
	YNInformedAppraochDone.YesNoNa_RefName AS 'InformedAppraochDone',
	CASE WHEN SecondaryApproach.SecondaryApproachType = -2 THEN 'ILB' ELSE InformedApproach.FSApproachTypeName END AS 'InformedApproachType',
	CASE WHEN SecondaryApproach.SecondaryApproachedBy = -2 THEN 'ILB' ELSE InformedApproachPerson.PersonFirst + ' ' + InformedApproachPerson.PersonLast END AS 'InformedApproachPerson',
	CASE SecondaryApproach.SecondaryApproachOutcome
		WHEN -2 THEN 'ILB'
		WHEN 1 THEN 'Yes-Verbal'
		WHEN 2 THEN 'Yes-Written'
		WHEN 3 THEN 'No'
		WHEN 4 THEN 'Undecided'
	END  AS 'InformedApproachOutcome',
	CASE WHEN SecondaryApproach.SecondaryApproachReason = -2 THEN 'ILB' ELSE FSApproachReason.FSApproachName END AS 'ReasonInformedApproachedNotCompleted',
/* Consent */
	YNConsentPaperwork.YesNoNa_RefName AS 'ConsentPaperwork',
	CASE WHEN SecondaryApproach.SecondaryConsentBy = -2 THEN 'ILB' ELSE ConsentPerson.PersonFirst + ' ' + ConsentPerson.PersonLast END AS 'ConsentObtainedBy',
	YNMedSocPaperwork.YesNoNa_RefName AS 'MedSocPaperwork',
	CASE WHEN SecondaryApproach.SecondaryConsentMedSocObtainedBy = -2 THEN 'ILB' ELSE MedSocPerson.PersonFirst + ' ' + MedSocPerson.PersonLast END AS 'MedSocObtainedBy',
	YNConsentForResearch.YesNoNa_RefName AS 'ConsentForResearch',
	SecondaryApproach.SecondaryConsentFuneralPlansOther,
	YNConsentLongSleeves.YesNoNa_RefName AS 'ConsentLongSleeves'
INTO #ApproachInfo
FROM
	SecondaryApproach
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = SecondaryApproach.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryApproachChangeEmployee ON SecondaryApproachChangeEmployee.StatEmployeeID = SecondaryApproach.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryApproachChangePerson ON SecondaryApproachChangePerson.PersonID = SecondaryApproachChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryApproachChangeType ON SecondaryApproachChangeType.AuditLogTypeID = SecondaryApproach.AuditLogTypeID
/* Hospital Approach */
	LEFT JOIN vwAuditTrailApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
	LEFT JOIN vwAuditTrailPerson AS HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy
/* Informed Approach */
	LEFT JOIN vwAuditTrailFSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
	LEFT JOIN vwAuditTrailPerson AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy
	LEFT JOIN vwAuditTrailFSApproach AS FSApproachReason ON FSApproachReason.FSApproachID = SecondaryApproach.SecondaryApproachReason
/* Consent */
	LEFT JOIN vwAuditTrailPerson AS ConsentPerson ON ConsentPerson.PersonID = SecondaryApproach.SecondaryConsentBy
	LEFT JOIN vwAuditTrailPerson AS MedSocPerson ON MedSocPerson.PersonID = SecondaryApproach.SecondaryConsentMedSocObtainedBy
/* Yes No NA lookup */
	LEFT JOIN #TempYesNoNaILB AS YNInformedAppraochDone ON YNInformedAppraochDone.YesNoNa_RefID = SecondaryApproach.SecondaryApproached
	LEFT JOIN #TempYesNoNaILB AS YNConsentPaperwork ON YNConsentPaperwork.YesNoNa_RefID = SecondaryApproach.SecondaryConsented
	LEFT JOIN #TempYesNoNaILB AS YNConsentForResearch ON YNConsentForResearch.YesNoNa_RefID = SecondaryApproach.SecondaryConsentResearch
	LEFT JOIN #TempYesNoNaILB AS YNMedSocPaperwork ON YNMedSocPaperwork.YesNoNa_RefID = SecondaryApproach.SecondaryConsentMedSocPaperwork
	LEFT JOIN #TempYesNoNaILB AS YNConsentLongSleeves ON YNConsentLongSleeves.YesNoNa_RefID = SecondaryApproach.SecondaryConsentLongSleeves
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	SecondaryApproach.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND SecondaryApproach.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN SecondaryApproach.LastStatEmployeeID
			ELSE @CoordinatorID
		END
UNION ALL /*** Deleted Calls ***/
SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	SecondaryApproachChangePerson.PersonFirst + ' ' + SecondaryApproachChangePerson.PersonLast AS 'ChangeUser',
	SecondaryApproachChangeType.AuditLogTypeName AS 'ChangeType',
/* Hospital Approach */
	NULL AS 'HospitalApproachType',
	NULL AS 'HospitalApproachPerson',
	NULL  AS 'HospitalApproachOutcome',
/* Informed Approach */
	NULL AS 'InformedAppraochDone',
	NULL AS 'InformedApproachType',
	NULL AS 'InformedApproachPerson',
	NULL AS 'InformedApproachOutcome',
	NULL AS 'ReasonInformedApproachedNotCompleted',
/* Consent */
	NULL AS 'ConsentPaperwork',
	NULL AS 'ConsentObtainedBy',
	NULL AS 'MedSocPaperwork',
	NULL AS 'MedSocObtainedBy',
	NULL AS 'ConsentForResearch',
	NULL AS 'SecondaryConsentFuneralPlansOther',
	NULL AS 'ConsentLongSleeves'
FROM
	[Call]
	JOIN SecondaryApproach SecondaryApproach ON SecondaryApproach.CallID = [Call].CallID
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryApproachChangeEmployee ON SecondaryApproachChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson SecondaryApproachChangePerson ON SecondaryApproachChangePerson.PersonID = SecondaryApproachChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryApproachChangeType ON SecondaryApproachChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Final Results */
SELECT *
FROM #ApproachInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[HospitalApproachType] IS NOT NULL
	OR	[HospitalApproachPerson] IS NOT NULL
	OR	[HospitalApproachOutcome] IS NOT NULL
	OR	[InformedAppraochDone] IS NOT NULL
	OR	[InformedApproachType] IS NOT NULL
	OR	[InformedApproachPerson] IS NOT NULL
	OR	[InformedApproachOutcome] IS NOT NULL
	OR	[ReasonInformedApproachedNotCompleted] IS NOT NULL
	OR	[ConsentPaperwork] IS NOT NULL
	OR	[ConsentObtainedBy] IS NOT NULL
	OR	[MedSocPaperwork] IS NOT NULL
	OR	[MedSocObtainedBy] IS NOT NULL
	OR	[ConsentForResearch] IS NOT NULL
	OR	[SecondaryConsentFuneralPlansOther] IS NOT NULL
	OR	[ConsentLongSleeves] IS NOT NULL
	)
AND	ChangeDT >= 
		CASE
			WHEN @ChangeStartDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeStartDateTime
		END
AND	ChangeDT <=
		CASE
			WHEN @ChangeEndDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeEndDateTime
		END;


DROP TABLE IF EXISTS #ApproachInfo;
DROP TABLE IF EXISTS #TempYesNoNaILB;