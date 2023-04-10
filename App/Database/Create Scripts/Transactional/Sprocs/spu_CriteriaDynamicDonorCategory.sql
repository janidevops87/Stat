SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_CriteriaDynamicDonorCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_CriteriaDynamicDonorCategory]
GO


CREATE PROCEDURE spu_CriteriaDynamicDonorCategory 

     @CriteriaID int,
     @DynamicDonorCategoryID int

AS

--to update table criteria with DynamicDonorCategoryID, pass CriteriaID and DynamicDonorCategoryID

     UPDATE Criteria
     SET DynamicDonorCategoryID = @DynamicDonorCategoryID
     WHERE CriteriaID = @CriteriaID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

