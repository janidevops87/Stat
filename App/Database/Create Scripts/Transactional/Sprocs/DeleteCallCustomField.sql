IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteCallCustomField')
	BEGIN
		PRINT 'Dropping Procedure DeleteCallCustomField'
		DROP  Procedure  DeleteCallCustomField
	END

GO

PRINT 'Creating Procedure DeleteCallCustomField'
GO
CREATE Procedure DeleteCallCustomField
	@CallID int, 
	@LastStatEmployeeID int 
	
AS

/******************************************************************************
**		File: DeleteCallCustomField.sql
**		Name: DeleteCallCustomField
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
** 		@CallID int, 
** 		@LastStatEmployeeID int
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
	CallCustomField
SET
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete
WHERE
	CallID = @CallID 

DELETE
	CallCustomField
WHERE
	CallID = @CallID
GO

GRANT EXEC ON DeleteCallCustomField TO PUBLIC

GO
