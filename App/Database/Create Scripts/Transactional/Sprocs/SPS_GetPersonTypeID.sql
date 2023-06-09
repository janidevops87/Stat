SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_GetPersonTypeID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_GetPersonTypeID]
GO

CREATE PROCEDURE  SPS_GetPersonTypeID
                  @PersonTypeName                 VarChar(50)
AS

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0
BEGIN
    SELECT
                  PersonTypeName, PersonTypeID
    FROM          PersonType
    WHERE         PersonTypeName                 = @PersonTypeName
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

