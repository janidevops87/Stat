

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectDynamicDonorCategory')
	BEGIN
		PRINT 'Dropping Procedure SelectDynamicDonorCategory'
		PRINT GETDATE()
		DROP Procedure SelectDynamicDonorCategory
	END
GO

PRINT 'Creating Procedure SelectDynamicDonorCategory'
PRINT GETDATE()
GO
CREATE Procedure SelectDynamicDonorCategory
(
		@DynamicDonorCategoryID int = null output					
)
AS
/******************************************************************************
**	File: SelectDynamicDonorCategory.sql
**	Name: SelectDynamicDonorCategory
**	Desc: Selects multiple rows of DynamicDonorCategory Based on Id  fields 
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
		DynamicDonorCategory.DynamicDonorCategoryID,
		DynamicDonorCategory.DynamicDonorCategoryName,
		DynamicDonorCategory.LastModified,
		DynamicDonorCategory.UpdatedFlag
	FROM 
		dbo.DynamicDonorCategory 

	WHERE 
		DynamicDonorCategory.DynamicDonorCategoryID = ISNULL(@DynamicDonorCategoryID, DynamicDonorCategory.DynamicDonorCategoryID)				

GO

GRANT EXEC ON SelectDynamicDonorCategory TO PUBLIC
GO
