SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_Functions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_Functions]
GO


CREATE PROCEDURE  SPI_Functions
                  @FUNCTIONID                 int OUTPUT ,
                  @FUNCTIONNAME               varchar(500) ,
                  @FUNCTIONSTRING             varchar(1000) ,
                  @FUNCTIONDESCRIPTION        varchar(1000)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        Functions (
                  FUNCTIONNAME ,
                  FUNCTIONSTRING ,
                  FUNCTIONDESCRIPTION
                  )
    SELECT
                  @FUNCTIONNAME ,
                  @FUNCTIONSTRING ,
                  @FUNCTIONDESCRIPTION


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @FUNCTIONID = @intIdentity

RETURN @intRetCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

