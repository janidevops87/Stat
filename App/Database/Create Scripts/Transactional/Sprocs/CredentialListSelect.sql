

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CredentialListSelect')
	BEGIN
		PRINT 'Dropping Procedure CredentialListSelect'
		DROP Procedure CredentialListSelect
	END
GO

PRINT 'Creating Procedure CredentialListSelect'
GO
CREATE Procedure CredentialListSelect
(
		@CredentialID int = null output					
)
AS
/******************************************************************************
**	File: CredentialListSelect.sql
**	Name: CredentialListSelect
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
		Credential.CredentialID AS ListId,
		Credential.Credential AS FieldValue
	FROM 
		dbo.Credential 
	WHERE 
		Credential.CredentialID = ISNULL(@CredentialID, Credential.CredentialID)				
	ORDER BY 2
GO

GRANT EXEC ON CredentialListSelect TO PUBLIC
GO
