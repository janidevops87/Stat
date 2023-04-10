IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondary2')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondary2'
		DROP  Procedure  DeleteSecondary2
	END

GO

PRINT 'Creating Procedure DeleteSecondary2'
GO
CREATE Procedure DeleteSecondary2
	@CallID int,  
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeleteSecondary2.sql
**		Name: DeleteSecondary2
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
	Secondary2 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- 4 = Delete 
	LastModified = GetDate() 
WHERE 
	CallID = @CallID

DELETE
	Secondary2 
WHERE 
	CallID = @CallID

	



GO

GRANT EXEC ON DeleteSecondary2 TO PUBLIC

GO
