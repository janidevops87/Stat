SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_WebPersonPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_WebPersonPermission]
GO


CREATE PROCEDURE  SPS_WebPersonPermission
                  @WEBPERSONPERMISSIONID        int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    SELECT
                  WEBPERSONPERMISSIONID ,
                  ISNULL(WEBPERSONID,0) WEBPERSONID,
                  ISNULL(PERMISSIONID,0) PERMISSIONID
    FROM          WebPersonPermission
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

