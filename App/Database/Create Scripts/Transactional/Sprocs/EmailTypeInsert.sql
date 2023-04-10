

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'EmailTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure EmailTypeInsert'
		DROP Procedure EmailTypeInsert
	END
GO

PRINT 'Creating Procedure EmailTypeInsert'
GO
CREATE Procedure EmailTypeInsert
(
		@EmailTypeID int = null output,
		@EmailType varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: EmailTypeInsert.sql
**	Name: EmailTypeInsert
**	Desc: Inserts EmailType Based on Id field 
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

INSERT	EmailType
	(
		EmailType,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@EmailType,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @EmailTypeID = SCOPE_IDENTITY()

EXEC EmailTypeSelect @EmailTypeID

GO

GRANT EXEC ON EmailTypeInsert TO PUBLIC
GO
