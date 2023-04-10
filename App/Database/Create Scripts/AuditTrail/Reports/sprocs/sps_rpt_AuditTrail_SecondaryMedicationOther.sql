IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_SecondaryMedicationOther')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_SecondaryMedicationOther';
		DROP  PROCEDURE  sps_rpt_AuditTrail_SecondaryMedicationOther;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_SecondaryMedicationOther';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_SecondaryMedicationOther
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_SecondaryMedicationOther.sql
**		Name: sps_rpt_AuditTrail_SecondaryMedicationOther
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: christopher carroll
**		Date: 08/07/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		08/07/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality
**		11/05/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #MedInfo;


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


SELECT DISTINCT
/* SecondaryMedication * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, SecondaryMedicationOther.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	SecondaryMedicationOtherChangePerson.PersonFirst + ' ' + SecondaryMedicationOtherChangePerson.PersonLast AS 'ChangeUser',
	SecondaryMedicationOtherChangeType.AuditLogTypeName AS 'ChangeType',
	SecondaryMedicationOther.SecondaryMedicationOtherName AS 'Medication Name',
	SecondaryMedicationOther.SecondaryMedicationOtherTypeUse AS 'Medication Type',
	SecondaryMedicationOther.SecondaryMedicationOtherDose AS 'Dose',
	CASE WHEN SecondaryMedicationOther.SecondaryMedicationOtherStartDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryMedicationOther.SecondaryMedicationOtherStartDate, 101) END AS 'StartDate',
	CASE WHEN SecondaryMedicationOther.SecondaryMedicationOtherEndDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryMedicationOther.SecondaryMedicationOtherEndDate, 101) END AS 'EndDate'
INTO #MedInfo
FROM
	SecondaryMedicationOther
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = SecondaryMedicationOther.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryMedicationOtherChangeEmployee ON SecondaryMedicationOtherChangeEmployee.StatEmployeeID = SecondaryMedicationOther.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryMedicationOtherChangePerson ON SecondaryMedicationOtherChangePerson.PersonID = SecondaryMedicationOtherChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryMedicationOtherChangeType ON SecondaryMedicationOtherChangeType.AuditLogTypeID = SecondaryMedicationOther.AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	SecondaryMedicationOther.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND SecondaryMedicationOther.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN SecondaryMedicationOther.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	SecondaryMedicationOtherChangePerson.PersonFirst + ' ' +SecondaryMedicationOtherChangePerson.PersonLast AS 'ChangeUser',
	SecondaryMedicationOtherChangeType.AuditLogTypeName AS 'ChangeType',
	NULL AS 'Medication Name',
	NULL AS 'Medication Type',
	NULL AS 'Dose',
	NULL AS 'StartDate',
	NULL AS 'EndDate'
FROM
	[Call]
	JOIN SecondaryMedicationOther ON SecondaryMedicationOther.CallID = [Call].CallID
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryMedicationOtherChangeEmployee ON SecondaryMedicationOtherChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson SecondaryMedicationOtherChangePerson ON SecondaryMedicationOtherChangePerson.PersonID = SecondaryMedicationOtherChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryMedicationOtherChangeType ON SecondaryMedicationOtherChangeType.AuditLogTypeID = [Call].AuditLogTypeID
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
FROM #MedInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[Medication Name] IS NOT NULL
	OR	[Medication Type] IS NOT NULL
	OR	[Dose] IS NOT NULL
	OR	[StartDate] IS NOT NULL
	OR	[EndDate] IS NOT NULL
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


DROP TABLE IF EXISTS #MedInfo;