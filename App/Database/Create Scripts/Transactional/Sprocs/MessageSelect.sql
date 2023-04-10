

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MessageSelect')
	BEGIN
		PRINT 'Dropping Procedure MessageSelect'
		DROP Procedure MessageSelect
	END
GO

PRINT 'Creating Procedure MessageSelect'
GO
CREATE Procedure MessageSelect
(
		@MessageID int = null output,
		@CallID int = null
)
AS
/******************************************************************************
**	File: MessageSelect.sql
**	Name: MessageSelect
**	Desc: Selects multiple rows of Message Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
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
	JOIN
		Call ON Call.CallID = Message.CallID
	WHERE 
		Message.MessageID = ISNULL(@MessageID, Message.MessageID)
	AND
		Message.CallID = ISNULL(@CallID, Message.CallID)
	ORDER BY 1
GO

GRANT EXEC ON MessageSelect TO PUBLIC
GO
