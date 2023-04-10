SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LineItemReconcile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LineItemReconcile]
GO

CREATE PROCEDURE sps_LineItemReconcile
(
    @InvoiceID  int)
AS
BEGIN
    SELECT 
		LineItemNumber  AS "#",
		LineItemEnabled AS "Enabled",
		LineItemDescription.LineItemDescriptionName AS "Description",
		LineItemOperator AS "Operator",
		LineItemPercentage AS "%",
		LineItemDescription.LineItemPrice AS "Price",
		LineItemComment AS "Comment",
		LineItemID ,
           	InvoiceID ,
	        LineItem.LineItemDescriptionID ,
		LineItemDescription.LineItemProductID

     FROM 	LineItem
     LEFT JOIN LineItemDescription ON LineItemDescription.LineItemDescriptionID = LineItem.LineItemDescriptionID
     WHERE 	InvoiceID = @InvoiceID
     AND	LineItemDescription.LineItemDescriptionReconcile = 1
     ORDER BY LineItemNumber

    RETURN(0)
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

