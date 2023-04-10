
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TcssListVitalSignDelete')
			BEGIN
				PRINT 'Dropping Procedure TcssListVitalSignDelete'
				DROP Procedure TcssListVitalSignDelete
			END
		GO

		PRINT 'Creating Procedure TcssListVitalSignDelete'
		GO

		CREATE PROCEDURE dbo.TcssListVitalSignDelete
		(	
			@TcssListVitalSignId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: TcssListVitalSignDelete.sql 
		**	Name: TcssListVitalSignDelete
		**	Desc: Updates and Deletes a row of TcssListVitalSign, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 12/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/23/2009		Bret Knoll			Initial Sproc Creation
		*******************************************************************************/

		
			
		DELETE From
			TcssListVitalSign
		WHERE
			TcssListVitalSignId = @TcssListVitalSignId

		GO

		GRANT EXEC ON TcssListVitalSignDelete TO PUBLIC
		GO
		