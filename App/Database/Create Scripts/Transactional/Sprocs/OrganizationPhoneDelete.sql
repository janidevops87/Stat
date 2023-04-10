
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationPhoneDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationPhoneDelete'
				DROP Procedure OrganizationPhoneDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationPhoneDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationPhoneDelete
		(	
			@OrganizationPhoneID int = NULL,					
			@OrganizationID int = NULL,									
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationPhoneDelete.sql 
		**	Name: OrganizationPhoneDelete
		**	Desc: Updates and Deletes a row of OrganizationPhone, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/

		IF(COALESCE(@OrganizationPhoneID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN
			UPDATE OrganizationPhone
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationPhoneID = COALESCE(@OrganizationPhoneID, OrganizationPhoneID )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
			
				
			DELETE 
				OrganizationPhone
			WHERE
				OrganizationPhoneID = COALESCE(@OrganizationPhoneID, OrganizationPhoneID )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationPhoneDelete TO PUBLIC
		GO
		