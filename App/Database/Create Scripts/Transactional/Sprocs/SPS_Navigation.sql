SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_Navigation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_Navigation]
GO


CREATE PROCEDURE  SPS_Navigation
                  @NAVID            int =NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @NAVID IS NOT NULL 
BEGIN
    SELECT
                  NAVID ,
                  ISNULL(NAVTYPEID,0) NAVTYPEID,
                  HREF,
                  HREFTEXT,
                  TARGET,
                  IMAGE,
                  IMAGEOVER,
                  ISNULL(SEQ,0) SEQ,
                  ISNULL(ACTIVE,0) ACTIVE
    FROM          Navigation
    WHERE         NAVID            = @NAVID
END
ELSE
BEGIN
    SELECT * FROM Navigation
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

