
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CaseTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure CaseTypeDelete'
				DROP Procedure CaseTypeDelete
			END
		GO

		PRINT 'Creating Procedure CaseTypeDelete'
		GO

		CREATE PROCEDURE dbo.CaseTypeDelete
		(	
			@CaseTypeId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CaseTypeDelete.sql 
		**	Name: CaseTypeDelete
		**	Desc: Updates and Deletes a row of CaseType, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CaseType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			CaseTypeId = @CaseTypeId
			
		DELETE 
			CaseType
		WHERE
			CaseTypeId = @CaseTypeId

		GO

		GRANT EXEC ON CaseTypeDelete TO PUBLIC
		GO
		