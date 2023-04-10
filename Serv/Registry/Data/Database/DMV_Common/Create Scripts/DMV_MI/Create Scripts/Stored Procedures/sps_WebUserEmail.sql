
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  Stored Procedure dbo.sps_WebUserEmail    Script Date: 08/12/2010 14:20:38 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserEmail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserEmail]
GO

/****** HS 24855 ccarroll SQL2008 incompatibility issue 08/12/2010 ****/

CREATE PROCEDURE [dbo].[sps_WebUserEmail] (@vEmail   Varchar(500)= '')
/* Searches for users by email.  Modified 2/21/05 by Scott Plummer to exclude 
  disabled users (those with a pwd of 'seeya'). */
AS

IF @vEmail <> ''
   BEGIN
	SELECT @vEmail =replace(@vEmail, '*', '%'); -- Fix wildcards

	SELECT * FROM webuser --, registry
	WHERE email like @vEmail
	AND pwd <> 'seeya'
	--AND webuser.RegistryID *= registry.ID;
   END
GO


