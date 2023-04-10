

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'MessageInsert')
	BEGIN
		PRINT 'Dropping Procedure MessageInsert'
		DROP Procedure MessageInsert
	END
GO

PRINT 'Creating Procedure MessageInsert'
GO
CREATE Procedure MessageInsert
(
		@MessageID int = null output,
		@CallID int = null,
		@MessageCallerName varchar(80) = null,
		@MessageCallerPhone varchar(20) = null,
		@MessageCallerOrganization varchar(80) = null,
		@OrganizationID int = null,
		@PersonID int = null,
		@MessageTypeID int = null,
		@MessageUrgent smallint = null,
		@MessageDescription varchar(1000) = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@MessageExtension numeric(5,0) = null,
		@MessageImportPatient varchar(50) = null,
		@MessageImportUNOSID varchar(20) = null,
		@MessageImportCenter varchar(5) = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: MessageInsert.sql
**	Name: MessageInsert
**	Desc: Inserts Message Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
**  04/28/2014		Chris Carroll		Increased MessageDescription param length to 1000, CCRST197 wi:14838
*******************************************************************************/

INSERT	Message
	(
		CallID,
		MessageCallerName,
		MessageCallerPhone,
		MessageCallerOrganization,
		OrganizationID,
		PersonID,
		MessageTypeID,
		MessageUrgent,
		MessageDescription,
		Inactive,
		LastModified,
		MessageExtension,
		MessageImportPatient,
		MessageImportUNOSID,
		MessageImportCenter,
		UpdatedFlag,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@CallID,
		@MessageCallerName,
		@MessageCallerPhone,
		@MessageCallerOrganization,
		@OrganizationID,
		@PersonID,
		@MessageTypeID,
		@MessageUrgent,
		@MessageDescription,
		@Inactive,
		@LastModified,
		@MessageExtension,
		@MessageImportPatient,
		@MessageImportUNOSID,
		@MessageImportCenter,
		@UpdatedFlag,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @MessageID = SCOPE_IDENTITY()

EXEC MessageSelect @MessageID

GO

GRANT EXEC ON MessageInsert TO PUBLIC
GO
