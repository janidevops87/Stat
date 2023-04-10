

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaWeightUnitListSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaWeightUnitListSelect'
		DROP Procedure CriteriaWeightUnitListSelect
	END
GO

PRINT 'Creating Procedure CriteriaWeightUnitListSelect'
GO
CREATE Procedure CriteriaWeightUnitListSelect
(
		@CriteriaWeightUnitID int = null					
)
AS
/******************************************************************************
**	File: CriteriaWeightUnitListSelect.sql
**	Name: CriteriaWeightUnitListSelect
**	Desc: Selects multiple rows of CriteriaWeightUnit Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/16/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CriteriaWeightUnit.CriteriaWeightUnitID AS ListId,
		CriteriaWeightUnit.CriteriaWeightUnitName AS FieldValue
	FROM 
		dbo.CriteriaWeightUnit 
	WHERE 
		CriteriaWeightUnit.CriteriaWeightUnitID = ISNULL(@CriteriaWeightUnitID, CriteriaWeightUnit.CriteriaWeightUnitID)				
	ORDER BY 1
GO

GRANT EXEC ON CriteriaWeightUnitListSelect TO PUBLIC
GO
