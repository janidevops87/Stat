SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_NavigationType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_NavigationType]
GO


CREATE PROCEDURE  SPS_NavigationType
                  @NAVIGATIONTYPEID          int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @NAVIGATIONTYPEID IS NOT NULL
BEGIN
    SELECT
                  NAVIGATIONTYPEID ,
                  NAVIGATIONTYPENAME
    FROM          NavigationType
    WHERE         NAVIGATIONTYPEID          = @NAVIGATIONTYPEID
ORDER BY NAVIGATIONTYPENAME
END 
ELSE
BEGIN
	SELECT * FROM NavigationType
ORDER BY NAVIGATIONTYPENAME
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

