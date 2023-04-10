

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaAgeUnitListSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaAgeUnitListSelect'
		DROP Procedure CriteriaAgeUnitListSelect
	END
GO

PRINT 'Creating Procedure CriteriaAgeUnitListSelect'
GO
CREATE Procedure CriteriaAgeUnitListSelect
(
		@CriteriaAgeUnitID int = null					
)
AS
/******************************************************************************
**	File: CriteriaAgeUnitListSelect.sql
**	Name: CriteriaAgeUnitListSelect
**	Desc: Selects multiple rows of CriteriaAgeUnit Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/16/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/16/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CriteriaAgeUnit.CriteriaAgeUnitID AS ListId,
		CriteriaAgeUnit.CriteriaAgeUnitName AS FieldValue
	FROM 
		dbo.CriteriaAgeUnit 
	WHERE 
		CriteriaAgeUnit.CriteriaAgeUnitID = ISNULL(@CriteriaAgeUnitID, CriteriaAgeUnit.CriteriaAgeUnitID)				
	ORDER BY 1
GO

GRANT EXEC ON CriteriaAgeUnitListSelect TO PUBLIC
GO
