

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorCategoryListSelect')
	BEGIN
		PRINT 'Dropping Procedure DonorCategoryListSelect'
		DROP Procedure DonorCategoryListSelect
	END
GO

PRINT 'Creating Procedure DonorCategoryListSelect'
GO
CREATE Procedure DonorCategoryListSelect
(
		@DonorCategoryID int = null output					
)
AS
/******************************************************************************
**	File: DonorCategoryListSelect.sql
**	Name: DonorCategoryListSelect
**	Desc: Selects multiple rows of DonorCategory Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DonorCategory.DonorCategoryID AS ListId,
		DonorCategory.DonorCategoryName AS FieldValue
	FROM 
		dbo.DonorCategory 
	WHERE 
		DonorCategory.DonorCategoryID = ISNULL(@DonorCategoryID, DonorCategory.DonorCategoryID)				
	ORDER BY 1
GO

GRANT EXEC ON DonorCategoryListSelect TO PUBLIC
GO
