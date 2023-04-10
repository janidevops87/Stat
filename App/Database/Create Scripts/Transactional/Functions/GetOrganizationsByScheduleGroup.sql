  IF EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'GetOrganizationsByScheduleGroup')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByScheduleGroup'
		DROP Function GetOrganizationsByScheduleGroup
	END
GO

PRINT 'Creating Function GetOrganizationsByScheduleGroup' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByScheduleGroup 
(
	@ScheduleGroupFieldValue nvarchar(125)= NULL
)  
RETURNS @OrganizationIDTable TABLE
	(
		OrganizationID int
	) 		
AS
/******************************************************************************
**	File: GetOrganizationsByScheduleGroup.sql
**	Name: GetOrganizationsByScheduleGroup
**	Desc: Get the OrganizationId where the Organization is associated to the ScheduleGroup
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
	SELECT     
		ScheduleGroupOrganization.OrganizationID
	FROM         
		ScheduleGroup 
	INNER JOIN
		ScheduleGroupOrganization ON ScheduleGroup.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
	WHERE	
		(ScheduleGroup.ScheduleGroupName = @ScheduleGroupFieldValue) 
	AND (ScheduleGroup.Inactive = 0)
RETURN
END

GO


