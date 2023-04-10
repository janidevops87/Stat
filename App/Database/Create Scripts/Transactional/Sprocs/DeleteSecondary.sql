IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondary')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondary'
		DROP  Procedure  DeleteSecondary
	END

GO

PRINT 'Creating Procedure DeleteSecondary'
GO
CREATE Procedure DeleteSecondary
	@CallID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeleteSecondary.sql
**		Name: DeleteSecondary
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
	Secondary 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- 4 = Delete
	LastModified = GetDate()	
WHERE 
	CallID = @CallID 

DELETE 
	Secondary 
WHERE 
	CallID = @CallID

GO

GRANT EXEC ON DeleteSecondary TO PUBLIC

GO
