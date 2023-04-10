IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeletePerson')
	BEGIN
		PRINT 'Dropping Procedure DeletePerson'
		DROP  Procedure  DeletePerson
	END

GO

PRINT 'Creating Procedure DeletePerson'
GO
CREATE Procedure DeletePerson
	@PersonID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeletePerson.sql
**		Name: DeletePerson
**		Desc: 
**
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@PersonID int, 
**		@LastStatEmployeeID int
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/
UPDATE
	Person
SET
	LastModified = GetDate(),
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
WHERE
	PersonID = @PersonID

DELETE
	Person
WHERE
	PersonID = @PersonID

GO

GRANT EXEC ON DeletePerson TO PUBLIC

GO
