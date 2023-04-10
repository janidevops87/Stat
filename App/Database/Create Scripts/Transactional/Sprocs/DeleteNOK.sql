IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteNOK')
	BEGIN
		PRINT 'Dropping Procedure DeleteNOK'
		DROP  Procedure  DeleteNOK
	END

GO

PRINT 'Creating Procedure DeleteNOK'
GO
CREATE Procedure DeleteNOK
	@NOKID int, 
	@LastStatEmployeeID int 
AS

/******************************************************************************
**		File: 
**		Name: DeleteNOK
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
** 		@NOKID int, 
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
	NOK
SET
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete
WHERE
	NOKID = @NOKID
	
	
DELETE
	NOK
WHERE
	NOKID = @NOKID	



GO

GRANT EXEC ON DeleteNOK TO PUBLIC

GO
