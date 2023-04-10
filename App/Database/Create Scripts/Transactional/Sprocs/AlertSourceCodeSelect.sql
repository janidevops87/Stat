

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertSourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure AlertSourceCodeSelect'
		DROP Procedure AlertSourceCodeSelect
	END
GO

PRINT 'Creating Procedure AlertSourceCodeSelect'
GO
CREATE Procedure AlertSourceCodeSelect
(
		@AlertSourceCodeID int = null output,
		@AlertID int = null,
		@SourceCodeID int = null					
)
AS
/******************************************************************************
**	File: AlertSourceCodeSelect.sql
**	Name: AlertSourceCodeSelect
**	Desc: Selects multiple rows of AlertSourceCode Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AlertSourceCode.AlertSourceCodeID,
		AlertSourceCode.AlertID,
		AlertSourceCode.SourceCodeID,
		AlertSourceCode.LastModified,
		AlertSourceCode.UpdatedFlag
	FROM 
		dbo.AlertSourceCode 
	WHERE 
		AlertSourceCode.AlertSourceCodeID = ISNULL(@AlertSourceCodeID, AlertSourceCode.AlertSourceCodeID)
	AND
		AlertSourceCode.AlertID = ISNULL(@AlertID, AlertSourceCode.AlertID)
	AND
		AlertSourceCode.SourceCodeID = ISNULL(@SourceCodeID, AlertSourceCode.SourceCodeID)				
	ORDER BY 1
GO

GRANT EXEC ON AlertSourceCodeSelect TO PUBLIC
GO
