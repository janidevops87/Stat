SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DynamicDonorCategoryByOrg1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DynamicDonorCategoryByOrg1]
GO



CREATE PROCEDURE sps_DynamicDonorCategoryByOrg1

     @vOrganizationID int =null,
     @vSourceCodeName varchar(20) = null

AS

     SELECT    DISTINCT
               DonorCategoryID,
               DynamicDonorCategoryName

     FROM      Criteria 

     JOIN      CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
     JOIN   SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
     JOIN      CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
     JOIN      DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID

     WHERE     OrganizationID= @vOrganizationID
     AND 	SourceCode.SourceCodeName = @vSourceCodeName



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

