
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'BulletinBoardDelete')
			BEGIN
				PRINT 'Dropping Procedure BulletinBoardDelete'
				DROP Procedure BulletinBoardDelete
			END
		GO

		PRINT 'Creating Procedure BulletinBoardDelete'
		GO

		CREATE PROCEDURE dbo.BulletinBoardDelete
		(	
			@BulletinBoardID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: BulletinBoardDelete.sql 
		**	Name: BulletinBoardDelete
		**	Desc: Updates and Deletes a row of BulletinBoard, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 9/13/2010
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/13/2010		ccarroll			Initial Sproc Creation
		*******************************************************************************/

		UPDATE BulletinBoard
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			BulletinBoardID = @BulletinBoardID
			
		DELETE 
			BulletinBoard
		WHERE
			BulletinBoardID = @BulletinBoardID

		GO

		GRANT EXEC ON BulletinBoardDelete TO PUBLIC
		GO
		