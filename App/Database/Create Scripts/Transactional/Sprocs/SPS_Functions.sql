SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_Functions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_Functions]
GO


CREATE PROCEDURE  SPS_Functions
                  @FUNCTIONID                 int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @FUNCTIONID IS NOT NULL
BEGIN
    SELECT
                  FUNCTIONID ,
                  FUNCTIONNAME,
                  FUNCTIONSTRING,
                  FUNCTIONDESCRIPTION
    FROM          Functions
    WHERE         FUNCTIONID                 = @FUNCTIONID
END
ELSE
BEGIN
	SELECT * FROM Functions
	Order By Functionname
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

