SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_NavigationType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_NavigationType]
GO


CREATE PROCEDURE  SPU_NavigationType
                  @NAVIGATIONTYPEID          int ,
                  @NAVIGATIONTYPENAME        varchar(500)
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        NavigationType
    SET
                  NAVIGATIONTYPENAME        = @NAVIGATIONTYPENAME
    WHERE         NAVIGATIONTYPEID          = @NAVIGATIONTYPEID


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

