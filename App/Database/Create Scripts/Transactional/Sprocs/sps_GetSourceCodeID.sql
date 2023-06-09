SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetSourceCodeID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetSourceCodeID]
GO

CREATE PROCEDURE  sps_GetSourceCodeID
                  @SourceCodeName                 VarChar(80)
AS

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0
BEGIN
    SELECT
                  SourceCodeName, SourceCodeID
    FROM          SourceCode
    WHERE         SourceCodeName                 = @SourceCodeName
    AND		SourceCodeType = 1
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

