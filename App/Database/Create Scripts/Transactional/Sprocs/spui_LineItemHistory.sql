SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_LineItemHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_LineItemHistory]
GO


-- sp_help LineItemHistory
/* 
 * PROCEDURE: Invoice 
sp_help Invoice 
*/

CREATE PROCEDURE spui_LineItemHistory 
(   	@returnLineItemHistoryID char(10) = "0000000000" OUTPUT,
	@LineItemHistoryID		int =0,
	@InvoiceHistoryID		int ,
	@LineItemHistoryNumber		tinyint ,
	@LineItemHistoryQty		smallint =0,
	@LineItemHistoryDescriptionID 	int,
	@LineItemHistoryPercentage	decimal(5,4),
	@LineItemHistoryOperator	char,
	 @LineItemComment           varchar(250) = null,
	 @LineItemEnabled	       bit
) AS 



 IF @LineItemHistoryID = 0

 BEGIN
    		INSERT INTO LineItemHistory	(InvoiceHistoryID,
						LineItemNumber,
						LineItemHistoryQty,
						LineItemHistoryDescriptionID,
						LineItemHistoryPricePercentage,
						LineItemHistoryPriceOperator,
						LineItemHistoryComment,
						LineItemHistoryEnabled

						)
		VALUES(	
			@InvoiceHistoryID,
			@LineItemHistoryNumber ,
			@LineItemHistoryQty,
			@LineItemHistoryDescriptionID,
			@LineItemHistoryPercentage,
			@LineItemHistoryOperator,
			@LineItemComment,
			@LineItemEnabled
	               )

	SELECT @LineItemHistoryID = @@IDENTITY
	SELECT @returnLineItemHistoryID = @LineItemHistoryID

	IF (@@error!=0)
	BEGIN
        	RAISERROR(20000, -1, -1, 'Invoice: Cannot insert because primary key value not found in Invoice ')
        	RETURN(-1)    
	END


END
ELSE
BEGIN

    		UPDATE LineItemHistory	
		SET 	InvoiceHistoryID	= 	@InvoiceHistoryID,
			LineItemNumber 		=	@LineItemHistoryNumber,
			LineItemHistoryQty	=	@LineItemHistoryQty,
			LineItemHistoryDescriptionID = 	@LineItemHistoryDescriptionID,
			LineItemHistoryPricePercentage = @LineItemHistoryPercentage,
			LineItemHistoryPriceOperator =	 @LineItemHistoryOperator,
			LineItemHistoryComment	= 	@LineItemComment,
			LineItemHistoryEnabled = 	@LineItemEnabled
		WHERE	LineItemHistoryID	=	@LineItemHistoryID

		SELECT @returnLineItemHistoryID = @LineItemHistoryID
		RETURN @LineItemHistoryID
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

