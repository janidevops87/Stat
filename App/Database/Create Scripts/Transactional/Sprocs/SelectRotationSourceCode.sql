

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationSourceCode')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationSourceCode'
		PRINT GETDATE()
		DROP Procedure SelectRotationSourceCode
	END
GO

PRINT 'Creating Procedure SelectRotationSourceCode'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationSourceCode
(
		@RotationGroupID int = null,
		@RotationID int = null,
		@RotationSourceCodeID int = null					
)
AS
/******************************************************************************
**	File: SelectRotationSourceCode.sql
**	Name: SelectRotationSourceCode
**	Desc: Selects multiple rows of RotationSourceCode Based on Id  fields 
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
		RotationSourceCode.ID,
		RotationSourceCode.RotationGroupID,
		RotationSourceCode.RotationID,
		RotationSourceCode.RotationSourceCodeID,
		RotationSourceCode.RotationSourcecodeName,
		RotationSourceCode.RotationSourceCodeType
	FROM 
		dbo.RotationSourceCode 
	WHERE 
		RotationSourceCode.RotationGroupID = ISNULL(@RotationGroupID, RotationSourceCode.RotationGroupID)
	AND
		RotationSourceCode.RotationID = ISNULL(@RotationID, RotationSourceCode.RotationID)
	AND
		RotationSourceCode.RotationSourceCodeID = ISNULL(@RotationSourceCodeID, RotationSourceCode.RotationSourceCodeID)				

GO

GRANT EXEC ON SelectRotationSourceCode TO PUBLIC
GO
