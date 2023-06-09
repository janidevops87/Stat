SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_BillingAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_BillingAddress]
GO

CREATE PROCEDURE spi_BillingAddress AS

DECLARE @ErrorMessage VARCHAR(500)

INSERT BillingAddress 
(QBooksID,BillingAddress1, BillingAddress2, BillingAddress3, BillingAddress4, BillingAddress5)
SELECT DISTINCT REFNUM, BADDR1, BADDR2, BADDR3, BADDR4, BADDR5
FROM _QBBillingAddressTable_Temp
WHERE REFNUM NOT IN (SELECT QBooksID FROM BillingAddress)


SET @ErrorMessage = 'Information Message:> BillingAddress insert count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

