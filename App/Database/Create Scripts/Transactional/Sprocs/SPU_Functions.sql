SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_Functions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_Functions]
GO


CREATE PROCEDURE  SPU_Functions
                  @FUNCTIONID                 int ,
                  @FUNCTIONNAME               varchar(500) ,
                  @FUNCTIONSTRING             varchar(1000) ,
                  @FUNCTIONDESCRIPTION        varchar(1000)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        Functions
    SET
                  FUNCTIONNAME               = @FUNCTIONNAME ,
                  FUNCTIONSTRING             = @FUNCTIONSTRING ,
                  FUNCTIONDESCRIPTION        = @FUNCTIONDESCRIPTION
    WHERE         FUNCTIONID                 = @FUNCTIONID


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

