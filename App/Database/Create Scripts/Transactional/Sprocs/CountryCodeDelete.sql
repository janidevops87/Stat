
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CountryCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure CountryCodeDelete'
				DROP Procedure CountryCodeDelete
			END
		GO

		PRINT 'Creating Procedure CountryCodeDelete'
		GO

		CREATE PROCEDURE dbo.CountryCodeDelete
		(	
			@CountryCodeId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CountryCodeDelete.sql 
		**	Name: CountryCodeDelete
		**	Desc: Updates and Deletes a row of CountryCode, updating AuditTrail
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

		UPDATE CountryCode
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			CountryCodeId = @CountryCodeId
			
		DELETE 
			CountryCode
		WHERE
			CountryCodeId = @CountryCodeId

		GO

		GRANT EXEC ON CountryCodeDelete TO PUBLIC
		GO
		