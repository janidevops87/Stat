IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_SecondaryTBI')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_SecondaryTBI';
		DROP  PROCEDURE  sps_rpt_AuditTrail_SecondaryTBI;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_SecondaryTBI';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_SecondaryTBI
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_SecondaryTBI.sql
**		Name: sps_rpt_AuditTrail_SecondaryTBI
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
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/08/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality in update sproc
**		11/05/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #TBIInfo;


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
/* SecondaryTBI * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, SecondaryTBI.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	SecondaryTBIChangePerson.PersonFirst + ' ' + SecondaryTBIChangePerson.PersonLast AS 'ChangeUser',
	SecondaryTBIChangeType.AuditLogTypeName AS 'ChangeType',
	SecondaryTBI.SecondaryTBINumber,
	TBINotNeeded.YesNoNa_RefName AS 'AssignmentNotNeeded',
	SecondaryTBI.SecondaryTBIComment
INTO #TBIInfo
FROM
	SecondaryTBI
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = SecondaryTBI.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryTBIChangeEmployee ON SecondaryTBIChangeEmployee.StatEmployeeID = SecondaryTBI.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryTBIChangePerson ON SecondaryTBIChangePerson.PersonID = SecondaryTBIChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryTBIChangeType ON SecondaryTBIChangeType.AuditLogTypeID = SecondaryTBI.AuditLogTypeID
/* Yes No NA lookups */
	LEFT JOIN vwAuditTrailYesNoNa_Ref AS TBINotNeeded ON TBINotNeeded.YesNoNa_RefID = SecondaryTBI.SecondaryTBIAssignmentNotNeeded
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	SecondaryTBI.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND SecondaryTBI.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN SecondaryTBI.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	SecondaryTBIChangePerson.PersonFirst + ' ' + SecondaryTBIChangePerson.PersonLast AS 'ChangeUser',
	SecondaryTBIChangeType.AuditLogTypeName AS 'ChangeType',
	NULL AS 'SecondaryTBINumber',
	NULL AS 'AssignmentNotNeeded',
	NULL AS 'SecondaryTBIComment'
FROM
	[Call]
	JOIN SecondaryTBI ON SecondaryTBI.CallID = [Call].CallID
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* SecondaryTBI Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryTBIChangeEmployee ON SecondaryTBIChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson SecondaryTBIChangePerson ON SecondaryTBIChangePerson.PersonID = SecondaryTBIChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryTBIChangeType ON SecondaryTBIChangeType.AuditLogTypeID = [Call].AuditLogTypeID
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
FROM #TBIInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[SecondaryTBINumber] IS NOT NULL
	OR	[AssignmentNotNeeded] IS NOT NULL
	OR	[SecondaryTBIComment] IS NOT NULL
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


DROP TABLE IF EXISTS #TBIInfo;