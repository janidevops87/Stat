SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ProcurementAgencyNotified]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ProcurementAgencyNotified]
GO


CREATE PROCEDURE sps_ProcurementAgencyNotified 

	@OrgID 		int 	= 0,
	@DonorCategoryID 	int	= 0


AS

IF @DonorCategoryID = 0

	SELECT Criteria.DonorCategoryID, Organization.OrganizationID, Organization.OrganizationName

	FROM Criteria
	JOIN CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	JOIN CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID 
	JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
	JOIN ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	JOIN Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID

	WHERE CriteriaOrganization.OrganizationID = @OrgID
	AND ScheduleGroupOrganization.OrganizationID = @OrgID

	ORDER BY Criteria.DonorCategoryID

IF @DonorCategoryID > 0
	
	SELECT Organization.OrganizationID, Organization.OrganizationName

	FROM Criteria
	JOIN CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	JOIN CriteriaScheduleGroup ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID 
	JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID
	JOIN ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	JOIN Organization ON Organization.OrganizationID = ScheduleGroup.OrganizationID

	WHERE CriteriaOrganization.OrganizationID = @OrgID
	AND ScheduleGroupOrganization.OrganizationID = @OrgID
	AND Criteria.DonorCategoryID = @DonorCategoryID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

