
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomFieldDelete')
			BEGIN
				PRINT 'Dropping Procedure ServiceLevelCustomFieldDelete'
				DROP Procedure ServiceLevelCustomFieldDelete
			END
		GO

		PRINT 'Creating Procedure ServiceLevelCustomFieldDelete'
		GO

		CREATE PROCEDURE dbo.ServiceLevelCustomFieldDelete
		(	
			@ServiceLevelID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ServiceLevelCustomFieldDelete.sql 
		**	Name: ServiceLevelCustomFieldDelete
		**	Desc: Updates and Deletes a row of ServiceLevelCustomField, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 12/28/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/28/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE ServiceLevelCustomField
		SET		
			LastModified = GetDate()

		WHERE
			ServiceLevelID = @ServiceLevelID
			
		DELETE 
			ServiceLevelCustomField
		WHERE
			ServiceLevelID = @ServiceLevelID

		GO

		GRANT EXEC ON ServiceLevelCustomFieldDelete TO PUBLIC
		GO
		