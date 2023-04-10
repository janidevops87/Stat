   IF EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'GetOrganizationsByServiceLevelGroup')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByServiceLevelGroup'
		DROP Function GetOrganizationsByServiceLevelGroup
	END
GO

PRINT 'Creating Function GetOrganizationsByServiceLevelGroup' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByServiceLevelGroup 
(
	@ServiceLevelGroupFieldValue nvarchar(125)= NULL
)  
RETURNS @OrganizationIDTable TABLE
	(
		OrganizationID int
	) 		
AS	
/******************************************************************************
**	File: GetOrganizationsByServiceLevelGroup.sql
**	Name: GetOrganizationsByServiceLevelGroup
**	Desc: Get the OrganizationId where the Organization is associated to the ServiceLevelGroup
**	Auth: Bret Knoll
**	Date: 06/24/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	06/24/2009	Bret Knoll		Initial Function Creation
**	7/14/2010	Bret Knoll		Resave for Release
**  10/25/2010	Bret Knoll		Removing CharIndex
*******************************************************************************/
BEGIN
	INSERT @OrganizationIDTable
	SELECT     
		ServiceLevel30Organization.OrganizationID
	FROM         
		ServiceLevel 
	INNER JOIN
		ServiceLevel30Organization ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID
	WHERE     
		(ServiceLevel.ServiceLevelGroupName = @ServiceLevelGroupFieldValue)
		
	AND (ServiceLevelStatus = 1) -- 1 = Current
RETURN
END
GO


