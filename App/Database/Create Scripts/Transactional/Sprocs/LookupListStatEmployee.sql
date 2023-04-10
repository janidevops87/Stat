IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'LookupListStatEmployee')
	BEGIN
		PRINT 'Dropping Procedure LookupListStatEmployee'
		DROP Procedure LookupListStatEmployee
	END
GO

PRINT 'Creating Procedure LookupListStatEmployee' 
GO
CREATE Procedure LookupListStatEmployee
(
	@StatEmployeeUserId int
)
AS
/******************************************************************************
**		File: LookupListStatEmployee.sql
**		Desc: Select the data rom the Lookup List
**		Auth: Tanvir Ather
**		Date: 02/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------				-------------------------------------------
**	01/18/2008	Tanvir Ather		Initial Sproc creation
**  5/25/2011	Bret Knoll			Added Set Nocount and Set Transaction....
*******************************************************************************/
SET NOCOUNT ON;  
  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT
	se.StatEmployeeID AS ListId,
	ISNULL(se.StatEmployeeFirstName + ' ', '') + ISNULL(se.StatEmployeeLastName + ' ', '') AS FieldValue
FROM dbo.StatEmployee se 
	INNER JOIN Person p ON  se.PersonID = p.PersonID
	INNER JOIN Organization org ON  org.OrganizationID = p.OrganizationID
WHERE Org.OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeUserId)
	AND p.Inactive <> 1
ORDER BY FieldValue
GO

GRANT EXEC ON LookupListStatEmployee TO PUBLIC
GO

