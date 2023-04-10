IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_FSCase')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_FSCase';
		DROP  PROCEDURE  sps_rpt_AuditTrail_FSCase;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_FSCase';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_FSCase
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_FSCase.sql
**		Name: sps_rpt_AuditTrail_FSCase
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**      See above
**
**		Auth: christopher carroll 
**		Date: 08/06/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		08/06/2007		ccarroll				initial release
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		07/28/2011		ccarroll				Added CAST to varchar for datetime (SQL 2008)
**		12/9/2016		pscheichenost			Added CST to varchar for int fields
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #FSInfo;


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
/*** FSCase *** - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, FSCase.LastModified, @DisplayMT)AS smalldatetime) AS 'ChangeDT',
	FSCaseChangePerson.PersonFirst + ' ' + FSCaseChangePerson.PersonLast AS 'ChangeUser',
	FSCaseChangeType.AuditLogTypeName AS 'ChangeType',
/* FSCaseOpen */
	CASE WHEN FSCase.FSCaseOpenUserID = -2 THEN 'ILB' ELSE CaseOpenByPerson.PersonFirst + ' ' + CaseOpenByPerson.Personlast END AS 'FSCaseOpenBy',
	CASE WHEN FSCase.FSCaseOpenDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseOpenDateTime AS varchar) END AS 'FSCaseOpenDateTime',
/* SystemEvents */
	CASE WHEN FSCase.FSCaseSysEventsUserId = -2 THEN 'ILB' ELSE SystemEventsByPerson.PersonFirst + ' ' + SystemEventsByPerson.Personlast END AS 'SystemEventsBy',
	CASE WHEN FSCase.FSCaseSysEventsDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseSysEventsDateTime AS varchar) END AS 'FSCaseSysEventsDateTime',
/* SecComplete */
	CASE WHEN FSCase.FSCaseSecCompUserId = -2 THEN 'ILB' ELSE SecCompleteByPerson.PersonFirst + ' ' + SecCompleteByPerson.Personlast END AS 'SecCompleteBy',
	CASE WHEN FSCase.FSCaseSecCompDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseSecCompDateTime AS varchar) END AS 'FSCaseSecCompDateTime',
/* Approach */
	CASE WHEN FSCase.FSCaseApproachUserId = -2 THEN 'ILB' ELSE ApproachByPerson.PersonFirst + ' ' + ApproachByPerson.Personlast END AS 'ApproachBy',
	CASE WHEN FSCase.FSCaseApproachDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseApproachDateTime AS varchar) END AS 'FSCaseApproachDateTime',
/* Final */
	CASE WHEN FSCase.FSCaseFinalUserId = -2 THEN 'ILB' ELSE FinalByPerson.PersonFirst + ' ' + FinalByPerson.Personlast END AS 'FinalBy',
	CASE WHEN FSCase.FSCaseFinalDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseFinalDateTime AS varchar) END AS 'FSCaseFinalDateTime',
/* Bill Secondary */
	CASE WHEN FSCase.FSCaseBillSecondaryUserID = -2 THEN 'ILB' ELSE BillSecondaryByPerson.PersonFirst + ' ' + BillSecondaryByPerson.Personlast END AS 'BillSecondaryBy',
	CASE WHEN FSCase.FSCaseBillDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillDateTime AS varchar) END AS 'FSCaseBillDateTime',
/* Bill OTE */
	CASE WHEN FSCase.FSCaseBillOTEUserID = -2 THEN 'ILB' ELSE BillOTEByPerson.PersonFirst + ' ' + BillOTEByPerson.Personlast END AS 'BillOTEBy',
	CASE WHEN FSCase.FSCaseBillOTEDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillOTEDateTime AS varchar) END AS 'FSCaseBillOTEDateTime',
/* Bill FamUnavail */
	CASE WHEN FSCase.FSCaseBillFamUnavailUserId = -2 THEN 'ILB' ELSE BillFamUnavailByPerson.PersonFirst + ' ' + BillFamUnavailByPerson.Personlast END AS 'BillFamUnavailBy',
	CASE WHEN FSCase.FSCaseBillFamUnavailDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillFamUnavailDateTime AS varchar) END AS 'FSCaseBillFamUnavailDateTime',
/* Bill Family Approach */
	CASE WHEN FSCase.FSCaseApproachUserID = -2 THEN 'ILB' ELSE BillApproachByPerson.PersonFirst + ' ' + BillApproachByPerson.Personlast END AS 'BillFamilyApproachBy',
	CASE WHEN FSCase.FSCaseBillApproachDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillApproachDateTime AS varchar) END AS 'BillFamilyApproachDateTime',
	CASE WHEN FSCase.FSCaseBillApproachCount = -2 THEN 'ILB' ELSE CAST(FSCase.FSCaseBillApproachCount AS varchar(10)) END AS 'BillFamilyApproachCount',
/* Bill MedSoc */
	CASE WHEN FSCase.FSCaseBillMedSocUserID  = -2 THEN 'ILB' ELSE BillMedSocByPerson.PersonFirst + ' ' + BillMedSocByPerson.Personlast END AS 'BillMedSocBy',
	CASE WHEN FSCase.FSCaseBillMedSocDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillMedSocDateTime AS varchar) END AS 'FSCaseBillMedSocDateTime',
	CASE WHEN FSCase.FSCaseBillMedSocCount = -2 THEN 'ILB' ELSE CAST(FSCase.FSCaseBillMedSocCount AS varchar(10)) END AS 'FSCaseBillMedSocCount',
/* Bill CryoLife */
	CASE WHEN FSCase.FSCaseBillCryoFormUserID = -2 THEN 'ILB' ELSE BillCryoLifeByPerson.PersonFirst + ' ' + BillCryoLifeByPerson.Personlast END AS 'BillCryoLifeBy',
	CASE WHEN FSCase.FSCaseBillCryoFormDateTime = '01/01/1900' THEN 'ILB' ELSE CAST(FSCase.FSCaseBillCryoFormDateTime AS varchar) END AS 'FSCaseBillCryoFormDateTime',
	CASE WHEN FSCase.FSCaseBillCryoFormCount = -2 THEN 'ILB' ELSE CAST(FSCase.FSCaseBillCryoFormCount AS varchar(10)) END AS 'FSCaseBillCryoFormCount'
INTO #FSInfo
FROM
	FSCase
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = FSCase.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* FSCase */
	LEFT JOIN vwAuditTrailStatEmployee FSCaseChangeEmployee ON FSCaseChangeEmployee.StatEmployeeID = FSCase.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson FSCaseChangePerson ON FSCaseChangePerson.PersonID = FSCaseChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType FSCaseChangeType ON FSCaseChangeType.AuditLogTypeID = FSCase.AuditLogTypeID
/* Secondary status */
	LEFT JOIN vwAuditTrailStatEmployee CaseOpenBy ON CaseOpenBy.StatEmployeeID = FSCase.FSCaseOpenUserID 
	LEFT JOIN vwAuditTrailPerson CaseOpenByPerson ON CaseOpenByPerson.PersonID = CaseOpenBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee SystemEventsBy ON SystemEventsBy.StatEmployeeID = FSCase.FSCaseSysEventsUserID 
	LEFT JOIN vwAuditTrailPerson SystemEventsByPerson ON SystemEventsByPerson.PersonID = SystemEventsBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee SecCompleteBy ON SecCompleteBy.StatEmployeeID = FSCase.FSCaseSecCompUserID 
	LEFT JOIN vwAuditTrailPerson SecCompleteByPerson ON SecCompleteByPerson.PersonID = SecCompleteBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee ApproachBy ON ApproachBy.StatEmployeeID = FSCase.FSCaseApproachUserID 
	LEFT JOIN vwAuditTrailPerson ApproachByPerson ON ApproachByPerson.PersonID = ApproachBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee FinalBy ON FinalBy.StatEmployeeID = FSCase.FSCaseFinalUserID 
	LEFT JOIN vwAuditTrailPerson FinalByPerson ON FinalByPerson.PersonID = FinalBy.PersonID
/* Secondary billing */
	LEFT JOIN vwAuditTrailStatEmployee BillSecondaryBy ON BillSecondaryBy.StatEmployeeID = FSCase.FSCaseBillSecondaryUserID 
	LEFT JOIN vwAuditTrailPerson BillSecondaryByPerson ON BillSecondaryByPerson.PersonID = BillSecondaryBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee BillOTEBy ON BillOTEBy.StatEmployeeID = FSCase.FSCaseBillOTEUserID 
	LEFT JOIN vwAuditTrailPerson BillOTEByPerson ON BillOTEByPerson.PersonID = BillOTEBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee BillFamUnavailBy ON BillFamUnavailBy.StatEmployeeID = FSCase.FSCaseBillFamUnavailUserID 
	LEFT JOIN vwAuditTrailPerson BillFamUnavailByPerson ON BillFamUnavailByPerson.PersonID = BillFamUnavailBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee BillApproachBy ON BillApproachBy.StatEmployeeID = FSCase.FSCaseBillApproachUserID 
	LEFT JOIN vwAuditTrailPerson BillApproachByPerson ON BillApproachByPerson.PersonID = BillApproachBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee BillMedSocBy ON BillMedSocBy.StatEmployeeID = FSCase.FSCaseBillMedSocUserID 
	LEFT JOIN vwAuditTrailPerson BillMedSocByPerson ON BillMedSocByPerson.PersonID = BillMedSocBy.PersonID
	LEFT JOIN vwAuditTrailStatEmployee BillCryoLifeBy ON BillCryoLifeBy.StatEmployeeID = FSCase.FSCaseBillCryoFormUserID 
	LEFT JOIN vwAuditTrailPerson BillCryoLifeByPerson ON BillCryoLifeByPerson.PersonID = BillCryoLifeBy.PersonID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	FSCase.CallID = @CallID
AND FSCase.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN FSCase.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	FSCaseChangePerson.PersonFirst + ' ' + FSCaseChangePerson.PersonLast AS 'ChangeUser',
	FSCaseChangeType.AuditLogTypeName AS 'ChangeType',
/* FSCaseOpen */
	NULL AS 'FSCaseOpenBy',
	NULL AS 'FSCaseOpenDateTime',
/* SystemEvents */
	NULL AS 'SystemEventsBy',
	NULL AS 'FSCaseSysEventsDateTime',
/* SecComplete */
	NULL AS 'SecCompleteBy',
	NULL AS 'FSCaseSecCompDateTime',
/* Approach */
	NULL AS 'ApproachBy',
	NULL AS 'FSCaseApproachDateTime',
/* Final */
	NULL AS 'FinalBy',
	NULL AS 'FSCaseFinalDateTime',
/* Bill Secondary */
	NULL AS 'BillSecondaryBy',
	NULL AS 'FSCaseBillDateTime',
/* Bill OTE */
	NULL AS 'BillOTEBy',
	NULL AS 'FSCaseBillOTEDateTime',
/* Bill FamUnavail */
	NULL AS 'BillFamUnavailBy',
	NULL AS 'FSCaseBillFamUnavailDateTime',
/* Bill Family Approach */
	NULL AS 'BillFamilyApproachBy',
	NULL AS 'BillFamilyApproachDateTime',
	NULL AS 'BillFamilyApproachCount',
/* Bill MedSoc */
	NULL AS 'BillMedSocBy',
	NULL AS 'FSCaseBillMedSocDateTime',
	NULL AS 'FSCaseBillMedSocCount',
/* Bill CryoLife */
	NULL AS 'BillCryoLifeBy',
	NULL AS 'FSCaseBillCryoFormDateTime',
	NULL AS 'FSCaseBillCryoFormCount'
FROM
	[Call]
	JOIN FSCase ON FSCase.CallID = [Call].CallID
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* FSCase */
	LEFT JOIN vwAuditTrailStatEmployee FSCaseChangeEmployee ON FSCaseChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson FSCaseChangePerson ON FSCaseChangePerson.PersonID = FSCaseChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType FSCaseChangeType ON FSCaseChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = @CallID
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Final Results */
SELECT *
FROM #FSInfo
WHERE
ChangeDT >= 
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

DROP TABLE IF EXISTS #FSInfo;