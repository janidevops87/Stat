IF EXISTS (SELECT * FROM sysobjects WHERE type = 'FN' AND name = 'GetOrganizationsByStatEmployeeId')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByStatEmployeeId'
		DROP Function GetOrganizationsByStatEmployeeId
	END
GO

PRINT 'Creating Function GetOrganizationsByStatEmployeeId' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByStatEmployeeId 
(
	@StatEmployeeId int
)  
RETURNS int
AS
/******************************************************************************
**	File: GetOrganizationsByStatEmployeeId.sql
**	Name: GetOrganizationsByStatEmployeeId
**	Desc: Get the OrganizationId where StatEmployeeId belongs to
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Function Creation
*******************************************************************************/

BEGIN
	DECLARE @OrganizationId int

	SELECT @OrganizationId = org.OrganizationId
	FROM Organization org 
		INNER JOIN person p on org.OrganizationID = p.OrganizationID
		INNER JOIN StatEmployee se on p.PersonID = se.PersonID
	WHERE se.StatEmployeeId = @StatEmployeeId

	RETURN(@OrganizationId)
END
GO


