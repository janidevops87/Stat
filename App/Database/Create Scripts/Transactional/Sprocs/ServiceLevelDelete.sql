
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelDelete')
			BEGIN
				PRINT 'Dropping Procedure ServiceLevelDelete'
				DROP Procedure ServiceLevelDelete
			END
		GO

		PRINT 'Creating Procedure ServiceLevelDelete'
		GO

		CREATE PROCEDURE dbo.ServiceLevelDelete
		(	
			@ServiceLevelID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ServiceLevelDelete.sql 
		**	Name: ServiceLevelDelete
		**	Desc: Updates and Deletes a row of ServiceLevel, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 12/14/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/14/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE ServiceLevel
		SET		
			LastModified = GetDate()

		WHERE
			ServiceLevelID = @ServiceLevelID
			
		DELETE 
			ServiceLevel
		WHERE
			ServiceLevelID = @ServiceLevelID

		GO

		GRANT EXEC ON ServiceLevelDelete TO PUBLIC
		GO
		