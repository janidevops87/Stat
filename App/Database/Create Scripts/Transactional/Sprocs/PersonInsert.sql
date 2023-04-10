

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'PersonInsert')
	BEGIN
		PRINT 'Dropping Procedure PersonInsert'
		DROP Procedure PersonInsert
	END
GO

PRINT 'Creating Procedure PersonInsert'
GO 
CREATE Procedure PersonInsert
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
**	File: PersonInsert.sql
**	Name: PersonInsert
**	Desc: Inserts Person Based on Id field 
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

INSERT	Person
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
		UpdatedFlag,
		AllowInternetScheduleAccess,
		PersonSecurity,
		PersonArchive,
		LastStatEmployeeID,
		AuditLogTypeID,
		GenderID,
		RaceID,
		Credential,
		TrainedRequestorID
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
		@LastModified,
		@PersonBusyUntil,
		@PersonTempNoteActive,
		@PersonTempNoteExpires,
		@PersonTempNote,
		@Unused,
		@UpdatedFlag,
		@AllowInternetScheduleAccess,
		@PersonSecurity,
		@PersonArchive,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */,
		@GenderID,
		@RaceID,
		@Credential,
		@TrainedRequestorID
	)

SET @PersonID = SCOPE_IDENTITY()

EXEC PersonSelect @PersonID = @PersonID

GO

GRANT EXEC ON PersonInsert TO PUBLIC
GO
