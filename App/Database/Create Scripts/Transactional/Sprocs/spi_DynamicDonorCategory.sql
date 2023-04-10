SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_DynamicDonorCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_DynamicDonorCategory]
GO


CREATE PROCEDURE spi_DynamicDonorCategory 

     @DynamicDonorCategoryName AS varchar(50)
     
AS

--to add new Dynamic Donor Categories, pass new Dynamic Name.

     INSERT DynamicDonorCategory (DynamicDonorCategoryName)
     VALUES(@DynamicDonorCategoryName)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

