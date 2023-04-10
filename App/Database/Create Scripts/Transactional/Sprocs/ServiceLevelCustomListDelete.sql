
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomListDelete')
			BEGIN
				PRINT 'Dropping Procedure ServiceLevelCustomListDelete'
				DROP Procedure ServiceLevelCustomListDelete
			END
		GO

		PRINT 'Creating Procedure ServiceLevelCustomListDelete'
		GO

		CREATE PROCEDURE dbo.ServiceLevelCustomListDelete
		(	
			@ServiceLevelCustomListID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ServiceLevelCustomListDelete.sql 
		**	Name: ServiceLevelCustomListDelete
		**	Desc: Updates and Deletes a row of ServiceLevelCustomList, updating AuditTrail
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

		UPDATE ServiceLevelCustomList
		SET		
			LastModified = GetDate()

		WHERE
			ServiceLevelCustomListID = @ServiceLevelCustomListID
			
		DELETE 
			ServiceLevelCustomList
		WHERE
			ServiceLevelCustomListID = @ServiceLevelCustomListID

		GO

		GRANT EXEC ON ServiceLevelCustomListDelete TO PUBLIC
		GO
		