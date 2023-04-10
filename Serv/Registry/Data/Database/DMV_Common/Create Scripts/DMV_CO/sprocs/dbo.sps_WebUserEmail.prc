SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserEmail    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserEmail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserEmail]
GO




CREATE PROCEDURE sps_WebUserEmail
		@vEmail 		Varchar(500)= ''
AS

If @vEmail <> ''
BEGIN
	SELECT @vEmail =replace(@vEmail, '*', '%')

	SELECT * FROM webuser, registry
	WHERE email like @vEmail
	AND webuser.RegistryID *= registry.ID

--	SELECT * FROM webuser
--	WHERE email like @vEmail
END






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

