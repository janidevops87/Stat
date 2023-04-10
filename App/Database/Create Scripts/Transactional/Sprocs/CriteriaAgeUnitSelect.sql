IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaAgeUnitSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaAgeUnitSelect'
		DROP Procedure CriteriaAgeUnitSelect
	END
GO

PRINT 'Creating Procedure CriteriaAgeUnitSelect'
GO
CREATE Procedure CriteriaAgeUnitSelect
(
		@CriteriaAgeUnitID int = null					
)
AS
/******************************************************************************
**	File: CriteriaAgeUnitSelect.sql
**	Name: CriteriaAgeUnitSelect
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
		CriteriaAgeUnit.CriteriaAgeUnitID,
		CriteriaAgeUnit.CriteriaAgeUnitName,
		CriteriaAgeUnit.DisplayOrder,
		IsNull(CriteriaAgeUnit.Inactive, 0) AS Inactive,
		CriteriaAgeUnit.LastModified,
		CriteriaAgeUnit.LastStatEmployeeID,
		CriteriaAgeUnit.AuditLogTypeID
	FROM 
		dbo.CriteriaAgeUnit 

	WHERE 
		CriteriaAgeUnit.CriteriaAgeUnitID = ISNULL(@CriteriaAgeUnitID, CriteriaAgeUnit.CriteriaAgeUnitID)				
	ORDER BY 3
GO

GRANT EXEC ON CriteriaAgeUnitSelect TO PUBLIC
GO
