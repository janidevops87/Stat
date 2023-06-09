SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_LineItemFormula]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_LineItemFormula]
GO

CREATE PROCEDURE spui_LineItemFormula
(
    @returnLineItemFormulaID char(10) = "0000000000" OUTPUT,
    @LineItemFormulaID		int =0,
    @LineItemFormulaNumber     tinyint,
    @InvoiceID                 int,
    @LineItemID                int,
    @LineItemFormula           nvarchar(4000)
)
AS
BEGIN
	IF (@LineItemFormulaID = 0)
	BEGIN
		INSERT INTO LineItemFormula(
					LineItemFormulaNumber,
					InvoiceID,
                	                		LineItemID,
                        	        			LineItemFormula)
		VALUES(		@LineItemFormulaNumber,
        		   			@InvoiceID,
	        	   			@LineItemID,
	        	   			@LineItemFormula)
		
		SELECT @LineItemFormulaID = @@IDENTITY
		SELECT @returnLineItemFormulaID = @LineItemFormulaID
		
		IF (@@error!=0)
		BEGIN
		        RAISERROR(20000, -1, -1,  'LineItemFormula: Cannot insert because primary key value not found in LineItemFormula ')
		        RETURN(0)
       		END
	END
	ELSE
	BEGIN
		Exec spu_LineItemFormula
			@LineItemFormulaID = @LineItemFormulaID	,
	    	@LineItemFormulaNumber = @LineItemFormulaNumber ,
    		@InvoiceID = @InvoiceID ,
    		@LineItemID = @LineItemID ,
    		@LineItemFormula = @LineItemFormula           

		SELECT @returnLineItemFormulaID = @LineItemFormulaID
		RETURN @LineItemFormulaID 
	END    
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

