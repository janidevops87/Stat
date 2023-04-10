   IF EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'GetOrganizationsByCriteriaGroup')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByCriteriaGroup'
		DROP Function GetOrganizationsByCriteriaGroup
	END
GO

PRINT 'Creating Function GetOrganizationsByCriteriaGroup' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByCriteriaGroup 
(
	@CriteriaGroupFieldValue nvarchar(125)= NULL
)  
RETURNS @OrganizationIDTable TABLE
	(
		OrganizationID int
	) 		
AS
/******************************************************************************
**	File: GetOrganizationsByCriteriaGroup.sql
**	Name: GetOrganizationsByCriteriaGroup
**	Desc: Get the OrganizationId where the Organization is associated to the CriteriaGroup
**	Auth: Bret Knoll
**	Date: 06/24/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	06/24/2009	Bret Knoll		Initial Function Creation
**  10/25/2010	Bret Knoll		Removing CharIndex
*******************************************************************************/
BEGIN
	INSERT @OrganizationIDTable
	SELECT DISTINCT
		CriteriaOrganization.OrganizationID
	FROM         
		Criteria 
	INNER JOIN
		CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
	WHERE   
		(Criteria.CriteriaGroupName = @CriteriaGroupFieldValue) 
	AND 
		(Criteria.CriteriaStatus = 1 )
RETURN
END

GO