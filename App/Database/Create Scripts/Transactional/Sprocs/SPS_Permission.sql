SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_Permission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_Permission]
GO


CREATE PROCEDURE  SPS_Permission
                  @PERMISSIONID                 int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @PERMISSIONID IS NOT NULL
BEGIN
    SELECT
                  PERMISSIONID ,
                  PERMISSIONNAME,
                  ISNULL(PERMISSIONTYPEID,0) PERMISSIONTYPEID,
                  ISNULL(FUNCTIONID,0) FUNCTIONID,
                  PERMISSIONDESCRIPTION,
                  ISNULL(ACTIVE,0) ACTIVE
    FROM          Permission
    WHERE         PERMISSIONID                 = @PERMISSIONID
ORDER BY PERMISSIONNAME
END
ELSE
BEGIN
SELECT * FROM Permission
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

