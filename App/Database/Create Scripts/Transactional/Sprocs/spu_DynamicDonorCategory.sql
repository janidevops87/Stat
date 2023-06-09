SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DynamicDonorCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_DynamicDonorCategory]
GO


CREATE PROCEDURE spu_DynamicDonorCategory 

     @DynamicDonorCategoryID int,
     @DynamicDonorCategoryName varchar(50)


AS

     UPDATE  DynamicDonorCategory
     SET     DynamicDonorCategoryName = @DynamicDonorCategoryName
     WHERE   DynamicDonorCategoryID = @DynamicDonorCategoryID
--to update Dynamic Donor Categories, pass Corrected Dynamic Name and ID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

