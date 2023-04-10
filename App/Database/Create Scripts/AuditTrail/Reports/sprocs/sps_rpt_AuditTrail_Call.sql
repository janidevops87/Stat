IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Call')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Call';
		DROP  PROCEDURE  sps_rpt_AuditTrail_Call;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Call';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_Call
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Call.sql
**		Name: sps_rpt_AuditTrail_Call
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 07/19/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**      07/19/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, corrected Incomplete and Exclusive
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #CallInfo;


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
/*** Call *** - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	CASE [Call].CallExtension
		WHEN -2
		THEN 'ILB'
		ELSE [Call].CallExtension
	END AS 'UserExtension',
	[Call].CallTotalTime AS 'Timer',
	CASE [Call].CallTemp
		WHEN 0 THEN 'No'
		WHEN -1 THEN 'Yes'
	END AS 'Incomplete',
	CASE [Call].CallTempExclusive
		WHEN 0 THEN 'No'
		WHEN -1 THEN 'Yes'
	END AS 'Exclusive',
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].CallDateTime, @DisplayMT) AS 'CallDateTime',	
	RefReferral.ReferralCallerOrganizationID ,
	[Call].CallSaveLastByID,
	[Call].AuditLogTypeID,
	[Call].SourceCodeID,
	[Call].StatEmployeeID
INTO #CallInfo
FROM
	[Call]
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	[Call].CallID = @CallID
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Final Results */
SELECT
	r.ChangeDT,
	CallChangePerson.PersonFirst + ' ' + CallChangePerson.PersonLast AS 'ChangeUser',
	CallChangeType.AuditLogTypeName AS 'ChangeType',
	CASE r.StatEmployeeID
		WHEN -2
		THEN 'ILB'
		ELSE CallStatPerson.PersonFirst + ' ' + CallStatPerson.PersonLast
	END AS 'User',
	r.UserExtension,
	r.Timer,
	r.Incomplete,
	r.Exclusive,
	r.CallDateTime,
	CASE r.SourceCodeID
		WHEN -2
		THEN 'ILB'
		ELSE CallSourceCode.SourceCodeName
	END AS 'SourceCode'
FROM
	#CallInfo r
	LEFT JOIN vwAuditTrailStatEmployee CallChangeEmployee ON CallChangeEmployee.StatEmployeeID = r.CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson CallChangePerson ON CallChangePerson.PersonID = CallChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType CallChangeType ON CallChangeType.AuditLogTypeID = r.AuditLogTypeID
	LEFT JOIN vwAuditTrailSourceCode CallSourceCode ON CallSourceCode.SourceCodeID = r.SourceCodeID 
	LEFT JOIN vwAuditTrailStatEmployee CallStatEmployee ON CallStatEmployee.StatEmployeeID = r.StatEmployeeID 
	LEFT JOIN vwAuditTrailPerson CallStatPerson ON CallStatPerson.PersonID = CallStatEmployee.PersonID 
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

DROP TABLE IF EXISTS #CallInfo;