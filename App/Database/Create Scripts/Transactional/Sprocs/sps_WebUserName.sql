SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserName]
GO


CREATE PROCEDURE sps_WebUserName
		@vUserName 		Varchar(500)= ''
AS

If @vUserName <> ''
BEGIN
	SELECT @vUserName =replace(@vUserName, '*', '%')

	SELECT * FROM webperson, person, organization
	WHERE WebPersonUserName like @vUserName
	AND person.personid=webperson.personid
	AND person.organizationid=organization.organizationid
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

