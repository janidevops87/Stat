SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_FunctionsPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_FunctionsPermission]
GO


CREATE PROCEDURE  SPS_FunctionsPermission
	@USERID                 	int=NULL,
             @FUNCTIONID              	int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @USERID IS NOT NULL
BEGIN
	IF @FUNCTIONID IS NOT NULL
	BEGIN
		SELECT * 
		FROM functions
		WHERE FUNCTIONID=@FUNCTIONID
		AND FUNCTIONID IN 	(
					SELECT functionID
					FROM permission, webpersonpermission
					WHERE webpersonid=@USERID
					AND webpersonpermission.permissionid=permission.permissionid
					AND permission.permissiontypeid=4
					)
	END
	ELSE
	BEGIN
		SELECT * 
		FROM functions
		WHERE FUNCTIONID IN (
					SELECT functionID
					FROM permission, webpersonpermission
					WHERE webpersonid=@USERID
					AND webpersonpermission.permissionid=permission.permissionid
					AND permission.permissiontypeid=4
					)
	END
END

    SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN

--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

RETURN @intRetCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

