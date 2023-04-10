

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectDictionaryItem')
	BEGIN
		PRINT 'Dropping Procedure SelectDictionaryItem'
		PRINT GETDATE()
		DROP Procedure SelectDictionaryItem
	END
GO

PRINT 'Creating Procedure SelectDictionaryItem'
PRINT GETDATE()
GO
CREATE Procedure SelectDictionaryItem
(
		@DictionaryItemID int = null output					
)
AS
/******************************************************************************
**	File: SelectDictionaryItem.sql
**	Name: SelectDictionaryItem
**	Desc: Selects multiple rows of DictionaryItem Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DictionaryItem.DictionaryItemID,
		DictionaryItem.DictionaryItemName,
		DictionaryItem.Verified,
		DictionaryItem.Inactive,
		DictionaryItem.LastModified,
		DictionaryItem.UpdatedFlag
	FROM 
		dbo.DictionaryItem 

	WHERE 
		DictionaryItem.DictionaryItemID = ISNULL(@DictionaryItemID, DictionaryItem.DictionaryItemID)				

GO

GRANT EXEC ON SelectDictionaryItem TO PUBLIC
GO
