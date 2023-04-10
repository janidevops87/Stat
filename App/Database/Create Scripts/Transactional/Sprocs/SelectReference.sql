

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectReference')
	BEGIN
		PRINT 'Dropping Procedure SelectReference'
		PRINT GETDATE()
		DROP Procedure SelectReference
	END
GO

PRINT 'Creating Procedure SelectReference'
PRINT GETDATE()
GO
CREATE Procedure SelectReference
(
		@ReferenceID int = null output				
)
AS
/******************************************************************************
**	File: SelectReference.sql
**	Name: SelectReference
**	Desc: Selects multiple rows of Reference Based on Id  fields 
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
		Reference.ReferenceID,
		Reference.ReferenceText,
		Reference.ReferenceTypeID,
		Reference.Verified,
		Reference.LastModified,
		Reference.Unused1,
		Reference.Unused2,
		Reference.UpdatedFlag
	FROM 
		dbo.Reference 
	WHERE 
		Reference.ReferenceID = ISNULL(@ReferenceID, Reference.ReferenceID)

GO

GRANT EXEC ON SelectReference TO PUBLIC
GO
