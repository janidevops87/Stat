SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_WebUser    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_WebUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_WebUser]
GO




CREATE PROCEDURE spi_WebUser
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null

AS

If @vEmail IS NOT NULL AND @vPwd IS NOT NULL
BEGIN
	IF NOT EXISTS(SELECT email FROM webuser WHERE email=@vEmail)
	BEGIN
		INSERT INTO WebUser
		Select @vEmail, @vPwd, 0, 0
	END
	ELSE
	PRINT 'EMAIL EXISTS'
	SELECT 0,0,0,0
END


















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

