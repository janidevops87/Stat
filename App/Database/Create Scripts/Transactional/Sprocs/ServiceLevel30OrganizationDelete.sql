  
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationDelete')
			BEGIN
				PRINT 'Dropping Procedure ServiceLevel30OrganizationDelete'
				DROP Procedure ServiceLevel30OrganizationDelete
			END
		GO

		PRINT 'Creating Procedure ServiceLevel30OrganizationDelete'
		GO

		CREATE PROCEDURE dbo.ServiceLevel30OrganizationDelete
		(	
			@ServiceLevelOrganizationID int = null,
			@OrganizationID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ServiceLevel30OrganizationDelete.sql 
		**	Name: ServiceLevel30OrganizationDelete
		**	Desc: Updates and Deletes a row of ServiceLevel30Organization, updating AuditTrail
		**	Auth: ccarroll	
		**	Date: 05/16/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	05/16/2011		ccarroll			Initial Sproc Creation
		**  08/11/2011		ccarroll			Updated to handle cascade delete from Organization
		*******************************************************************************/

SET NOCOUNT ON

IF (COALESCE(@ServiceLevelOrganizationID, @OrganizationID, 0) > 0)

BEGIN
		UPDATE ServiceLevel30Organization
		SET		
			LastModified = GetDate()

		WHERE
			ServiceLevelOrganizationID = COALESCE(@ServiceLevelOrganizationID, ServiceLevelOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
			
		DELETE 
			ServiceLevel30Organization
		WHERE
			ServiceLevelOrganizationID = COALESCE(@ServiceLevelOrganizationID, ServiceLevelOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)

END

GO
GRANT EXEC ON ServiceLevel30OrganizationDelete TO PUBLIC
GO
		