

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CredentialUpdate')
	BEGIN
		PRINT 'Dropping Procedure CredentialUpdate'
		DROP Procedure CredentialUpdate
	END
GO

PRINT 'Creating Procedure CredentialUpdate'
GO
CREATE Procedure CredentialUpdate
(
		@CredentialID int = null output,
		@Credential varchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CredentialUpdate.sql
**	Name: CredentialUpdate
**	Desc: Updates Credential Based on Id field 
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

UPDATE
	dbo.Credential 	
SET 
		Credential = @Credential,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CredentialID = @CredentialID 				

GO

GRANT EXEC ON CredentialUpdate TO PUBLIC
GO
