SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_Button]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_Button]
GO


CREATE PROCEDURE  SPU_Button
                  @BUTTONID                 int ,
                  @BUTTONNAME               varchar(500) ,
                  @BUTTONSTRING             varchar(1000) ,
                  @BUTTONDESCRIPTION        varchar(1000)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        Button
    SET
                  BUTTONNAME               = @BUTTONNAME ,
                  BUTTONSTRING             = @BUTTONSTRING ,
                  BUTTONDESCRIPTION        = @BUTTONDESCRIPTION
    WHERE         BUTTONID                 = @BUTTONID


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

