SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetPhoneID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetPhoneID]
GO

CREATE PROCEDURE  sps_GetPhoneID
                  @PhoneAreaCode                 VarChar(3),
	     @PhonePrefix                     VarChar(3),
	     @PhoneNumber                 VarChar(4)
AS

SET NoCount ON

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int,
             @PhoneTypeID	        int

    SET   @intRetCode = 0
BEGIN
    SELECT PhoneID,
                  PhoneAreaCode,
	    PhonePrefix,
	    PhoneNumber,
	    PhoneTypeID
    FROM          Phone
    WHERE         PhoneAreaCode                 = @PhoneAreaCode
    AND               PhonePrefix                 = @PhonePrefix
    AND               PhoneNumber                 = @PhoneNumber
    AND               PhoneTypeID                 = 3
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

