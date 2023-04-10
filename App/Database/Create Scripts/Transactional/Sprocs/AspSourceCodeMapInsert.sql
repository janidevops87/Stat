

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapInsert')
	BEGIN
		PRINT 'Dropping Procedure AspSourceCodeMapInsert'
		DROP Procedure AspSourceCodeMapInsert
	END
GO

PRINT 'Creating Procedure AspSourceCodeMapInsert'
GO
CREATE Procedure AspSourceCodeMapInsert
(
		@AspSourceCodeMapID int = null output,
		@SourceCodeID int = null,
		@AspSourceCodeID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@AspSourceCodeName varchar(10) = null					
)
AS
/******************************************************************************
**	File: AspSourceCodeMapInsert.sql
**	Name: AspSourceCodeMapInsert
**	Desc: Inserts AspSourceCodeMap Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	AspSourceCodeMap
	(
		SourceCodeID,
		AspSourceCodeID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID,
		AspSourceCodeName
	)
VALUES
	(
		@SourceCodeID,
		@AspSourceCodeID,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1), /* insert */
		@AspSourceCodeName
	)

SET @AspSourceCodeMapID = SCOPE_IDENTITY()

EXEC AspSourceCodeMapSelect @AspSourceCodeMapID

GO

GRANT EXEC ON AspSourceCodeMapInsert TO PUBLIC
GO
