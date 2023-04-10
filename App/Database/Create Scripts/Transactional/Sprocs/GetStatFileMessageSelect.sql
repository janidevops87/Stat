  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileMessageSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileMessageSelect]
	PRINT 'Dropping Procedure: GetStatFileMessageSelect'
END
	PRINT 'Creating Procedure: GetStatFileMessageSelect'
GO

CREATE PROCEDURE [dbo].[GetStatFileMessageSelect]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetStatFileMessageSelect.sql
**		Name: GetStatFileMessageSelect
**		Desc:  Used on StatFile
**
**		Called by:  
**              
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/01/2009	Bret Knoll	initial
**		01/20/2010	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll	Added this note for inclusion in release
**		04/29/2014	ccarroll	Added Left to limit increased length on Message description, CCRST197 wi:14838
********************************************************************************/
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT DISTINCT 
	Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, Call.LastModified),120) as LastModified, 
	MessageID, 
	CallNumber, 
	Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, CallDateTime),120) as CallDateTime, 
	StatEmployeeFirstName + ' ' + StatEmployeeLastName 'MessageTakenBy', 
	Message.MessageTypeID, 
	MessageTypeName, 
	PersonFirst +  ' ' + PersonLast 'MessageForPerson', 
	OrganizationName, 
	REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', 
	MessageCallerName, 
	MessageCallerPhone, 
	MessageCallerOrganization 
	FROM 
		Message 
	JOIN Call ON Call.CallID = Message.CallID 
	LEFT JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
	LEFT JOIN Person ON Person.PersonID = Message.PersonID 
 	WHERE 
		Call.CallID IN (
						SELECT CallID FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
						UNION
						SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0				
						)		
	AND 
		Call.CallID NOT IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1)				
	ORDER BY LastModified		

GO
