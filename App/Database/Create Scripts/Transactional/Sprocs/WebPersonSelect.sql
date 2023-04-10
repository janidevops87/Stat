

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebPersonSelect')
	BEGIN
		PRINT 'Dropping Procedure WebPersonSelect';
		DROP Procedure WebPersonSelect;
	END
GO

PRINT 'Creating Procedure WebPersonSelect';
GO
CREATE Procedure WebPersonSelect
(
		@WebPersonID int = null output,
		@PersonID int = null,
		@PersonTypeID int = null,
		@OrganizationID int = null,
		@Inactive bit = 0
		
)
AS
/******************************************************************************
**	File: WebPersonSelect.sql
**	Name: WebPersonSelect
**	Desc: Selects multiple rows of WebPerson Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 10/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/29/2010		Bret Knoll			Initial Sproc Creation
**	06/21/2018		Ilya Osipov			Added SaltValue and HashedPassword columns
**	07/11/2018		Ilya Osipov			Removed WebPersonPassword from the code
**	10/26/2020		Mike Berenson		Added field: PasswordExpiration
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;

	SELECT
		WebPerson.WebPersonID,
		WebPerson.WebPersonUserName,
		WebPerson.PersonID,		
		WebPerson.UnusedField1,
		WebPerson.LastModified,
		WebPerson.WebPersonSessionCounter,
		WebPerson.UnusedField2,
		WebPerson.WebPersonLastSessionAccess,
		WebPerson.WebPersonEmail,
		WebPerson.UpdatedFlag,
		WebPerson.WebPersonUserAgent,
		WebPerson.Access,
		WebPerson.LastStatEmployeeID,
		WebPerson.AuditLogTypeID,
		WebPerson.SaltValue,		
		WebPerson.HashedPassword,
		WebPerson.PasswordExpiration
	FROM 
		dbo.WebPerson 
	JOIN
		Person ON Person.PersonID = WebPerson.PersonID
	WHERE 
		WebPerson.WebPersonID = ISNULL(@WebPersonID, WebPerson.WebPersonID)
	AND
		WebPerson.PersonID = ISNULL(@PersonID, WebPerson.PersonID)	
	AND
		Person.OrganizationID = ISNULL(@OrganizationID, Person.OrganizationID)	
	AND 
		(ISNULL(Person.Inactive, 0) = @Inactive)		
	ORDER BY 1;
GO

GRANT EXEC ON WebPersonSelect TO PUBLIC;
GO
