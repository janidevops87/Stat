SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_Permission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_Permission]
GO


CREATE PROCEDURE  SPU_Permission
                  @PERMISSIONID                 int ,
                  @PERMISSIONNAME               varchar(500) ,
                  @PERMISSIONTYPEID             int ,
                  @FUNCTIONID                   int ,
                  @PERMISSIONDESCRIPTION        varchar(1000) ,
                  @ACTIVE                       bit
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        Permission
    SET
                  PERMISSIONNAME               = @PERMISSIONNAME ,
                  PERMISSIONTYPEID             = @PERMISSIONTYPEID ,
                  FUNCTIONID                   = @FUNCTIONID ,
                  PERMISSIONDESCRIPTION        = @PERMISSIONDESCRIPTION ,
                  ACTIVE                       = @ACTIVE
    WHERE         PERMISSIONID                 = @PERMISSIONID


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

