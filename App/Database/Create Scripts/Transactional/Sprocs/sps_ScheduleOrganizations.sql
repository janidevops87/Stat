SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ScheduleOrganizations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ScheduleOrganizations]
GO


-- sps_ScheduleOrganizations 50
CREATE Procedure sps_ScheduleOrganizations 

     @vUserOrgID	int		= null

AS
/******************************************************************************
**		File: sps_ScheduleOrganizations.sql
**		Name: sps_ScheduleOrganizations
**		Desc: 
**
** 
**		Called by:   
**			Called from Schedule Update and Schdule Lookup Report Params
**              
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		7/19/08		Bret Knoll			Updated from sps_ScheduleOrganizations1, Transaction Level
**		10/17/08	Bret Knoll			Reduced Orgs to where scheduleGroup Exists wi 2114
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

If ISNULL(@vUserOrgID, 0) = 0
BEGIN 
	Select @vUserOrgID = 194 
END


IF	@vUserOrgID = 194

     BEGIN
     
          SELECT DISTINCT	Organization.OrganizationID, OrganizationName
          FROM		Organization
			WHERE 	
				OrganizationID in (select ScheduleGroup.OrganizationID from ScheduleGroup JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID )
          ORDER BY	OrganizationName
     END

ELSE
     BEGIN
          SELECT DISTINCT	Organization.OrganizationID, OrganizationName
          FROM		Organization
          JOIN            WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID
          WHERE           
			  OrgHierarchyParentID = @vUserOrgID
		  AND 
		  OrganizationID in (select ScheduleGroup.OrganizationID from ScheduleGroup JOIN ScheduleItem ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID )
			  
          ORDER BY	OrganizationName
     END     








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

