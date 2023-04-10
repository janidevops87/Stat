IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteFSCase')
	BEGIN
		PRINT 'Dropping Procedure DeleteFSCase'
		DROP  Procedure  DeleteFSCase
	END

GO

PRINT 'Creating Procedure DeleteFSCase'
GO
CREATE Procedure DeleteFSCase
	@FSCaseId int, 
	@CallId int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: 
**		Name: DeleteFSCase
**		Desc: 
**

**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@FSCaseId int, 
**		@CallId int, 
**		@LastStatEmployeeID int
**
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/

UPDATE
	FSCase
SET	
	CallID = @CallID,
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- @AuditLogTypeID 4 = Delete
	LastModified = GetDate() 
WHERE
	FSCaseId = @FSCaseId 
	
DELETE
	FSCase	
WHERE
	FSCaseId = @FSCaseId 


GO

GRANT EXEC ON DeleteFSCase TO PUBLIC

GO
