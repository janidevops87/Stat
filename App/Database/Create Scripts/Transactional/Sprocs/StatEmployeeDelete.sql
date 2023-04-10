
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'StatEmployeeDelete')
			BEGIN
				PRINT 'Dropping Procedure StatEmployeeDelete'
				DROP Procedure StatEmployeeDelete
			END
		GO

		PRINT 'Creating Procedure StatEmployeeDelete'
		GO

		CREATE PROCEDURE dbo.StatEmployeeDelete
		(	
			@StatEmployeeID int = null,
			@PersonID int = null,
			@OrganizationID int = NULL,															
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: StatEmployeeDelete.sql 
		**	Name: StatEmployeeDelete
		**	Desc: Updates and Deletes a row of StatEmployee, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/29/2010		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@StatEmployeeID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0 OR COALESCE(@PersonID, 0) <> 0)
		BEGIN

			UPDATE StatEmployee
			SET		
				StatEmployee.LastModified = COALESCE(@LastModified, GetDate()),
				StatEmployee.LastStatEmployeeId = COALESCE(@LastStatEmployeeId, StatEmployee.LastStatEmployeeId ),
				StatEmployee.AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			FROM StatEmployee
			JOIN Person ON StatEmployee.PersonID = Person.PersonID
			WHERE
				StatEmployeeID = COALESCE(@StatEmployeeID, StatEmployeeID )
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID )	
			AND
				StatEmployee.PersonID = COALESCE(@PersonID, StatEmployee.PersonID )
				
			DELETE 
				StatEmployee
			FROM StatEmployee
			JOIN Person ON StatEmployee.PersonID = Person.PersonID
			WHERE
				StatEmployeeID = COALESCE(@StatEmployeeID, StatEmployeeID )
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID )	
			AND
				StatEmployee.PersonID = COALESCE(@PersonID, StatEmployee.PersonID )
				
		END
		GO

		GRANT EXEC ON StatEmployeeDelete TO PUBLIC
		GO
		