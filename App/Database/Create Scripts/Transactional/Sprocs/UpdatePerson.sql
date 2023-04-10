 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdatePerson')
	BEGIN
		PRINT 'Dropping Procedure UpdatePerson'
		DROP  Procedure  UpdatePerson
	END

GO

PRINT 'Creating Procedure UpdatePerson'
GO
CREATE Procedure UpdatePerson
    @PersonID int = NULL , 
    @PersonFirst varchar(50) = NULL , 
    @PersonMI varchar(1) = NULL , 
    @PersonLast varchar(50) = NULL , 
    @PersonTypeID int = NULL , 
    @OrganizationID int = NULL , 
    @PersonNotes varchar(255) = NULL , 
    @PersonBusy smallint = NULL , 
    @Verified smallint = NULL , 
    @Inactive smallint = NULL , 
    @PersonBusyUntil smalldatetime = NULL , 
    @PersonTempNoteActive smallint = NULL , 
    @PersonTempNoteExpires smalldatetime = NULL , 
    @PersonTempNote varchar(255) = NULL , 
    @Unused varchar(30) = NULL , 
    @AllowInternetScheduleAccess smallint = NULL , 
    @PersonSecurity int = NULL , 
    @PersonArchive smallint = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdatePerson.sql
**		Name: UpdatePerson
**		Desc: 
**
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See list.
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/

UPDATE
	Person
SET
	PersonFirst = ISNULL(@PersonFirst, PersonFirst), 
	PersonMI = ISNULL(@PersonMI, PersonMI), 
	PersonLast = ISNULL(@PersonLast, PersonLast), 
	PersonTypeID = ISNULL(@PersonTypeID, PersonTypeID), 
	OrganizationID = ISNULL(@OrganizationID, OrganizationID), 
	PersonNotes = ISNULL(@PersonNotes, PersonNotes), 
	PersonBusy = ISNULL(@PersonBusy, PersonBusy), 
	Verified = ISNULL(@Verified, Verified), 
	Inactive = ISNULL(@Inactive, Inactive), 
	LastModified = GetDate(), 
	PersonBusyUntil = ISNULL(@PersonBusyUntil, PersonBusyUntil), 
	PersonTempNoteActive = ISNULL(@PersonTempNoteActive, PersonTempNoteActive), 
	PersonTempNoteExpires = @PersonTempNoteExpires,  
	PersonTempNote = ISNULL(@PersonTempNote, PersonTempNote), 
	Unused = ISNULL(@Unused, Unused), 
	AllowInternetScheduleAccess = ISNULL(@AllowInternetScheduleAccess, AllowInternetScheduleAccess), 
	PersonSecurity = ISNULL(@PersonSecurity, PersonSecurity), 
	PersonArchive = ISNULL(@PersonArchive, PersonArchive), 
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE
	PersonID = @PersonID



GO

GRANT EXEC ON UpdatePerson TO PUBLIC

GO
