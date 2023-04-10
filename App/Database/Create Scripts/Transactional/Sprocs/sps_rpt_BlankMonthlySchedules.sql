IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_BlankMonthlySchedules')
BEGIN
	DROP PROCEDURE sps_rpt_BlankMonthlySchedules;
	PRINT 'sps_rpt_BlankMonthlySchedules';
END
GO
PRINT 'Creating Procedure: sps_rpt_BlankMonthlySchedules';
GO

CREATE PROCEDURE sps_rpt_BlankMonthlySchedules
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;
SET NOCOUNT ON;	
/*****************************************************************************
**	File: sps_rpt_BlankMonthlySchedules.sql
**	Name: sps_rpt_BlankMonthlySchedules
**	Desc: This report identifies the On-Call scedules that are missing or
**			incomplete for the upcoming month.
**
**	Auth: Jame Gerberich
**	Date: 04/08/2019
******************************************************************************
**	Change History
******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			--------------------------------------
**	04/08/2019		James Gereberich	Initial Release
******************************************************************************/

DECLARE
	@StartDate date = DATEADD(MONTH, 1, CAST(CAST(YEAR(GETDATE()) AS char(4)) + '-' + CAST(MONTH(GETDATE()) AS char(2)) + '-01' AS Date));
DECLARE
	@EndDate date = DATEADD(MONTH, 1, @StartDate);
----------------------------------------------------------------

SELECT DISTINCT
	org.OrganizationID,
	org.OrganizationName,
	sg.ScheduleGroupID,
	sg.ScheduleGroupName
FROM
	dbo.ScheduleGroup sg
	INNER JOIN
		(--This eliminates all organizations that have no Schedule Items for any Schedule Group
			Select Distinct sg1.OrganizationId, org1.OrganizationName
			From
				dbo.ScheduleGroup sg1
				INNER JOIN dbo.ScheduleItem si1 ON sg1.ScheduleGroupID = si1.ScheduleGroupID
				INNER JOIN dbo.Organization org1 ON sg1.OrganizationID = org1.OrganizationID
		) org ON sg.OrganizationID = org.OrganizationId
	/* while still including Schedule Groups that have no Schedule Items for organizations that
		have some groups with items.  This matches what is returned in the UI.*/
	LEFT JOIN dbo.ScheduleItem si
			LEFT JOIN dbo.ScheduleItemPerson sip ON si.ScheduleItemID = sip.ScheduleItemID
		ON sg.ScheduleGroupID = si.ScheduleGroupID
WHERE
	PATINDEX('%Not Use%',sg.ScheduleGroupName) = 0
AND	PATINDEX('%Unused%',sg.ScheduleGroupName) = 0
AND	PATINDEX('%NotUsed%',sg.ScheduleGroupName) = 0
AND	PATINDEX('zzz%',ScheduleGroupName) = 0
AND	(
		si.ScheduleGroupID IS NULL --Group has no items at all
	OR	(--Group has items in the date range, but no contacts are assigned
			si.ScheduleGroupID IS NOT NULL
		AND	si.ScheduleItemStartDate > @StartDate
		AND	si.ScheduleItemEndDate < @EndDate
		AND	sip.PersonID IS NULL
		)
	)
UNION
--The schedule is missing or incomplete for the month
Select Distinct
	org.OrganizationID,
	org.OrganizationName,
	sg.ScheduleGroupID,
	sg.ScheduleGroupName
From
	dbo.ScheduleItem si
	INNER JOIN dbo.ScheduleGroup sg
			LEFT JOIN dbo.Organization org ON sg.OrganizationID = org.OrganizationID
		ON si.ScheduleGroupID = sg.ScheduleGroupID
			AND	PATINDEX('%Not Use%',sg.ScheduleGroupName) = 0
			AND	PATINDEX('%Unused%',sg.ScheduleGroupName) = 0
			AND	PATINDEX('%NotUsed%',sg.ScheduleGroupName) = 0
			AND	PATINDEX('zzz%',ScheduleGroupName) = 0
Group By
	org.OrganizationID,
	org.OrganizationName,
	sg.ScheduleGroupID,
	sg.ScheduleGroupName
Having
	MAX(si.ScheduleItemEndDate) < @EndDate
Order By
	org.OrganizationName,
	sg.ScheduleGroupName;