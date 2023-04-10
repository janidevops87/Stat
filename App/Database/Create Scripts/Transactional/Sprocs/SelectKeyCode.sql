

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectKeyCode')
	BEGIN
		PRINT 'Dropping Procedure SelectKeyCode'
		PRINT GETDATE()
		DROP Procedure SelectKeyCode
	END
GO

PRINT 'Creating Procedure SelectKeyCode'
PRINT GETDATE()
GO
CREATE Procedure SelectKeyCode
(
		@KeyCodeID int = null output					
)
AS
/******************************************************************************
**	File: SelectKeyCode.sql
**	Name: SelectKeyCode
**	Desc: Selects multiple rows of KeyCode Based on Id  fields 
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
		KeyCode.KeyCodeID,
		KeyCode.KeyCodeName,
		KeyCode.KeyCodeNote,
		KeyCode.LastModified,
		KeyCode.UpdatedFlag
	FROM 
		dbo.KeyCode 

	WHERE 
		KeyCode.KeyCodeID = ISNULL(@KeyCodeID, KeyCode.KeyCodeID)				

GO

GRANT EXEC ON SelectKeyCode TO PUBLIC
GO
