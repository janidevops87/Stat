SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_Invoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_Invoice]
GO

CREATE PROCEDURE spui_Invoice 
(   	
	@returnInvoiceID	char(10) = "0000000000" OUTPUT,
	@InvoiceID 			int = 0, 
	@OrganizationID     int,
	@BillingAddressID   int = NULL, 
	@InvoiceEnabled     bit,
	@InvoiceComment     varchar(250)
) AS 

 IF @InvoiceID = 0
 BEGIN
    INSERT INTO Invoice(OrganizationID,
                        BillingAddressID,
                        InvoiceEnabled,
	          InvoiceComment)
    VALUES(@OrganizationID,
           @BillingAddressID,
           @InvoiceEnabled,
            @InvoiceComment)

    IF (@@error!=0)
    BEGIN
        RAISERROR(20000, -1, -1,  'Invoice: Cannot insert because primary key value not found in Invoice ')
        RETURN(-1)    
    END

    SELECT @InvoiceID = @@IDENTITY 
 END
 ELSE
 BEGIN
    UPDATE 	Invoice
    SET 	OrganizationID       	= @OrganizationID,
           	BillingAddressID      	= @BillingAddressID,
           	InvoiceEnabled          = @InvoiceEnabled,
	InvoiceComment         = @InvoiceComment
     WHERE 	InvoiceID 		= @InvoiceID

    IF (@@error!=0)
    BEGIN
        RAISERROR(20001, -1, -1, 'Invoice: Cannot update  in Invoice ')
        RETURN(-11)
    
    END
    SELECT @InvoiceID = @InvoiceID 	   
END

SELECT @returnInvoiceID = @InvoiceID
RETURN @InvoiceID








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

