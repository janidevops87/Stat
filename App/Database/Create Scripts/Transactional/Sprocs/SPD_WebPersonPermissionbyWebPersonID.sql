SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_WebPersonPermissionbyWebPersonID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_WebPersonPermissionbyWebPersonID]
GO


CREATE PROCEDURE  SPD_WebPersonPermissionbyWebPersonID
                  @WEBPERSONID        int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @WEBPERSONID IS NOT NULL
BEGIN
    DELETE        WebPersonPermission
    WHERE         WEBPERSONID        = @WEBPERSONID
END


    SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRetcode <> 0 RETURN @intRetcode

    IF @intRowCount = 0
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

