  IF EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'GetOrganizationsByAlertGroup')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByAlertGroup'
		DROP Function GetOrganizationsByAlertGroup
	END
GO

PRINT 'Creating Function GetOrganizationsByAlertGroup' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByAlertGroup 
(
	@AlertGroupFieldValue nvarchar(125)= NULL
)  
RETURNS @OrganizationIDTable TABLE
	(
		OrganizationID int
	) 		
AS
/******************************************************************************
**	File: GetOrganizationsByAlertGroup.sql
**	Name: GetOrganizationsByAlertGroup
**	Desc: Get the OrganizationId where the Organization is associated to the AlertGroup
**	Auth: Bret Knoll
**	Date: 06/24/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	06/24/2009	Bret Knoll		Initial Function Creation]
**  10/25/2010	Bret Knoll		Removing CharIndex
*******************************************************************************/
BEGIN
	INSERT @OrganizationIDTable
	SELECT     
		AlertOrganization.OrganizationID
	FROM         
		Alert 
	INNER JOIN
		AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
	WHERE   
		(Alert.AlertGroupName = @AlertGroupFieldValue)
	
RETURN
END
GO




