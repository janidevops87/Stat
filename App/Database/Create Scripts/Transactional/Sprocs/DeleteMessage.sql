  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteMessage')
	BEGIN
		PRINT 'Dropping Procedure DeleteMessage'
		DROP  Procedure  DeleteMessage
	END

GO

PRINT 'Creating Procedure DeleteMessage'
GO
CREATE Procedure DeleteMessage	 
	@CallID int,
	@LastStatEmployeeID int,
	@AuditLogTypeID int 

AS

/******************************************************************************
**		File: 
**		Name:DeleteMessage
**		Desc: DeleteMessage a record into the Message table
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
**		@CallID int,
**		@LastStatEmployeeID int,
**		@AuditLogTypeID int 
**
**		Auth: Thien Ta
**		Date: 04/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		04/13/07		Thien Ta				initial
**	    05/30/07		Bret Knoll				8.4.3.8 audit Message
**												Update LastModified,
**												LastStatEmployeeID,
**												AuditLogTypeID	
*******************************************************************************/

UPDATE
	Message
SET
	LastModified = GetDate(),
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = 4
WHERE
	CallID = @CallID

DELETE
	Message
WHERE
	CallID = @CallID
	
GO