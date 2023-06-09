SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_LineItemDescriptionHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_LineItemDescriptionHistory]
GO


/* 
 * PROCEDURE: Invoice 
sp_help Invoice 
*/

CREATE PROCEDURE spui_LineItemDescriptionHistory 
(   	@returnLineItemDescriptionID char(10) = "0000000000" OUTPUT,
	@LineItemDescriptionID	int =0,
	@LineItemName		varchar(250), 
	@LineItemPriceID	decimal(9,2),
	@LineItemProductId     	int=0 
) AS 

SET NOCOUNT  OFF



 IF @LineItemDescriptionID = 0

 BEGIN
     SELECT @LineItemDescriptionID = LineItemDescriptionHistoryID 
     FROM LineItemDescriptionHistory 
    WHERE LineItemDescriptionHistoryName = @LineItemName
    AND LineItemDescriptionPrice = @LineItemPriceID
     
     IF @LineItemDescriptionID = 0 
     BEGIN
		INSERT INTO LineItemDescriptionHistory(	LineItemDescriptionHistoryName,
	                        			LineItemDescriptionHistoryProductID, 
					LineItemDescriptionPrice

			       )
		VALUES(	@LineItemName,
           		@LineItemProductId,
		@LineItemPriceID
	               )

	IF (@@error!=0)
	BEGIN
	        	RAISERROR(20000, -1, -1,  'Invoice: Cannot insert because primary key value not found in Invoice ')
        		RETURN(-1)    
	END
	
	SELECT @returnLineItemDescriptionID = @@IDENTITY 
    	RETURN @returnLineItemDescriptionID

	END 
	
	ELSE
	BEGIN
		SELECT @returnLineItemDescriptionID = @LineItemDescriptionID		
		RETURN @LineItemDescriptionID
	END
 END
 ELSE
 BEGIN
	SELECT @returnLineItemDescriptionID = @LineItemDescriptionID
	RETURN @LineItemDescriptionID
 END








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

