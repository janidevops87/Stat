

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSourceCodeSelect'
		DROP Procedure CriteriaSourceCodeSelect
	END
GO

PRINT 'Creating Procedure CriteriaSourceCodeSelect'
GO
CREATE Procedure CriteriaSourceCodeSelect
(
		@CriteriaSourceCodeID int = null output,
		@CriteriaID int = null,
		@SourceCodeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaSourceCodeSelect.sql
**	Name: CriteriaSourceCodeSelect
**	Desc: Selects multiple rows of CriteriaSourceCode Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/21/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

IF @CriteriaSourceCodeID = 0
	BEGIN
		SET @CriteriaSourceCodeID = Null
	END


--IF @CriteriaID = 0
--	BEGIN
--		SET @CriteriaID = Null
--	END



	SELECT
		CriteriaSourceCode.CriteriaSourceCodeID,
		CriteriaSourceCode.CriteriaID,
		CriteriaSourceCode.SourceCodeID,
		CriteriaSourceCode.LastModified,
		CriteriaSourceCode.UpdatedFlag,
		CriteriaSourceCode.LastStatEmployeeID,
		CriteriaSourceCode.AuditLogTypeID,
		SourceCode.SourceCodeName
	FROM 
		dbo.CriteriaSourceCode 
	JOIN
		SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
	WHERE 
		CriteriaSourceCode.CriteriaSourceCodeID = ISNULL(@CriteriaSourceCodeID, CriteriaSourceCode.CriteriaSourceCodeID)
	AND
		CriteriaSourceCode.CriteriaID = ISNULL(@CriteriaID, CriteriaSourceCode.CriteriaID)
	AND
		CriteriaSourceCode.SourceCodeID = ISNULL(@SourceCodeID, CriteriaSourceCode.SourceCodeID)				
	ORDER BY 1
GO

GRANT EXEC ON CriteriaSourceCodeSelect TO PUBLIC
GO
