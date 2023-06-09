SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LineItemHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LineItemHistory]
GO





/* 
 * PROCEDURE: LineItem 
 */
-- sps_LineItemHistory 1
CREATE PROCEDURE sps_LineItemHistory
(
    @InvoiceHistoryID  int)
AS
BEGIN
    SELECT 
		LineItemNumber  AS "#",
		LineItemHistoryEnabled AS "Enabled",
		LineItemDescriptionHistory.LineItemDescriptionHistoryName AS "Description",
		LineItemHistoryPriceOperator AS "Operator",
		LineItemHistoryPricePercentage AS "%",
		LineItemDescriptionHistory.LineItemDescriptionPrice AS "Price",
		LineItemHistoryComment AS "Comment",
		LineItemHistory.LineItemHistoryID ,
           		InvoiceHistoryID ,
	       	 LineItemHistoryDescriptionID,
		LineItemDescriptionHistory.LineItemDescriptionHistoryProductID,
		LineItemHistory.LineItemHistoryQty


     FROM 	LineItemHistory
     LEFT JOIN LineItemDescriptionHistory ON LineItemDescriptionHistory.LineItemDescriptionHistoryID = LineItemHistory.LineItemHistoryDescriptionID
     WHERE 	InvoiceHistoryID = @InvoiceHistoryID
     ORDER BY LineItemNumber

    RETURN(0)
END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

