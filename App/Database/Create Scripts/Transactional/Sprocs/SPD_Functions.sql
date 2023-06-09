SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_Functions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_Functions]
GO





CREATE PROCEDURE  SPD_Functions
                  @FUNCTIONID                 int
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    DELETE        Functions
    WHERE         FUNCTIONID                 = @FUNCTIONID



    SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRetcode <> 0 RETURN @intRetcode

    IF @intRowCount = 0
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

