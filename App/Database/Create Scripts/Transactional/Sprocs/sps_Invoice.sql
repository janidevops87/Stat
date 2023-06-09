SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Invoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Invoice]
GO

/* 
 * PROCEDURE: Invoice 
 */
-- sps_Invoice 0,1

CREATE PROCEDURE sps_Invoice
	@InvoiceID int = 0,
	@Enabled int = null
AS
BEGIN
	IF @InvoiceID = 0 
	BEGIN
		SELECT @InvoiceID = NULL
	END

	/*IF @Enabled IS NULL
	BEGIN
		SELECT @Enabled = 1
	END
	*/

	SELECT	
		InvoiceID,
		Invoice.OrganizationID,
		OrganizationName,
		InvoiceEnabled,
		BillingAddress.BillingAddressID,
		BillingAddress1,
		BillingAddress2,
		BillingAddress3,
		BillingAddress4,
		BillingAddress5,
		InvoiceComment

	FROM 	Invoice
	LEFT JOIN Organization ON Organization.OrganizationID = Invoice.OrganizationID
	LEFT JOIN BillingAddress ON BillingAddress.BillingAddressID = Invoice.BillingAddressID
	LEFT JOIN State ON State.StateID = BillingAddress.BillingStateID
	WHERE 	InvoiceID = ISNULL(@InvoiceID,InvoiceID)
	AND 	InvoiceEnabled = ISNULL(@Enabled, InvoiceEnabled)
	ORDER BY OrganizationName -- 11/26 Bret Knoll - Added Order by 11/26
	
    RETURN(0)
END







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

