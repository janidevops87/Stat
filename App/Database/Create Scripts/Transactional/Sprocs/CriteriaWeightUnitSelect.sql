

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaWeightUnitSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaWeightUnitSelect'
		DROP Procedure CriteriaWeightUnitSelect
	END
GO

PRINT 'Creating Procedure CriteriaWeightUnitSelect'
GO
CREATE Procedure CriteriaWeightUnitSelect
(
		@CriteriaWeightUnitID int = null					
)
AS
/******************************************************************************
**	File: CriteriaWeightUnitSelect.sql
**	Name: CriteriaWeightUnitSelect
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
		CriteriaWeightUnit.CriteriaWeightUnitID,
		CriteriaWeightUnit.CriteriaWeightUnitName,
		CriteriaWeightUnit.DisplayOrder,
		IsNull(CriteriaWeightUnit.Inactive, 0) AS Inactive,
		CriteriaWeightUnit.LastModified,
		CriteriaWeightUnit.LastStatEmployeeID,
		CriteriaWeightUnit.AuditLogTypeID
	FROM 
		dbo.CriteriaWeightUnit 

	WHERE 
		CriteriaWeightUnit.CriteriaWeightUnitID = ISNULL(@CriteriaWeightUnitID, CriteriaWeightUnit.CriteriaWeightUnitID)				
	ORDER BY 3
GO

GRANT EXEC ON CriteriaWeightUnitSelect TO PUBLIC
GO
