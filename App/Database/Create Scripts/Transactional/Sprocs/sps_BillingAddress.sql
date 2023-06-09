SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_BillingAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_BillingAddress]
GO

/* 
 * PROCEDURE: BillingAddress 
 */

CREATE PROCEDURE sps_BillingAddress
(
    @BillingAddressID       int)
AS
BEGIN
    SELECT BillingAddressID,
           BillingAddressName,
           BillingAddress1,
           BillingAddress2,
           BillingCity,
           BillingStateID,
           BillingZipCode
      FROM BillingAddress
     WHERE BillingAddressID = @BillingAddressID

    RETURN(0)
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

