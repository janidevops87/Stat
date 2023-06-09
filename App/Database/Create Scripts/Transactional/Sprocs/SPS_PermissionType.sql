SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_PermissionType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_PermissionType]
GO


CREATE PROCEDURE  SPS_PermissionType
                  @PERMISSIONTYPEID          int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @PERMISSIONTYPEID IS NOT NULL
BEGIN
    SELECT
                  PERMISSIONTYPEID ,
                  PERMISSIONTYPENAME
    FROM          PermissionType
    WHERE         PERMISSIONTYPEID          = @PERMISSIONTYPEID
END
ELSE
BEGIN
	SELECT * FROM PermissionType
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

