IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_OrganizationPersonnelListing')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_OrganizationPersonnelListing';
	DROP PROCEDURE sps_rpt_OrganizationPersonnelListing;
END
GO

PRINT 'Creating Procedure sps_rpt_OrganizationPersonnelListing';
GO
CREATE PROCEDURE [dbo].[sps_rpt_OrganizationPersonnelListing]
(
	@OrganizationID		INT	= NULL,
	@PersonId			INT = NULL
)
AS

/******************************************************************************
**		File: sps_rpt_OrganizationPersonnelListing.sql
**		Name: sps_rpt_OrganizationPersonnelListing
**		Desc: This sproc is used for OrganizationPersonnelListing and ScheduledContacts.
**
**		IMPORTANT: Please test both reports when any changes are made to this query.
**
**		Return values:
** 
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  ?				?					Initial release
**	06/30/2020		Mike Berenson		Refactored
**	02/17/2021		James Gerberich		Added @PersonId for new combination report. TFS 72485
**	07/01/2021		James Gerberich		Off-load sorting to rdl. TFS 74390
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	Person.PersonID,
	Person.PersonFirst,
	Person.PersonLast,
	Person.PersonLast + ', ' + Person.PersonFirst AS Person,
	PersonType.PersonTypeName,
	CASE
		WHEN Phone.PhoneTypeID = 11 --Email
		THEN PersonPhone.PhoneAlphaPagerEmail
		ELSE
			CASE 
				WHEN Phone.PhoneAreaCode IS NULL 
					OR Phone.PhonePrefix IS NULL
					OR Phone.PhoneNumber IS NULL THEN ''
				ELSE '(' + Phone.PhoneAreaCode + ') ' + Phone.PhonePrefix + '-' + Phone.PhoneNumber 
			END
	END AS Phone,
	ISNULL(PhoneType.PhoneTypeName, '') AS PhoneTypeName,
	ISNULL(Person.PersonNotes, '') AS PersonNotes
FROM 
	Person
	JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
	LEFT JOIN PersonPhone ON PersonPhone.PersonID = Person.PersonID
	LEFT JOIN Phone ON Phone.PhoneID = PersonPhone.PhoneID
	LEFT JOIN PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID
WHERE
	Person.PersonID = @PersonId
OR	(
		@PersonId IS NULL
		AND (
			Organization.OrganizationID = @OrganizationID 
			AND Person.Inactive <> 1
			)
	);
	
GO

GRANT EXEC ON sps_rpt_OrganizationPersonnelListing TO PUBLIC;
GO