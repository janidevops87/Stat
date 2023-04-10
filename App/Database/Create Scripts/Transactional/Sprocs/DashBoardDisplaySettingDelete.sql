
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardDisplaySettingDelete')
			BEGIN
				PRINT 'Dropping Procedure DashBoardDisplaySettingDelete'
				DROP Procedure DashBoardDisplaySettingDelete
			END
		GO

		PRINT 'Creating Procedure DashBoardDisplaySettingDelete'
		GO

		CREATE PROCEDURE dbo.DashBoardDisplaySettingDelete
		(	
			@DashBoardDisplaySettingId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DashBoardDisplaySettingDelete.sql 
		**	Name: DashBoardDisplaySettingDelete
		**	Desc: Updates and Deletes a row of DashBoardDisplaySetting, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE DashBoardDisplaySetting
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			DashBoardDisplaySettingId = @DashBoardDisplaySettingId
			
		DELETE 
			DashBoardDisplaySetting
		WHERE
			DashBoardDisplaySettingId = @DashBoardDisplaySettingId

		GO

		GRANT EXEC ON DashBoardDisplaySettingDelete TO PUBLIC
		GO
		