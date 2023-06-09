SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_Button]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_Button]
GO


CREATE PROCEDURE  SPI_Button
                  @BUTTONID                 int OUTPUT ,
                  @BUTTONNAME               varchar(500) ,
                  @BUTTONSTRING             varchar(1000) ,
                  @BUTTONDESCRIPTION        varchar(1000)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        Button (
                  BUTTONNAME ,
                  BUTTONSTRING ,
                  BUTTONDESCRIPTION
                  )
    SELECT
                  @BUTTONNAME ,
                  @BUTTONSTRING ,
                  @BUTTONDESCRIPTION


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @BUTTONID = @intIdentity

RETURN @intRetCode



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

