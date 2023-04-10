
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTransplantCenterDelete')
			BEGIN
				PRINT 'Dropping Procedure SourceCodeTransplantCenterDelete'
				DROP Procedure SourceCodeTransplantCenterDelete
			END
		GO

		PRINT 'Creating Procedure SourceCodeTransplantCenterDelete'
		GO

		CREATE PROCEDURE dbo.SourceCodeTransplantCenterDelete
		(	
			@SourceCodeTransplantCenterID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: SourceCodeTransplantCenterDelete.sql 
		**	Name: SourceCodeTransplantCenterDelete
		**	Desc: Updates and Deletes a row of SourceCodeTransplantCenter, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/23/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE SourceCodeTransplantCenter
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			SourceCodeTransplantCenterID = @SourceCodeTransplantCenterID
			
		DELETE 
			SourceCodeTransplantCenter
		WHERE
			SourceCodeTransplantCenterID = @SourceCodeTransplantCenterID

		GO

		GRANT EXEC ON SourceCodeTransplantCenterDelete TO PUBLIC
		GO
		