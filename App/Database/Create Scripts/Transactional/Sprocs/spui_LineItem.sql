SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_LineItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_LineItem]
GO

CREATE PROCEDURE spui_LineItem
(   @returnLineItemID  char(10) = "0000000000" OUTPUT,
    @LineItemID		       int=0 ,
    @InvoiceID                 int,
    @LineItemPercentage        decimal(5,4),
    @LineItemOperator          char,
    @LineItemDescriptionID     int                = NULL,
    @LineItemNumber            tinyint            = NULL,
    @LineItemComment           varchar(250),
    @LineItemEnabled	       bit
)

AS
BEGIN

 IF @LineItemID = 0
 BEGIN
    INSERT INTO LineItem
		(
		InvoiceID,
		LineItemPercentage,
		LineItemOperator,
		LineItemDescriptionID,
		LineItemNumber,
		LineItemComment,
		LineItemEnabled
		)
    VALUES
		(
		@InvoiceID,
		@LineItemPercentage,
		@LineItemOperator,
		@LineItemDescriptionID,
		@LineItemNumber,
		@LineItemComment,
		@LineItemEnabled
		)



    IF (@@error!=0)
    BEGIN
        RAISERROR(20000, -1, -1,  'LineItem: Cannot insert because primary key value not found in LineItem ')

        RETURN
    
    END
    SELECT @LineItemID = @@IDENTITY 

 END
 ELSE
 BEGIN

    UPDATE LineItem
	SET 
		InvoiceID 		= @InvoiceID,
		LineItemPercentage 	= @LineItemPercentage,
		LineItemOperator 	= @LineItemOperator,
		LineItemDescriptionID 	= @LineItemDescriptionID,
		LineItemNumber 		= @LineItemNumber,
		LineItemComment 	= @LineItemComment,
		LineItemEnabled 	= @LineItemEnabled
	WHERE   LineItemID 		= @LineItemID

    IF (@@error!=0)
    BEGIN
        RAISERROR(20001, -1, -1, 'LineItem: Cannot update  in LineItem ')
        ROLLBACK TRAN         
    
    END
    SELECT @LineItemID = @LineItemID
    
 END
SELECT @returnLineItemID = @LineItemID
RETURN @LineItemID
END



-- SP_HELP LineItem

















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

