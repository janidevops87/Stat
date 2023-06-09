SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_LineItemFormula]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_LineItemFormula]
GO



/* 
 * PROCEDURE: LineItemFormula 
 */

CREATE PROCEDURE spu_LineItemFormula
(@LineItemFormulaID	int,
    @LineItemFormulaNumber     tinyint,
    @InvoiceID                 int,
    @LineItemID                int,
    @LineItemFormula           nvarchar(4000))
AS
BEGIN
    BEGIN TRAN

    UPDATE LineItemFormula
       SET LineItemFormulaNumber      = @LineItemFormulaNumber,
           InvoiceID                  = @InvoiceID,
           LineItemID                 = @LineItemID,
           LineItemFormula            = @LineItemFormula
     WHERE LineItemFormulaID = @LineItemFormulaID

    IF (@@error!=0)
    BEGIN
        RAISERROR(20001, -1, -1, 'LineItemFormula: Cannot update  in LineItemFormula ')
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

