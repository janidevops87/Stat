

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PersonUpdate')
	BEGIN
		PRINT 'Dropping Procedure PersonUpdate'
		DROP Procedure PersonUpdate
	END
GO

PRINT 'Creating Procedure PersonUpdate'
GO
CREATE Procedure PersonUpdate
(
		@PersonID int = null output,
		@PersonFirst varchar(50) = null,
		@PersonMI varchar(1) = null,
		@PersonLast varchar(50) = null,
		@PersonTypeID int = null,
		@PersonType varchar(255) = null,
		@OrganizationID int = null,
		@Organization varchar(255) = null,
		@PersonNotes varchar(255) = null,
		@PersonBusy smallint = null,
		@Verified smallint = null,
		@Inactive smallint = null,
		@LastModified datetime = null,
		@PersonBusyUntil smalldatetime = null,
		@PersonTempNoteActive smallint = null,
		@PersonTempNoteExpires smalldatetime = null,
		@PersonTempNote varchar(255) = null,
		@Unused varchar(30) = null,
		@UpdatedFlag smallint = null,
		@AllowInternetScheduleAccess smallint = null,
		@PersonSecurity int = null,
		@PersonArchive smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@GenderID int = null,
		@Gender varchar(255) = null,
		@RaceID int = null,
		@Race varchar(255) = null,
		@Credential varchar(25) = null,
		@TrainedRequestorID int = null,
		@TrainedRequestor varchar(255) = null					
)
AS
/******************************************************************************
**	File: PersonUpdate.sql
**	Name: PersonUpdate
**	Desc: Updates Person Based on Id field 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.Person 	
SET 
		PersonFirst = @PersonFirst,
		PersonMI = @PersonMI,
		PersonLast = @PersonLast,
		PersonTypeID = @PersonTypeID,
		OrganizationID = @OrganizationID,
		PersonNotes = @PersonNotes,
		PersonBusy = @PersonBusy,
		Verified = @Verified,
		Inactive = @Inactive,
		LastModified = GetDate(),
		PersonBusyUntil = @PersonBusyUntil,
		PersonTempNoteActive = @PersonTempNoteActive,
		PersonTempNoteExpires = @PersonTempNoteExpires,
		PersonTempNote = @PersonTempNote,
		Unused = @Unused,
		UpdatedFlag = @UpdatedFlag,
		AllowInternetScheduleAccess = @AllowInternetScheduleAccess,
		PersonSecurity = @PersonSecurity,
		PersonArchive = @PersonArchive,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */,
		GenderID = @GenderID,
		RaceID = @RaceID,
		Credential = @Credential,
		TrainedRequestorID = @TrainedRequestorID
WHERE 
	PersonID = @PersonID 				

GO

GRANT EXEC ON PersonUpdate TO PUBLIC
GO
