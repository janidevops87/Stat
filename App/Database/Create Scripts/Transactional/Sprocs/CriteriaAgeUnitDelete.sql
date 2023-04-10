
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaAgeUnitDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaAgeUnitDelete'
				DROP Procedure CriteriaAgeUnitDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaAgeUnitDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaAgeUnitDelete
		(	
			@CriteriaAgeUnitID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaAgeUnitDelete.sql 
		**	Name: CriteriaAgeUnitDelete
		**	Desc: Updates and Deletes a row of CriteriaAgeUnit, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/16/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/16/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CriteriaAgeUnit
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaAgeUnitID = @CriteriaAgeUnitID
			
		DELETE 
			CriteriaAgeUnit
		WHERE
			CriteriaAgeUnitID = @CriteriaAgeUnitID

		GO

		GRANT EXEC ON CriteriaAgeUnitDelete TO PUBLIC
		GO
		