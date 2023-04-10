

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CredentialInsert')
	BEGIN
		PRINT 'Dropping Procedure CredentialInsert'
		DROP Procedure CredentialInsert
	END
GO

PRINT 'Creating Procedure CredentialInsert'
GO
CREATE Procedure CredentialInsert
(
		@CredentialID int = null output,
		@Credential varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CredentialInsert.sql
**	Name: CredentialInsert
**	Desc: Inserts Credential Based on Id field 
**	Auth: Bret Knoll
**	Date: 9/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	Credential
	(
		Credential,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@Credential,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @CredentialID = SCOPE_IDENTITY()

EXEC CredentialSelect @CredentialID

GO

GRANT EXEC ON CredentialInsert TO PUBLIC
GO
