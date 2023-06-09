SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ScheduleOrganizations1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ScheduleOrganizations1]
GO




-- sps_ScheduleOrganizations 50
CREATE  Procedure sps_ScheduleOrganizations1 

     @vUserOrgID	int		= null

AS

If @vUserOrgID is null Begin Select @vUserOrgID = 194 End


IF	@vUserOrgID = 194

     BEGIN
          SELECT DISTINCT	Organization.OrganizationID, OrganizationName
          FROM		Organization
          JOIN            ScheduleGroup ON ScheduleGroup.OrganizationID = Organization.OrganizationID
          LEFT JOIN       ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
          --WHERE           OrganizationTypeID = 1
          ORDER BY	OrganizationName
     END

ELSE
     BEGIN
          SELECT DISTINCT	Organization.OrganizationID, OrganizationName
          FROM		Organization
          JOIN            ScheduleGroup ON ScheduleGroup.OrganizationID = Organization.OrganizationID
          LEFT JOIN       ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
          JOIN            WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID
          WHERE           
	  --bjk 12/19/03 OrganizationTypeID = 1          AND             
	  OrgHierarchyParentID = @vUserOrgID
          ORDER BY	OrganizationName
     END     








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

