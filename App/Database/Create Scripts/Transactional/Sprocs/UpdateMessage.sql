 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateMessage')
	BEGIN
		PRINT 'Dropping Procedure UpdateMessage';
		DROP  Procedure  UpdateMessage;
	END

GO

PRINT 'Creating Procedure UpdateMessage';
GO
CREATE Procedure UpdateMessage
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
**		Name: UpdateMessage
**		Desc: Update a record into the message table
**
**              
**		Return values: returns the inserted record
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/13/07	Thien Ta			initial
**	    05/30/07	Bret Knoll			8.4.3.8 audit LogEvent
**										Set LastModified Date
**										add LastStatEmployeeID
**										add AuditLogTypeID
**		04/28/2014	Chris Carroll		Increase MessageDescription length to 1000 characters, CCRST197 wi:14838
*******************************************************************************/


UPDATE
	[Message] 
SET	 
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
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify			
WHERE
	CallID = @CallID;



GO
