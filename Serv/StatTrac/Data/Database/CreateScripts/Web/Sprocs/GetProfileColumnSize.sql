SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetProfileColumnSize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetProfileColumnSize]
GO





CREATE PROCEDURE dbo.GetProfileColumnSize
	@profileSize int OUT
AS

SELECT @profileSize = CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.Columns 
WHERE 
	TABLE_NAME = 'Profiles' AND
	COLUMN_NAME = 'Profile'





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

