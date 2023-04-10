
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeASPDelete')
			BEGIN
				PRINT 'Dropping Procedure SourceCodeASPDelete'
				DROP Procedure SourceCodeASPDelete
			END
		GO

		PRINT 'Creating Procedure SourceCodeASPDelete'
		GO

		CREATE PROCEDURE dbo.SourceCodeASPDelete
		(	
			@SourceCodeASPId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: SourceCodeASPDelete.sql 
		**	Name: SourceCodeASPDelete
		**	Desc: Updates and Deletes a row of SourceCodeASP, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 7/26/2010
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/26/2010		ccarroll			Initial Sproc Creation
		*******************************************************************************/

		UPDATE SourceCodeASP
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			SourceCodeASPId = @SourceCodeASPId
			
		DELETE 
			SourceCodeASP
		WHERE
			SourceCodeASPId = @SourceCodeASPId

		GO

		GRANT EXEC ON SourceCodeASPDelete TO PUBLIC
		GO
		