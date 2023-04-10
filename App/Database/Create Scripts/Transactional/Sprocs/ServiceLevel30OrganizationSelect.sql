
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevel30OrganizationSelect'
		DROP Procedure ServiceLevel30OrganizationSelect
	END
GO

PRINT 'Creating Procedure ServiceLevel30OrganizationSelect'
GO
CREATE Procedure ServiceLevel30OrganizationSelect
(
		@ServiceLevelOrganizationID int = null,
		@ServiceLevelID int = null,
		@OrganizationID int = null
		 				
)
AS
/******************************************************************************
**	File: ServiceLevel30OrganizationSelect.sql
**	Name: ServiceLevel30OrganizationSelect
**	Desc: Selects multiple rows of ServiceLevel30Organization Based on Id  fields 
**	Auth: ccarroll	
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll				Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ServiceLevel30Organization.ServiceLevelOrganizationID,
		IsNull(ServiceLevel30Organization.ServiceLevelID, 0) AS ServiceLevelID,
		IsNull(ServiceLevel30Organization.OrganizationID,0) AS OrganizationID,
		ServiceLevel30Organization.LastModified,
		IsNull(ServiceLevel30Organization.UpdatedFlag, 0) AS UpdatedFlag
	FROM 
		dbo.ServiceLevel30Organization 
	WHERE 
		ServiceLevel30Organization.ServiceLevelOrganizationID = ISNULL(@ServiceLevelOrganizationID, ServiceLevel30Organization.ServiceLevelOrganizationID) AND
		ServiceLevel30Organization.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevel30Organization.ServiceLevelID) AND
		ServiceLevel30Organization.OrganizationID = ISNULL(@OrganizationID, ServiceLevel30Organization.OrganizationID)
	ORDER BY 1
GO

GRANT EXEC ON ServiceLevel30OrganizationSelect TO PUBLIC
GO
