

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonPhoneSelect')
	BEGIN
		PRINT 'Dropping Procedure PersonPhoneSelect'
		DROP Procedure PersonPhoneSelect
	END
GO

PRINT 'Creating Procedure PersonPhoneSelect'
GO
CREATE Procedure PersonPhoneSelect
(
		@PersonPhoneID int = null output,
		@PersonID int = null,
		@PhoneID int = null,
		@OrganizationID int = null,
		@Inactive bit = 0
)
AS
/******************************************************************************
**	File: PersonPhoneSelect.sql
**	Name: PersonPhoneSelect
**	Desc: Selects multiple rows of PersonPhone Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 10/6/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/6/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
-- CHECK

	SELECT
		PersonPhone.PersonPhoneID,
		PersonPhone.PersonID,
		PersonPhone.PhoneID,
		Phone AS Phone,
		Phone.PhoneTypeID,
		PhoneType.PhoneTypeName AS PhoneType,
		PersonPhone.Unused,
		PersonPhone.PersonPhonePin,
		Phone.PhonePin,
		PersonPhone.LastModified,
		PersonPhone.PhoneAlphaPagerEmail,
		PersonPhone.UpdatedFlag,
		PersonPhone.LastStatEmployeeID,
		PersonPhone.AuditLogTypeID,
		PersonPhone.PagerTypeID,
		PagerType AS PagerType,
		PersonPhone.EmailTypeID,
		EmailType AS EmailType,
		PersonPhone.AutoResponse
	FROM 
		dbo.PersonPhone 
	JOIN
		Person ON Person.PersonID = PersonPhone.PersonID
	JOIN 
		Organization ON Person.OrganizationID = Organization.OrganizationID
	JOIN
		fn_PhoneByPhoneID(null) AS Phone ON Phone.PhoneID = PersonPhone.PhoneID
	LEFT JOIN
		PagerType ON PagerType.PagerTypeID = PersonPhone.PagerTypeID
	LEFT JOIN
		EmailType ON EmailType.EmailTypeID = PersonPhone.EmailTypeID
	LEFT JOIN PhoneType ON PhoneType.PhoneTypeID = Phone.PhoneTypeID
	WHERE 
		PersonPhone.PersonPhoneID = ISNULL(@PersonPhoneID, PersonPhone.PersonPhoneID)
	AND
		PersonPhone.PersonID = ISNULL(@PersonID, PersonPhone.PersonID)
	AND
		PersonPhone.PhoneID = ISNULL(@PhoneID, PersonPhone.PhoneID)
	AND 
		Person.OrganizationID = ISNULL(@OrganizationID, Person.OrganizationID) 	
	AND 
		(ISNULL(Person.Inactive, 0) = @Inactive)
		
	ORDER BY 1
GO

GRANT EXEC ON PersonPhoneSelect TO PUBLIC
GO
