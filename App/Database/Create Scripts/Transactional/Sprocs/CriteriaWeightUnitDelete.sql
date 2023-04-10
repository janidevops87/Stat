
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaWeightUnitDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaWeightUnitDelete'
				DROP Procedure CriteriaWeightUnitDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaWeightUnitDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaWeightUnitDelete
		(	
			@CriteriaWeightUnitID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaWeightUnitDelete.sql 
		**	Name: CriteriaWeightUnitDelete
		**	Desc: Updates and Deletes a row of CriteriaWeightUnit, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/16/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/16/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CriteriaWeightUnit
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaWeightUnitID = @CriteriaWeightUnitID
			
		DELETE 
			CriteriaWeightUnit
		WHERE
			CriteriaWeightUnitID = @CriteriaWeightUnitID

		GO

		GRANT EXEC ON CriteriaWeightUnitDelete TO PUBLIC
		GO
		