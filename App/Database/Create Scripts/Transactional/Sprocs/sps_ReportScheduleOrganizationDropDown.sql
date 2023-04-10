IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportScheduleOrganizationDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportScheduleOrganizationDropDown';
		DROP Procedure sps_ReportScheduleOrganizationDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportScheduleOrganizationDropDown';
GO


CREATE Procedure [dbo].[sps_ReportScheduleOrganizationDropDown] 

     @OrganizationId int = null

AS
/******************************************************************************
**	File: sps_ReportScheduleOrganizationDropDown.sql
**	Name: sps_ReportScheduleOrganizationDropDown
**	Desc: Populates dropdown for schedule organizations in reporting.
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

If ISNULL(@OrganizationId, 0) = 0
BEGIN 
	Select @OrganizationId = 194 
END


IF	@OrganizationId = 194

     BEGIN
     
          SELECT DISTINCT	
            Organization.OrganizationID as [value], 
            OrganizationName as [label]
          FROM		Organization
			WHERE 	
				OrganizationID in (select ScheduleGroup.OrganizationID from ScheduleGroup JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID )
          ORDER BY	OrganizationName;
     END

ELSE
     BEGIN
          SELECT DISTINCT	
            Organization.OrganizationID as [value], 
            OrganizationName as [label]
          FROM		Organization
          JOIN            WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID
          WHERE           
			  OrgHierarchyParentID = @OrganizationId
		  AND 
		  OrganizationID in (select ScheduleGroup.OrganizationID from ScheduleGroup JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID )
          ORDER BY	OrganizationName;
     END     


GO

GRANT EXEC ON sps_ReportScheduleOrganizationDropDown TO PUBLIC;
GO

