SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_WebPersonPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_WebPersonPermission]
GO


CREATE PROCEDURE  SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        int OUTPUT ,
                  @WEBPERSONID                  int ,
                  @PERMISSIONID                 int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        WebPersonPermission (
                  WEBPERSONID ,
                  PERMISSIONID
                  )
    SELECT
                  @WEBPERSONID ,
                  @PERMISSIONID


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @WEBPERSONPERMISSIONID = @intIdentity

RETURN @intRetCode



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

