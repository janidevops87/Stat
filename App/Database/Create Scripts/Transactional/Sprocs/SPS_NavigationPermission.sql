SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_NavigationPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_NavigationPermission]
GO


CREATE PROCEDURE  SPS_NavigationPermission
                 @WebPersonID            int =NULL,
                 @NavTypeID            int =1
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @WebPersonID IS NOT NULL 
BEGIN
	SELECT Navigation.*
	FROM navigation, permission, webpersonpermission
	WHERE WebPersonPermission.webpersonid=@WebPersonID
	AND WebPersonPermission.Permissionid=Permission.PermissionID
	AND Permission.PermissionTypeID=1
	AND Permission.Active=1
	AND Permission.FunctionID=Navigation.NavID
	AND Navigation.NavTypeID=@NavTypeID
	AND Navigation.Active=1
	ORDER BY navigation.seq
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

