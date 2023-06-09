SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_InvoiceHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_InvoiceHistory]
GO


/* 
 * PROCEDURE: Invoice 
 */
-- sps_InvoiceHistory 0,1

CREATE PROCEDURE sps_InvoiceHistory
	@InvoiceID int = 0,
	@InvoiceDate	smalldatetime	
AS
BEGIN
	IF @InvoiceID = 0 
	BEGIN
		SELECT @InvoiceID = NULL
	END
	
	SELECT	
		InvoiceHistoryID,
		InvoiceHistory.InvoiceID,
		Organization.OrganizationID,
		OrganizationName,
		BillingAddress.BillingAddressID,
		BillingAddress1,
		BillingAddress2,
		BillingAddress3,
		BillingAddress4,
		BillingAddress5,
		InvoiceHistory.InvoiceDate		

	FROM 	InvoiceHistory
	LEFT 
	JOIN 	Invoice ON Invoice.InvoiceID = InvoiceHistory.InvoiceID
	LEFT 
	JOIN 	Organization ON Organization.OrganizationID = Invoice.OrganizationID
	LEFT 	
	JOIN 	BillingAddress ON BillingAddress.BillingAddressID = Invoice.BillingAddressID
	LEFT 
	JOIN 	State ON State.StateID = BillingAddress.BillingStateID
	WHERE	InvoiceHistory.InvoiceID = ISNULL(@InvoiceID,InvoiceHistory.InvoiceID)
	AND	InvoiceDate = @InvoiceDate
	ORDER 
	BY 	InvoiceHistoryID 
	
    RETURN(0)
END







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

