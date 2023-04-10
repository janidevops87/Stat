
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TcssListLabDelete')
			BEGIN
				PRINT 'Dropping Procedure TcssListLabDelete'
				DROP Procedure TcssListLabDelete
			END
		GO

		PRINT 'Creating Procedure TcssListLabDelete'
		GO

		CREATE PROCEDURE dbo.TcssListLabDelete
		(	
			@TcssListLabId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: TcssListLabDelete.sql 
		**	Name: TcssListLabDelete
		**	Desc: Updates and Deletes a row of TcssListLab, updating AuditTrail
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

		DELETE from
			TcssListLab
		WHERE
			TcssListLabId = @TcssListLabId

		GO

		GRANT EXEC ON TcssListLabDelete TO PUBLIC
		GO
		