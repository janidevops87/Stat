SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ReportType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ReportType]
GO


CREATE PROCEDURE  SPS_ReportType
                  @REPORTTYPEID          int=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0

IF @REPORTTYPEID IS NOT NULL
BEGIN
    SELECT
                  REPORTTYPEID ,
                  REPORTTYPENAME
    FROM          ReportType
    WHERE         REPORTTYPEID          = @REPORTTYPEID
END
ELSE
BEGIN
    	SELECT * FROM ReportType
	ORDER BY REPORTTYPENAME
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

