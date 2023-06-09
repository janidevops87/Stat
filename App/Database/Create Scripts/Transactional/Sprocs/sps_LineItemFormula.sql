SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LineItemFormula]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LineItemFormula]
GO


/* 
 * PROCEDURE: LineItemFormula 
 */

CREATE PROCEDURE sps_LineItemFormula
(
	@InvoiceID int,
	@LineItemID int
    )
AS
BEGIN
    SELECT LineItemFormulaID,
           LineItemFormulaNumber,
           InvoiceID,
           LineItemID,
           LineItemFormula
      FROM LineItemFormula
     WHERE InvoiceID = @InvoiceID
     AND   LineItemID = @LineItemID

    RETURN(0)
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

