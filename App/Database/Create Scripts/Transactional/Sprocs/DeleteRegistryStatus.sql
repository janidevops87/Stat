IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteRegistryStatus')
	BEGIN
		PRINT 'Dropping Procedure DeleteRegistryStatus'
		DROP  Procedure  DeleteRegistryStatus
	END

GO

PRINT 'Creating Procedure DeleteRegistryStatus'
GO
CREATE Procedure DeleteRegistryStatus
	@ID int, 
	@LastStatEmployeeID int 
AS

/******************************************************************************
**		File: DeleteRegistryStatus.sql
**		Name: DeleteRegistryStatus
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
**     see list above
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
	RegistryStatus 
SET 
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- 4 = Delete
WHERE 
	ID = @ID

DELETE 
	RegistryStatus 
WHERE 
	ID = @ID


GO

GRANT EXEC ON DeleteRegistryStatus TO PUBLIC

GO
