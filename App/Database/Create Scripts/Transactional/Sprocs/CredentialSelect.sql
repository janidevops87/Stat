

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CredentialSelect')
	BEGIN
		PRINT 'Dropping Procedure CredentialSelect'
		DROP Procedure CredentialSelect
	END
GO

PRINT 'Creating Procedure CredentialSelect'
GO
CREATE Procedure CredentialSelect
(
		@CredentialID int = null output					
)
AS
/******************************************************************************
**	File: CredentialSelect.sql
**	Name: CredentialSelect
**	Desc: Selects multiple rows of Credential Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Credential.CredentialID,
		Credential.Credential,
		Credential.LastModified,
		Credential.LastStatEmployeeID,
		Credential.AuditLogTypeID
	FROM 
		dbo.Credential 

	WHERE 
		Credential.CredentialID = ISNULL(@CredentialID, Credential.CredentialID)				
	ORDER BY 1
GO

GRANT EXEC ON CredentialSelect TO PUBLIC
GO
