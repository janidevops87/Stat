SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_TriageServiceFees_ByClient]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_TriageServiceFees_ByClient]
GO


CREATE PROCEDURE CONTRACTS_TriageServiceFees_ByClient @OrganizationID INT AS
SELECT i.InvoiceID,
       o.OrganizationID, 
       o.OrganizationName, 
       CASE LineItemOperator
         WHEN '-' THEN (-1 * lid.LineItemPrice)
         ELSE lid.LineItemPrice
       END AS LineItemPrice,
       (li.LineItemPercentage * 100) LineItemPercentage, 
       lid.LineItemDescriptionName,
       li.LineItemComment
FROM Organization o,
     Invoice i,
     LineItem li,
     LineItemDescription lid
WHERE o.OrganizationID          = i.OrganizationID
AND   li.InvoiceID              = i.InvoiceID
AND   lid.LineItemDescriptionID = li.LineItemDescriptionID
AND   o.OrganizationID          = @OrganizationID
ORDER BY i.InvoiceID, o.OrganizationName, li.LineItemNumber


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

