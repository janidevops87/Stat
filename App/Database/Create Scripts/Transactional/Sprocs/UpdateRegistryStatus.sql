IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateRegistryStatus')
	BEGIN
		PRINT 'Dropping Procedure UpdateRegistryStatus'
		DROP  Procedure  UpdateRegistryStatus
	END

GO

PRINT 'Creating Procedure UpdateRegistryStatus'
GO
CREATE Procedure UpdateRegistryStatus
	@ID int , 
	@RegistryStatus int = NULL , 
	@CallID int = NULL , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateRegistryStatus.sql
**		Name: UpdateRegistryStatus
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
	RegistryStatus = ISNULL(@RegistryStatus, RegistryStatus),  
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE 
	ID = @ID



GO

GRANT EXEC ON UpdateRegistryStatus TO PUBLIC

GO
