IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportScheduleGroupsDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportScheduleGroupsDropDown';
		DROP Procedure sps_ReportScheduleGroupsDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportScheduleGroupsDropDown';
GO


CREATE Procedure [dbo].[sps_ReportScheduleGroupsDropDown]

     @OrganizationId int = null
AS
/******************************************************************************
**	File: sps_ReportScheduleGroupsDropDown.sql
**	Name: sps_ReportScheduleGroupsDropDown
**	Desc: Populates dropdown for schedule groups in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/02/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/02/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/


SELECT	ScheduleGroupID as [value],
		ScheduleGroupName as [label]
FROM    ScheduleGroup
WHERE   OrganizationID = @OrganizationId
ORDER BY
        ScheduleGroupName;


GO

GRANT EXEC ON sps_ReportScheduleGroupsDropDown TO PUBLIC;
GO

