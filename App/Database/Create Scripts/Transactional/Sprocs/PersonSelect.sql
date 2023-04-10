

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonSelect')
	BEGIN
		PRINT 'Dropping Procedure PersonSelect'
		DROP Procedure PersonSelect
	END
GO

PRINT 'Creating Procedure PersonSelect'
GO
CREATE Procedure PersonSelect
(
		@PersonID int = null output,
		@PersonTypeID int = null,
		@OrganizationID int = null,
		@Inactive bit = 0
)
 
AS
/******************************************************************************
**	File: PersonSelect.sql
**	Name: PersonSelect
**	Desc: Selects multiple rows of Person Based on Id  fields 
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
**	05/31/2011		Bret Knoll			Added case for tempnote and busyuntil dateTime
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	
	SELECT
		COALESCE(Person.Inactive, 0) Inactive,
		Person.PersonID,
		Person.PersonFirst,
		Person.PersonMI, 
		Person.PersonLast,
		Person.PersonTypeID,
		PersonTypeName AS PersonType,
		Person.OrganizationID,
		OrganizationName AS Organization,
		Person.PersonNotes,		
		Person.PersonBusy,
		Person.Verified,
		Person.LastModified,
		CASE 
			WHEN Person.PersonBusy = 0 
			THEN NULL
			ELSE Person.PersonBusyUntil
		END 'PersonBusyUntil', 
		Person.PersonTempNoteActive,
		CASE 
			WHEN Person.PersonTempNoteActive = 0 
			THEN NULL
			ELSE Person.PersonTempNoteExpires
		END	'PersonTempNoteExpires',
		Person.PersonTempNote, 
		Person.Unused,
		Person.UpdatedFlag,
		Person.AllowInternetScheduleAccess, 
		Person.PersonSecurity,
		Person.PersonArchive,
		Person.LastStatEmployeeID,
		Person.AuditLogTypeID,
		Person.Credential,
		Person.TrainedRequestorID,
		TrainedRequestor AS TrainedRequestor,
		Person.RaceID,
		RaceName AS Race,
		Person.GenderID,
		Gender AS Gender
	FROM 
		dbo.Person 
	LEFT JOIN
		PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
	JOIN
		Organization ON Organization.OrganizationID = Person.OrganizationID
	LEFT JOIN
		Gender ON Gender.GenderID = Person.GenderID
	LEFT JOIN
		Race ON Race.RaceID = Person.RaceID
	LEFT JOIN
		TrainedRequestor ON TrainedRequestor.TrainedRequestorID = Person.TrainedRequestorID
	WHERE 
		Person.PersonID = ISNULL(@PersonID, Person.PersonID)
	AND
		ISNULL(Person.PersonTypeID, 0) = ISNULL(@PersonTypeID, ISNULL(Person.PersonTypeID, 0))
	AND
		Person.OrganizationID = ISNULL(@OrganizationID, Person.OrganizationID)
	AND 
		(ISNULL(Person.Inactive, 0) = @Inactive)
	
	ORDER BY Person.PersonLast, Person.PersonFirst, Person.PersonMI
GO

GRANT EXEC ON PersonSelect TO PUBLIC
GO
