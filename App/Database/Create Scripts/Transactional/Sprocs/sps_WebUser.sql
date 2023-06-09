SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUser]
GO


CREATE PROCEDURE sps_WebUser
		@Access 		INT	= 0
AS
SET NOCOUNT ON
If @Access <> 0
BEGIN
	SELECT * FROM webperson, person, organization
	WHERE access & @Access <> 0	
	AND person.personid=webperson.personid
	AND person.organizationid=organization.organizationid
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

