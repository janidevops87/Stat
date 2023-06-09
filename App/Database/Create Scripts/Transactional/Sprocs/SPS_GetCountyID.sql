SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_GetCountyID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_GetCountyID]
GO

CREATE PROCEDURE  SPS_GetCountyID
                  @CountyName                 VarChar(50),
	     @StateID		int
AS
    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int
    SELECT   @intRetCode = 0
BEGIN
    SELECT
                  CountyName, CountyID
    FROM          County
    WHERE         CountyName                 = @CountyName
    AND		StateID		          = @StateID
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

