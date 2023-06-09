SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_LineItemDescription2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_LineItemDescription2]
GO

CREATE PROCEDURE spui_LineItemDescription2
(
	@returnLineItemDescriptionID	char(10) = "0000000000" OUTPUT,
	@LineItemDescriptionID		INT =0,
	@LineItemDescriptionName        VARCHAR(250),	
	@LineItemPrice			DECIMAL(9, 2),	
	@LineItemProductID		INT = 0,
	@LineItemDescriptionReconcile	BIT = 0
	

)
AS
BEGIN
	IF @LineItemDescriptionID   = 0 -- INSERT A NEW DESCRIPTION
	BEGIN
		INSERT [LineItemDescription]([LineItemDescriptionName], [LineItemPrice], [LineItemProductID], [LineItemDescriptionReconcile])
		VALUES(	
			RTRIM(LTRIM(@LineItemDescriptionName)),
			@LineItemPrice,
			@LineItemProductID,
			@LineItemDescriptionReconcile
			)

		SELECT @returnLineItemDescriptionID = @@IDENTITY
		
	END
	ELSE
	BEGIN

		UPDATE [LineItemDescription]
		SET 
			[LineItemDescriptionName]= RTRIM(LTRIM(@LineItemDescriptionName)), 
			[LineItemPrice]= @LineItemPrice, 
			[LineItemProductID]= @LineItemProductID , 
			[LineItemDescriptionReconcile]= @LineItemDescriptionReconcile
		WHERE 	LineItemDescriptionID = @LineItemDescriptionID

		SELECT @returnLineItemDescriptionID = @LineItemDescriptionID		
	END

END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

