IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_FixWebReportGroupMaster')
	BEGIN
		PRINT 'Dropping Procedure sp_FixWebReportGroupMaster';
		DROP Procedure sp_FixWebReportGroupMaster;
	END
GO

PRINT 'Creating Procedure sp_FixWebReportGroupMaster';
GO
CREATE Procedure sp_FixWebReportGroupMaster
AS
/******************************************************************************
**	File: sp_FixWebReportGroupMaster.sql
**	Name: sp_FixWebReportGroupMaster
**	Desc: Executed by a SQL Job to provide backwards compatability
**		StatTrac Saves WebReportGroupMaster with a -1 
**		This code will change -1 to 1 if it exists. 
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
*******************************************************************************/

-- StatTrac Saves WebReportGroupMaster with a -1 
-- This code will change -1 to 1 if it exists. 

	update webreportgroup
	set WebreportgroupMaster = 1, -- flag as master
		LastModified = webreportgroup.LastModified,
		LastStatEmployeeID = webreportgroup.LastStatEmployeeID 
	where WebReportGroupID in (
		select top(100)  WebReportGroupID 
		from webreportgroup
		join Organization on WebReportGroup.OrgHierarchyParentID = organization.organizationID
		where WebreportgroupMaster = -1);

GO
GRANT EXEC ON sp_FixWebReportGroupMaster TO PUBLIC;
GO
