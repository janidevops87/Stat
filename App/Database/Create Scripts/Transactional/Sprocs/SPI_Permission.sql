SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_Permission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_Permission]
GO


CREATE PROCEDURE  SPI_Permission
                  @PERMISSIONID                 int OUTPUT,
                  @PERMISSIONNAME               varchar(500) ,
                  @PERMISSIONTYPEID             int ,
                  @FUNCTIONID                   int ,
                  @PERMISSIONDESCRIPTION        varchar(1000) ,
                  @ACTIVE                       bit
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        Permission (
                  PERMISSIONNAME ,
                  PERMISSIONTYPEID ,
                  FUNCTIONID ,
                  PERMISSIONDESCRIPTION ,
                  ACTIVE
                  )
    SELECT
                  @PERMISSIONNAME ,
                  @PERMISSIONTYPEID ,
                  @FUNCTIONID ,
                  @PERMISSIONDESCRIPTION ,
                  @ACTIVE


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @PERMISSIONID = @intIdentity

RETURN @intRetCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

