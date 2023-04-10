IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertRegistryStatus')
	BEGIN
		PRINT 'Dropping Procedure InsertRegistryStatus'
		DROP  Procedure  InsertRegistryStatus
	END

GO

PRINT 'Creating Procedure InsertRegistryStatus'
GO
CREATE Procedure InsertRegistryStatus
	@ID int = NULL , 
	@RegistryStatus int = NULL , 
	@CallID int , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL  
	
AS

/******************************************************************************
**		File: InsertRegistryStatus.sql
**		Name: InsertRegistryStatus
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

INSERT 
	RegistryStatus 
	( 
		RegistryStatus,
		CallID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID	
	) 

VALUES 
	( 
		@RegistryStatus, 
		@CallID, 
		GetDate(), --@LastModified, 
		@LastStatEmployeeID, 
		1 -- @AuditLogTypeID 1 = CreateDate
	
	) 

SELECT
	ID,
	RegistryStatus,
	CallID
FROM
	RegistryStatus	
WHERE
	ID = SCOPE_IDENTITY()


GO

GRANT EXEC ON InsertRegistryStatus TO PUBLIC

GO
