
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationDelete')
			BEGIN
				PRINT 'Dropping Procedure IndicationDelete'
				DROP Procedure IndicationDelete
			END
		GO

		PRINT 'Creating Procedure IndicationDelete'
		GO

		CREATE PROCEDURE dbo.IndicationDelete
		(	
			@IndicationID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: IndicationDelete.sql 
		**	Name: IndicationDelete
		**	Desc: Updates and Deletes a row of Indication, updating AuditTrail
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

		UPDATE Indication
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			IndicationID = @IndicationID
			
		DELETE 
			Indication
		WHERE
			IndicationID = @IndicationID

		GO

		GRANT EXEC ON IndicationDelete TO PUBLIC
		GO
		