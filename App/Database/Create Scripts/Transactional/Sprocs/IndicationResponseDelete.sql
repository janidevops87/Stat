
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationResponseDelete')
			BEGIN
				PRINT 'Dropping Procedure IndicationResponseDelete'
				DROP Procedure IndicationResponseDelete
			END
		GO

		PRINT 'Creating Procedure IndicationResponseDelete'
		GO

		CREATE PROCEDURE dbo.IndicationResponseDelete
		(	
			@IndicationResponseID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: IndicationResponseDelete.sql 
		**	Name: IndicationResponseDelete
		**	Desc: Updates and Deletes a row of IndicationResponse, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 11/20/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	11/20/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE IndicationResponse
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			IndicationResponseID = @IndicationResponseID
			
		DELETE 
			IndicationResponse
		WHERE
			IndicationResponseID = @IndicationResponseID

		GO

		GRANT EXEC ON IndicationResponseDelete TO PUBLIC
		GO
		