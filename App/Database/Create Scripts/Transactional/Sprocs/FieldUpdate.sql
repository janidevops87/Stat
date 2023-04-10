

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'FieldUpdate')
	BEGIN
		PRINT 'Dropping Procedure FieldUpdate'
		DROP Procedure FieldUpdate
	END
GO

PRINT 'Creating Procedure FieldUpdate'
GO
CREATE Procedure FieldUpdate
(
		@FieldID int = null,
		@FieldName varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: FieldUpdate.sql
**	Name: FieldUpdate
**	Desc: Updates Field Based on Id field 
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

UPDATE
	dbo.Field 	
SET 
		
		FieldName = @FieldName,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	FieldID = @FieldID 				

GO

GRANT EXEC ON FieldUpdate TO PUBLIC
GO
