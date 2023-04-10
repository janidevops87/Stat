

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectMessage')
	BEGIN
		PRINT 'Dropping Procedure SelectMessage';
		PRINT GETDATE();
		DROP Procedure SelectMessage;
	END
GO

PRINT 'Creating Procedure SelectMessage';
PRINT GETDATE();
GO
CREATE Procedure SelectMessage
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: SelectMessage.sql
**	Name: SelectMessage
**	Desc: Selects multiple rows of Message Based on Id  fields 
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
		Message.MessageID,
		Message.CallID,
		Message.MessageCallerName,
		Message.MessageCallerPhone,
		Message.MessageCallerOrganization,
		Message.OrganizationID,
		Message.PersonID,
		Message.MessageTypeID,
		Message.MessageUrgent,
		Message.MessageDescription,
		Message.Inactive,
		Message.LastModified,
		Message.MessageExtension,
		Message.MessageImportPatient,
		Message.MessageImportUNOSID,
		Message.MessageImportCenter,
		Message.UpdatedFlag,
		Message.LastStatEmployeeID,
		Message.AuditLogTypeID
	FROM 
		dbo.Message 
	WHERE 
		@CallId IS NULL OR Message.CallID = @CallID;

GO

GRANT EXEC ON SelectMessage TO PUBLIC;
GO
