 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteCall')
	BEGIN
		PRINT 'Dropping Procedure DeleteCall'
		DROP  Procedure  DeleteCall
	END

GO

PRINT 'Creating Procedure DeleteCall'
GO
CREATE Procedure DeleteCall	 
	@CallID int,
	@CallSaveLastByID int,	
	@AuditLogTypeID int				

AS

/******************************************************************************
**		File: 
**		Name: DeleteCall
**		Desc: DeleteCall a record into the call table
**
**              
**		Return values: returns the inserted record
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Thien Ta
**		Date: 04/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		04/13/07		Thien Ta				initial
**		05/30/07		Bret Knoll				8.4.3.8 Audit Call table
**												added update LastModified,	
**												AuditLogTypeID = 4 or Delete,
**												CallSaveLastByID
*******************************************************************************/

UPDATE
	CALL
SET
	LastModified = GetDate(),
	CallSaveLastByID = @CallSaveLastByID,	
	AuditLogTypeID = 4		-- 4 delete
WHERE
	CallID = @CallID

DELETE
	Call 
WHERE
	CallID = @CallID
	
GO
