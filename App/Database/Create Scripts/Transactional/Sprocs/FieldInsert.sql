

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'FieldInsert')
	BEGIN
		PRINT 'Dropping Procedure FieldInsert'
		DROP Procedure FieldInsert
	END
GO

PRINT 'Creating Procedure FieldInsert'
GO
CREATE Procedure FieldInsert
(
		@FieldID int = null,
		@FieldName varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: FieldInsert.sql
**	Name: FieldInsert
**	Desc: Inserts Field Based on Id field 
**	Auth: Bret Knoll
**	Date: 12/7/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/7/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Field
	(
		FieldID,
		FieldName,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@FieldID,
		@FieldName,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @FieldID = SCOPE_IDENTITY()

EXEC FieldSelect @FieldID

GO

GRANT EXEC ON FieldInsert TO PUBLIC
GO
