SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_InvoiceHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_InvoiceHistory]
GO


CREATE PROCEDURE spui_InvoiceHistory 
(   	
	@returnInvoiceHistoryID char(10) = "0000000000" OUTPUT,
	@InvoiceHistoryID		int = 0 ,
	@InvoiceID 				int = 0, 
	@BillingAddressID     	int = 0 ,
	@InvoiceDate			smalldatetime
) AS 

SET NOCOUNT ON
SELECT @InvoiceHistoryID = InvoiceHistoryID FROM InvoiceHistory WHERE InvoiceID = @InvoiceID AND InvoiceDate = @InvoiceDate
 IF (@@ROWCOUNT = 0 )
 BEGIN
    INSERT INTO InvoiceHistory(InvoiceId,
	                        BillingAddressID,
		          InvoiceDate
			       )
    VALUES(@InvoiceID,
           @BillingAddressID,
	@InvoiceDate
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR(20000, -1, -1, 'Invoice: Cannot insert because primary key value not found in Invoice ')
        RETURN(-1)    
    END

    RETURN @@IDENTITY 
 END
 ELSE
 BEGIN
    UPDATE 	InvoiceHistory
    SET 	InvoiceID       	= @InvoiceID,
           	BillingAddressID      	= @BillingAddressID,
	InvoiceDate		= @InvoiceDate
           	
     WHERE 	InvoiceID	= @InvoiceID
     AND		InvoiceDate 	= @InvoiceDate

    IF (@@error!=0)
    BEGIN
        RAISERROR(20001, -1, -1,  'Invoice: Cannot update  in Invoice ')
        RETURN(-11)
    
    END
	-- IF update delete line items
	DELETE LineItemHistory
	WHERE InvoiceHistoryID = @InvoiceHistoryID

    SELECT @returnInvoiceHistoryID = @InvoiceHistoryID
    RETURN @InvoiceHistoryID
END











GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

