SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_PermissionByWebPersonID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_PermissionByWebPersonID]
GO


CREATE PROCEDURE  SPS_PermissionByWebPersonID
                  @WEBPERSONID       int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @WEBPERSONID IS NOT NULL
BEGIN
	SELECT Permission.*
	FROM permission, webpersonpermission
	WHERE WebPersonPermission.webpersonid=@WEBPERSONID
	AND WebPersonPermission.Permissionid=Permission.PermissionID
	AND Permission.Active=1
	ORDER BY PERMISSIONNAME
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

