
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'RaceDelete')
			BEGIN
				PRINT 'Dropping Procedure RaceDelete'
				DROP Procedure RaceDelete
			END
		GO

		PRINT 'Creating Procedure RaceDelete'
		GO

		CREATE PROCEDURE dbo.RaceDelete
		(	
			@RaceID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: RaceDelete.sql 
		**	Name: RaceDelete
		**	Desc: Updates and Deletes a row of Race, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/14/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE Race
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			RaceID = @RaceID
			
		DELETE 
			Race
		WHERE
			RaceID = @RaceID

		GO

		GRANT EXEC ON RaceDelete TO PUBLIC
		GO
		