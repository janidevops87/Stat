IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'LookupListPerson')
	BEGIN
		PRINT 'Dropping Procedure LookupListPerson'
		DROP Procedure LookupListPerson
	END
GO

PRINT 'Creating Procedure LookupListPerson'
GO
CREATE Procedure LookupListPerson
(
	@StatEmployeeUserId int
)
AS
/******************************************************************************
**		File: LookupListPerson.sql
**		Desc: Select the data rom the Lookup List
**		Auth: Tanvir Ather
**		Date: 02/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------				-------------------------------------------
**	01/18/2008	Tanvir Ather		Initial Sproc creation
*******************************************************************************/

SELECT
	p.PersonId AS ListId,
	ISNULL(p.PersonFirst + ' ', '') + ISNULL(p.PersonMI + ' ', '') + ISNULL(p.PersonLast + ' ', '') AS FieldValue
FROM dbo.Person p 
	INNER JOIN Organization org ON  org.OrganizationID = p.OrganizationID
WHERE Org.OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeUserId)
	AND p.Inactive <> 1
ORDER BY FieldValue
GO

GRANT EXEC ON LookupListPerson TO PUBLIC
GO

