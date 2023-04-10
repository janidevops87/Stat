 
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'LogEventLockDelete')
			BEGIN
				PRINT 'Dropping Procedure LogEventLockDelete'
				DROP Procedure LogEventLockDelete
			END
		GO

		PRINT 'Creating Procedure LogEventLockDelete'
		GO

		CREATE PROCEDURE dbo.LogEventLockDelete
		(	
			@LogEventOrg varchar(80) = null,
			@LogEventID	int = null,
			@LastModified datetime = null,
			@StatEmployeeID	int = null
			
		)
		AS
		/******************************************************************************
		**	File: LogEventLockDelete.sql 
		**	Name: LogEventLockDelete
		**	Desc: Updates and Deletes a row of LogEventLock, updating AuditTrail
		**	Auth: jim h
		**	Date: 9/29/2010
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/29/2010		jim h				Initial Sproc Creation
		*******************************************************************************/
		
		IF(@LogEventID=0 )
		Begin
			DELETE 
				LogEventLock
			WHERE
				LogEventLock.LogEventOrg = @LogEventOrg
				and
				LogEventLock.StatEmployeeID = ISNULL(@StatEmployeeID, LogEventLock.StatEmployeeID)	
				
		End
		IF(@LogEventID<>0 )
		Begin
			DELETE 
				LogEventLock
			WHERE
				LogEventLock.LogEventOrg = @LogEventOrg
				and
				LogEventLock.LogEventID = ISNULL(@LogEventID, LogEventLock.LogEventID)
				and
				LogEventLock.StatEmployeeID = ISNULL(@StatEmployeeID, LogEventLock.StatEmployeeID)	
		End
		GO

		GRANT EXEC ON LogEventLockDelete TO PUBLIC
		GO
		