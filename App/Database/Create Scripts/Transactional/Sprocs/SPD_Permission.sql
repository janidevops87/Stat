SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_Permission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_Permission]
GO


CREATE PROCEDURE  SPD_Permission
                  @PERMISSIONID                 int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    DELETE        Permission
    WHERE         PERMISSIONID                 = @PERMISSIONID



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

