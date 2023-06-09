SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_LineItemDescription2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_LineItemDescription2]
GO

CREATE PROCEDURE spd_LineItemDescription2
(
    @LineItemDescriptionID int =null
)
AS
BEGIN
	DECLARE @ExistsCount int
	
	-- get a count of lineitems that have a reference the LineItemDescription
	SELECT @ExistsCount = COUNT(*) FROM LineItem WHERE LineItemDescriptionID =  @LineItemDescriptionID 
	
	-- if the count = 0 then delete the description
	IF @ExistsCount = 0
	BEGIN
		BEGIN TRANSACTION DELETE_DESCRIPTION
		DELETE LineItemDescription WHERE LineItemDescriptionID =  @LineItemDescriptionID 
		IF (@@error!=0)
		BEGIN
		        RAISERROR(20000, -1, -1, 'LineItemDescription: Cannot delete LineItemDescription  ')
		        RETURN(0)
       		END
		
		COMMIT TRANSACTION DELETE_DESCRIPTION
		
		RETURN(1)
	END
	ELSE
		BEGIN
		        RAISERROR(20000, -1, -1, 'LineItemDescription: Cannot delete LineItemDescription  ')
		        RETURN(0)
       		END
       		
	



END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

