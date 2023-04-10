IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertMessage')
	BEGIN
		PRINT 'Dropping Procedure InsertMessage'
		DROP  Procedure  InsertMessage
	END

GO

PRINT 'Creating Procedure InsertMessage'
GO
CREATE Procedure InsertMessage
    @MessageID int = NULL , 
    @CallID int , 
    @MessageCallerName varchar(80) = NULL , 
    @MessageCallerPhone varchar(20) = NULL , 
    @MessageCallerOrganization varchar(80) = NULL , 
    @OrganizationID int = NULL , 
    @PersonID int = NULL , 
    @MessageTypeID int = NULL , 
    @MessageUrgent smallint = NULL , 
    @MessageDescription varchar(1000) = NULL , 
    @Inactive smallint = NULL , 
    @MessageExtension numeric = NULL , 
    @MessageImportPatient varchar(50) = NULL , 
    @MessageImportUNOSID varchar(20) = NULL , 
    @MessageImportCenter varchar(5) = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL  

AS

/******************************************************************************
**		File: 
**		Name: InsertMessage
**		Desc: inserts a record into the message table
**
**              
**		Return values: returns the inserted record
**		
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------				-------------------------------------------
**		04/13/07	Bret Knoll				initial
**	    05/30/07	Bret Knoll				8.4.3.8 audit Message
**											Set LastModified Date
**											add LastStatEmployeeID
**											add AuditLogTypeID
**		04/29/2014	Chris Carroll			Changed MessageDescription param length to 1000, CCRST197 wi:14838			
*******************************************************************************/


INSERT 
	Message 
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
	LastModified,
	MessageExtension, 
	MessageImportPatient, 
	MessageImportUNOSID, 
	MessageImportCenter,
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
	GetDate(), 
	@MessageExtension, 
	@MessageImportPatient, 
	@MessageImportUNOSID, 
	@MessageImportCenter,
	@LastStatEmployeeID,
	1 --- @AuditLogTypeID  1 = Create
	)

SELECT
	MessageID,
	CallID, 
	MessageCallerName, 
	MessageCallerPhone, 
	MessageCallerOrganization, 
	OrganizationID, 
	PersonID, 
	MessageTypeID, 
	MessageUrgent, 
	MessageDescription, 
	MessageExtension, 
	MessageImportPatient, 
	MessageImportUNOSID, 
	MessageImportCenter
FROM 
	Message
WHERE
	MessageID = SCOPE_IDENTITY()		

GO

GRANT EXEC ON InsertMessage TO PUBLIC

GO
