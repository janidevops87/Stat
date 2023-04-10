IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaGroupListSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaGroupListSelect'
		DROP Procedure CriteriaGroupListSelect
	END
GO

PRINT 'Creating Procedure CriteriaGroupListSelect'
GO
CREATE Procedure CriteriaGroupListSelect
(
		@CriteriaID int = null output,
		@DonorCategoryID int = null
)
AS
/******************************************************************************
**	File: CriteriaGroupListSelect.sql
**	Name: CriteriaGroupListSelect
**	Desc: Selects multiple rows of Criteria Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Criteria.CriteriaID AS ListId,
		Criteria.CriteriaGroupName AS FieldValue
	FROM 
		dbo.Criteria 
	WHERE 
			Criteria.CriteriaStatus = 0 	
	AND
		Criteria.CriteriaID = ISNULL(@CriteriaID, Criteria.CriteriaID)
	AND
		Criteria.DonorCategoryID = ISNULL(@DonorCategoryID, Criteria.DonorCategoryID)

	ORDER BY 2
GO

GRANT EXEC ON CriteriaGroupListSelect TO PUBLIC
GO
