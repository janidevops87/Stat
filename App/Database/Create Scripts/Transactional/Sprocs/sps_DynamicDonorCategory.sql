SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DynamicDonorCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DynamicDonorCategory]
GO

-- sps_DynamicDonorCategory 119

CREATE PROCEDURE sps_DynamicDonorCategory 
     
     @CriteriaID int =NULL,
     @DynamicDonorCategoryName varchar(50) =null,
     @DynamicDonorCategoryID int =null
     
AS
--to select donor category mappings, pass OrganizationID, receive DonorCategoryID, DonorCategoryName, OrganizationID

If @CriteriaID is null AND @DynamicDonorCategoryName IS NULL AND @DynamicDonorCategoryID IS NULL
     Begin

     SELECT     DynamicDonorCategoryID, DynamicDonorCategoryName
     FROM       DynamicDonorCategory

     End
Else IF @DynamicDonorCategoryName IS NULL AND @DynamicDonorCategoryID IS NULL
     Begin

     SELECT    DISTINCT
               Criteria.DynamicDonorCategoryID,
               DynamicDonorCategoryName

     FROM      Criteria 
     JOIN      DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID

     WHERE     Criteria.CriteriaID = @CriteriaID

     end
Else IF @CriteriaID IS NULL AND @DynamicDonorCategoryID IS NULL
     Begin

     SELECT    DISTINCT 
               DynamicDonorCategoryID,
               DynamicDonorCategoryName

     FROM      DynamicDonorCategory 
     WHERE     DynamicDonorCategoryName = @DynamicDonorCategoryName

     end
Else IF @CriteriaID IS NULL AND @DynamicDonorCategoryName IS NULL
Begin

     SELECT    DISTINCT 
               DynamicDonorCategoryID,
               DynamicDonorCategoryName

     FROM      DynamicDonorCategory 
     WHERE     DynamicDonorCategoryID = @DynamicDonorCategoryID

     end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

