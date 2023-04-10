

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PagerTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure PagerTypeSelect'
		DROP Procedure PagerTypeSelect
	END
GO

PRINT 'Creating Procedure PagerTypeSelect'
GO
CREATE Procedure PagerTypeSelect
(
		@PagerTypeID int = null output					
)
AS
/******************************************************************************
**	File: PagerTypeSelect.sql
**	Name: PagerTypeSelect
**	Desc: Selects multiple rows of PagerType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 10/6/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/6/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		PagerType.PagerTypeID,
		PagerType.PagerType,
		PagerType.LastModified,
		PagerType.LastStatEmployeeID,
		PagerType.AuditLogTypeID
	FROM 
		dbo.PagerType 

	WHERE 
		PagerType.PagerTypeID = ISNULL(@PagerTypeID, PagerType.PagerTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON PagerTypeSelect TO PUBLIC
GO
