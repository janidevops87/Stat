SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_WebPersonPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_WebPersonPermission]
GO


CREATE PROCEDURE  SPU_WebPersonPermission
                  @WEBPERSONPERMISSIONID        int ,
                  @WEBPERSONID                  int ,
                  @PERMISSIONID                 int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        WebPersonPermission
    SET
                  WEBPERSONID                  = @WEBPERSONID ,
                  PERMISSIONID                 = @PERMISSIONID
    WHERE         WEBPERSONPERMISSIONID        = @WEBPERSONPERMISSIONID


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

