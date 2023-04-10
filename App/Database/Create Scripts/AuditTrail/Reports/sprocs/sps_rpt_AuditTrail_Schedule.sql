IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Schedule')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Schedule';
		DROP  PROCEDURE  sps_rpt_AuditTrail_Schedule;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Schedule';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_Schedule
(	
	@ScheduleOrganization	int,
	@ScheduleGroupID		int,
	@ChangeStartDateTime	datetime,
	@ChangeEndDateTime		datetime,
	@UserOrgID				int,
	@DisplayMT				int		
)
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Schedule.sql
**		Name: sps_rpt_AuditTrail_Schedule
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
**		Auth: James Gerberich
**		Date: 03/30/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		03/30/2021		James Gerberich			Initial version TFS 72881
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--Make sure database is clean of temp tables
DROP TABLE IF EXISTS #OrgGrp;
--------------------------------

--If Start and End date are the same we will search all dates
IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SET @ChangeStartDateTime = NULL;
		SET @ChangeEndDateTime = NULL;
	END;
--------------------------------

-- Determine TimeZoneOffset
DECLARE
	@OrganizationTimeZone	AS VARCHAR(2)	= _ReferralProdReport.dbo.fn_GetOrganizationTimeZone (@ScheduleOrganization),
	@TimeZoneOffset			AS INT;

IF @DisplayMT = 1
	BEGIN
		SET @TimeZoneOffset = 0;
	END
ELSE
	BEGIN
		SET @TimeZoneOffset = dbo.AuditTrailfn_TimeZoneDifference (@OrganizationTimeZone, GETDATE());
	END;
----------------------------------------------------------------

-- Get organization and schedule names
SELECT
	org.OrganizationID,
	sg.ScheduleGroupID,
	org.OrganizationName + ': ' + sg.ScheduleGroupName AS ScheduleName
INTO #OrgGrp
FROM
	dbo.vwAuditTrailOrganization org
	INNER JOIN dbo.vwAuditTrailScheduleGroup sg ON org.OrganizationID = sg.OrganizationID
WHERE
	org.OrganizationID = @ScheduleOrganization
AND	sg.ScheduleGroupID = @ScheduleGroupID;
----------------------------------------------------------------

SELECT
	'Schedule' AS Item,
	og.ScheduleName,
	atsi.ScheduleItemID,
	ISNULL(atsi.ScheduleItemName, si.ScheduleItemName) AS [Shift],
	CONVERT(varchar(10), dbo.AuditTrailfn_rpt_ConvertDateTime(@ScheduleOrganization, (atsi.ScheduleItemStartDate + IsNULL(atsi.ScheduleItemStartTime, '')), @DisplayMT), 101) AS ScheduleStartDate,
	CONVERT(varchar(5), DATEADD(hh, @TimezoneOffset, CAST(atsi.ScheduleItemStartTime AS time)), 108) AS ScheduleStartTime,
	CONVERT(varchar(10), dbo.AuditTrailfn_rpt_ConvertDateTime(@ScheduleOrganization, (atsi.ScheduleItemEndDate + IsNULL(atsi.ScheduleItemEndTime, '')), @DisplayMT), 101) AS ScheduleEndDate,
	CONVERT(varchar(5), DATEADD(hh, @TimezoneOffset, CAST(atsi.ScheduleItemEndTime AS time)), 108) AS ScheduleEndTime,
	NULL AS ScheduleItemPersonID,
	NULL AS OnCall,
	NULL AS [Priority],
	dbo.AuditTrailfn_rpt_ConvertDateTime(@ScheduleOrganization, atsi.LastModified, @DisplayMT) AS ChangeDT,
	IsNULL(p.PersonFirst, '') + IsNULL(' ' + p.PersonLast, '') AS LastUpdateUser,
	aTyp.AuditLogTypeName AS ChangeType
FROM
	dbo.ScheduleItem atsi
	INNER JOIN #OrgGrp og ON atsi.ScheduleGroupID = og.ScheduleGroupID
	LEFT JOIN dbo.vwAuditTrailScheduleItem si ON atsi.ScheduleItemID = si.ScheduleItemID
	INNER JOIN vwAuditTrailWebPerson wp
				INNER JOIN vwAuditTrailPerson p ON p.PersonID = wp.PersonID
			ON atsi.LastWebPersonID = wp.WebPersonID
	INNER JOIN vwAuditTrailAuditLogType aTyp ON atsi.AuditLogTypeID = aTyp.AuditLogTypeId
WHERE
	(
		@ChangeStartDateTime IS NULL
	OR	atsi.LastModified >= @ChangeStartDateTime
	)
AND	(
		@ChangeEndDateTime IS NULL
	OR	atsi.LastModified <= @ChangeEndDateTime
	)
UNION
SELECT
	'Person' AS Item,
	NULL AS ScheduleName,
	atsip.ScheduleItemID,
	NULL AS [Shift],
	NULL AS ScheduleStartDate,
	NULL AS ScheduleStartTime,
	NULL AS ScheduleEndDate,
	NULL AS ScheduleEndTime,
	atsip.ScheduleItemPersonID,
	per.PersonFirst + ' ' + per.PersonLast AS OnCall,
	atsip.[Priority],
	dbo.AuditTrailfn_rpt_ConvertDateTime(@ScheduleOrganization, atsip.LastModified, @DisplayMT) AS ChangeDT,
	IsNULL(p.PersonFirst, '') + IsNULL(' ' + p.PersonLast, '') AS LastUpdateUser,
	aTyp.AuditLogTypeName AS ChangeType
FROM
	dbo.ScheduleItemPerson atsip
	INNER JOIN (
				select distinct ScheduleItemID
				from dbo.ScheduleItem
				where ScheduleGroupID = @ScheduleGroupID
				) si
		ON atsip.ScheduleItemID = si.ScheduleItemID
	LEFT JOIN vwAuditTrailPerson per ON atsip.PersonID = per.PersonID
	INNER JOIN vwAuditTrailWebPerson wp
				INNER JOIN vwAuditTrailPerson p ON p.PersonID = wp.PersonID
			ON atsip.LastWebPersonID = wp.WebPersonID
	INNER JOIN vwAuditTrailAuditLogType aTyp ON atsip.AuditLogTypeID = aTyp.AuditLogTypeId
WHERE
	(
		@ChangeStartDateTime IS NULL
	OR	atsip.LastModified >= @ChangeStartDateTime
	)
AND	(
		@ChangeEndDateTime IS NULL
	OR	atsip.LastModified <= @ChangeEndDateTime
	)
AND	(
		atsip.PersonID IS NOT NULL
	OR	atsip.AuditLogTypeID = 4 -- Delete
	)
ORDER BY
	ScheduleItemID,
	Item desc,
	[Priority],
	ChangeDT;
