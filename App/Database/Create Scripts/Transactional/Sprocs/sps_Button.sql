SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_Button]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_Button]
GO


CREATE PROCEDURE  SPS_Button
                 (@BUTTONID int = 0)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @BUTTONID IS NOT NULL
BEGIN
    SELECT
                  BUTTONID ,
                  BUTTONNAME,
                  BUTTONSTRING,
                  BUTTONDESCRIPTION
    FROM          Button
    WHERE         BUTTONID                 = @BUTTONID
END
ELSE
BEGIN
    SELECT * FROM Button
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

