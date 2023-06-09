SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_Navigation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_Navigation]
GO


CREATE PROCEDURE  SPI_Navigation
                  @NAVID            int OUTPUT ,
                  @NAVTYPEID        int ,
                  @HREF             varchar(1000) ,
                  @HREFTEXT         varchar(1000) ,
                  @TARGET           varchar(50) ,
                  @IMAGE            varchar(1000) ,
                  @IMAGEOVER        varchar(1000) ,
                  @SEQ              int ,
                  @ACTIVE           bit
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        Navigation (
                  NAVTYPEID ,
                  HREF ,
                  HREFTEXT ,
                  TARGET ,
                  IMAGE ,
                  IMAGEOVER ,
                  SEQ ,
                  ACTIVE
                  )
    SELECT
                  @NAVTYPEID ,
                  @HREF ,
                  @HREFTEXT ,
                  @TARGET ,
                  @IMAGE ,
                  @IMAGEOVER ,
                  @SEQ ,
                  @ACTIVE


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @NAVID = @intIdentity

RETURN @intRetCode



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

