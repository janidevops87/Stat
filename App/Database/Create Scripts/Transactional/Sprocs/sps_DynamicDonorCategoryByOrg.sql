SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DynamicDonorCategoryByOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DynamicDonorCategoryByOrg]
GO


CREATE PROCEDURE sps_DynamicDonorCategoryByOrg

     @OrganizationID int =null

AS

     SELECT    DISTINCT
               DonorCategoryID,
               DynamicDonorCategoryName

     FROM      Criteria 

     JOIN      CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
     JOIN      CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
     JOIN      DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID

     WHERE     OrganizationID= @OrganizationID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

