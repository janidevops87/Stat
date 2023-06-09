SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_County]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_County]
GO

CREATE PROCEDURE  SPI_County
                  @CountyName               varchar(50) ,
                  @StateID             	int
AS
    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int
    SELECT   @intRetCode    = 0
    INSERT        County (
                  CountyName ,
                  StateID
                  )
    SELECT
                  @CountyName ,
                  @StateID
    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
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

