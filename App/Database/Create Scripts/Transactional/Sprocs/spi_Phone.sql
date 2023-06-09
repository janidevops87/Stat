SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Phone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Phone]
GO

CREATE PROCEDURE  spi_Phone
                  @PhoneAreaCode VarChar(3) = '',
	     @PhonePrefix VarChar(3) = '',
	     @PhoneNumber VarChar(4) = '',
	     @PhoneTypeID Int = 0
AS

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SET   @intRetCode    = 0


    INSERT        Phone (
                  PhoneAreaCode ,
                  PhonePrefix ,
                  PhoneNumber ,
	     PhoneTypeID
                  )
    SELECT
                  @PhoneAreaCode ,
                  @PhonePrefix ,
                  @PhoneNumber ,
	     @PhoneTypeID

    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
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

