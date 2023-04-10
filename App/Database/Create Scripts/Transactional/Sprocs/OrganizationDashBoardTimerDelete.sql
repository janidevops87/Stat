
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDashBoardTimerDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationDashBoardTimerDelete'
				DROP Procedure OrganizationDashBoardTimerDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationDashBoardTimerDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationDashBoardTimerDelete
		(	
			@OrganizationDashBoardTimerId int = NULL,		
			@OrganizationID int = NULL,						
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationDashBoardTimerDelete.sql 
		**	Name: OrganizationDashBoardTimerDelete
		**	Desc: Updates and Deletes a row of OrganizationDashBoardTimer, updating AuditTrail
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

		IF(COALESCE(@OrganizationDashBoardTimerId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationDashBoardTimer
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationDashBoardTimerId = COALESCE(@OrganizationDashBoardTimerId, OrganizationDashBoardTimerId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationDashBoardTimer
			WHERE
				OrganizationDashBoardTimerId = COALESCE(@OrganizationDashBoardTimerId, OrganizationDashBoardTimerId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationDashBoardTimerDelete TO PUBLIC
		GO
		