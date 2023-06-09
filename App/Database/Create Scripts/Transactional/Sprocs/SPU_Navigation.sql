SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_Navigation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_Navigation]
GO


CREATE PROCEDURE  SPU_Navigation
                  @NAVID            int ,
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
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        Navigation
    SET
                  NAVTYPEID        = @NAVTYPEID ,
                  HREF             = @HREF ,
                  HREFTEXT         = @HREFTEXT ,
                  TARGET           = @TARGET ,
                  IMAGE            = @IMAGE ,
                  IMAGEOVER        = @IMAGEOVER ,
                  SEQ              = @SEQ ,
                  ACTIVE           = @ACTIVE
    WHERE         NAVID            = @NAVID


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

