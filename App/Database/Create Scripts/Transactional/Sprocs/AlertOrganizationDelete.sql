
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertOrganizationDelete')
			BEGIN
				PRINT 'Dropping Procedure AlertOrganizationDelete'
				DROP Procedure AlertOrganizationDelete
			END
		GO

		PRINT 'Creating Procedure AlertOrganizationDelete'
		GO

		CREATE PROCEDURE dbo.AlertOrganizationDelete
		(	
			@AlertOrganizationID int = null,
			@OrganizationID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: AlertOrganizationDelete.sql 
		**	Name: AlertOrganizationDelete
		**	Desc: Updates and Deletes a row of AlertOrganization, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/26/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/26/2011		Bret Knoll			Initial Sproc Creation
		**  08/11/2011		ccarroll			Updated to handle cascade delete from Organization
		*******************************************************************************/
SET NOCOUNT ON
		
IF (COALESCE(@AlertOrganizationID, @OrganizationID, 0) > 0)
BEGIN
		UPDATE AlertOrganization
		SET		
			LastModified = GetDate()

		WHERE
			AlertOrganizationID = COALESCE(@AlertOrganizationID, AlertOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)

			
		DELETE 
			AlertOrganization
		WHERE
			AlertOrganizationID = COALESCE(@AlertOrganizationID, AlertOrganizationID) AND
			OrganizationID = COALESCE(@OrganizationID, OrganizationID)
END
GO

GRANT EXEC ON AlertOrganizationDelete TO PUBLIC
GO
