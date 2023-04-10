IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateUserRoles')
	BEGIN
		PRINT 'Dropping Procedure UpdateUserRoles'
		DROP  Procedure  UpdateUserRoles
	END

GO

PRINT 'Creating Procedure UpdateUserRoles'
GO
CREATE Procedure UpdateUserRoles
	@WebPersonID int, 
	@RoleID int, 
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateUserRoles.sql
**		Name: UpdateUserRoles
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
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
*******************************************************************************/

UPDATE 
	UserRoles 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), -- 3 Review 
	LastModified = GETDATE() 
WHERE 
	WebPersonID = @WebPersonID
AND	
	RoleID = @RoleID



GO

GRANT EXEC ON UpdateUserRoles TO PUBLIC

GO
