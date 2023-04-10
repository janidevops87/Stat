

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'MessageUpdate')
	BEGIN
		PRINT 'Dropping Procedure MessageUpdate'
		DROP Procedure MessageUpdate
	END
GO

PRINT 'Creating Procedure MessageUpdate'
GO
CREATE Procedure MessageUpdate
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
**	File: MessageUpdate.sql
**	Name: MessageUpdate
**	Desc: Updates Message Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
**  04/28/2014		Chris Carroll		Increased MessageDescription param length to 1000, CCRST197 wi:14838
*******************************************************************************/

UPDATE
	dbo.[Message] 	
SET 
		CallID = @CallID,
		MessageCallerName = @MessageCallerName,
		MessageCallerPhone = @MessageCallerPhone,
		MessageCallerOrganization = @MessageCallerOrganization,
		OrganizationID = @OrganizationID,
		PersonID = @PersonID,
		MessageTypeID = @MessageTypeID,
		MessageUrgent = @MessageUrgent,
		MessageDescription = @MessageDescription,
		Inactive = @Inactive,
		LastModified = GetDate(),
		MessageExtension = @MessageExtension,
		MessageImportPatient = @MessageImportPatient,
		MessageImportUNOSID = @MessageImportUNOSID,
		MessageImportCenter = @MessageImportCenter,
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	MessageID = @MessageID; 				

GO

GRANT EXEC ON MessageUpdate TO PUBLIC
GO
