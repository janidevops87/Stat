IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertPerson')
	BEGIN
		PRINT 'Dropping Procedure InsertPerson'
		DROP  Procedure  InsertPerson
	END

GO

PRINT 'Creating Procedure InsertPerson'
GO
CREATE Procedure InsertPerson
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
**		File: InsertPerson.sql
**		Name: InsertPerson
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
**		@PersonID int, 
**		@PersonFirst varchar(50), 
**		@PersonMI varchar(1), 
**		@PersonLast varchar(50), 
**		@PersonTypeID int, 
**		@OrganizationID int, 
**		@PersonNotes varchar(255), 
**		@PersonBusy smallint, 
**		@Verified smallint, 
**		@Inactive smallint, **		
**		@PersonBusyUntil smalldatetime, 
**		@PersonTempNoteActive smallint, 
**		@PersonTempNoteExpires smalldatetime, 
**		@PersonTempNote varchar(255), 
**		@Unused varchar(30), 
**		@UpdatedFlag smallint, 
**		@AllowInternetScheduleAccess smallint, 
**		@PersonSecurity int, 
**		@PersonArchive smallint, 
**		@LastStatEmployeeID int
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

INSERT
	Person
	(		 
		PersonFirst, 
		PersonMI, 
		PersonLast, 
		PersonTypeID, 
		OrganizationID, 
		PersonNotes, 
		PersonBusy, 
		Verified, 
		Inactive, 
		LastModified, 
		PersonBusyUntil, 
		PersonTempNoteActive, 
		PersonTempNoteExpires, 
		PersonTempNote, 
		Unused, 
		AllowInternetScheduleAccess, 
		PersonSecurity, 
		PersonArchive, 
		LastStatEmployeeID, 
		AuditLogTypeID 
	)
VALUES
	(
		@PersonFirst, 
		@PersonMI, 
		@PersonLast, 
		@PersonTypeID, 
		@OrganizationID, 
		@PersonNotes, 
		@PersonBusy, 
		@Verified, 
		@Inactive, 
		GetDate(), -- @LastModified, 
		@PersonBusyUntil, 
		@PersonTempNoteActive, 
		@PersonTempNoteExpires, 
		@PersonTempNote, 
		@Unused, 
		@AllowInternetScheduleAccess, 
		@PersonSecurity, 
		@PersonArchive, 
		@LastStatEmployeeID, 
		1 -- @AuditLogTypeID, 1 = Create

	)		

SELECT
	PersonID, 
	PersonFirst, 
	PersonMI, 
	PersonLast, 
	PersonTypeID, 
	OrganizationID, 
	PersonNotes, 
	PersonBusy, 
	Verified, 
	Inactive, 
	PersonBusyUntil, 
	PersonTempNoteActive, 
	PersonTempNoteExpires, 
	PersonTempNote, 
	Unused, 
	AllowInternetScheduleAccess, 
	PersonSecurity, 
	PersonArchive 
FROM
	Person
WHERE
	PersonID = SCOPE_IDENTITY() 
	

GO

GRANT EXEC ON InsertPerson TO PUBLIC

GO
