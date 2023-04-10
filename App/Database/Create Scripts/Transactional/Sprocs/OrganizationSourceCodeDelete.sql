
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationSourceCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationSourceCodeDelete'
				DROP Procedure OrganizationSourceCodeDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationSourceCodeDelete'
		GO

		CREATE PROCEDURE OrganizationSourceCodeDelete
		(	
			@OrganizationID int = NULL,			
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationSourceCodeDelete.sql 
		**	Name: OrganizationSourceCodeDelete
		**	Desc: Updates and Deletes a row of OrganizationSourceCode, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/19/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/19/2011		Bret Knoll			Initial Sproc Creation
		*******************************************************************************/

		UPDATE OrganizationSourceCode
		SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

		WHERE
			OrganizationSourceCode.OrganizationID = @OrganizationID
			
		DELETE 
			OrganizationSourceCode
		WHERE		
			OrganizationSourceCode.OrganizationID = @OrganizationID

		GO

		GRANT EXEC ON OrganizationSourceCodeDelete TO PUBLIC
		GO
		