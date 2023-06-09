SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CODVerifyLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CODVerifyLogin]
GO





CREATE  PROCEDURE sps_CODVerifyLogin (@userId varchar(15), @pwd varchar(15))
/*
   Verifies login of WebUser 'CODSPAN' 
   If the password matches, returns SUCCESS = 'Y'.  If no match, Returns SUCCESS = 'N'
   Created for use in COD_Call_Track.sls  3/30/05 by Scott Plummer.

   ccarroll 07/21/2006 - Changed WebPersonUserName to DLASPAN - was CODSPAN  

*/
AS

SET NOCOUNT ON

DECLARE @iRtn integer

SET @iRtn = (SELECT Count(*) FROM WebPerson WHERE WebPersonUserName = 'DLASPAN' AND WebPersonPassword = @pwd);

IF @iRtn > 0 
	BEGIN
		SELECT 'Y' AS Success;
	END
ELSE
	BEGIN
		SELECT 'N' AS Success;
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

