IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateRoles')
	BEGIN
		PRINT 'Dropping Procedure UpdateRoles'
		DROP  Procedure  UpdateRoles
	END

GO

PRINT 'Creating Procedure UpdateRoles'
GO
CREATE Procedure UpdateRoles
	@RoleID int, 
	@RoleName nvarchar(512) = NULL , 
	@RoleDescription nvarchar(250) = null,
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null,
	@Inactive int = null
AS

/******************************************************************************
**		File: UpdateRoles.sql
**		Name: UpdateRoles
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
UPDATE Roles 
SET 
	RoleName = ISNULL(@RoleName, RoleName), 
	RoleDescription = ISNULL(@RoleDescription, RoleDescription), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	Inactive = ISNULL(@Inactive, Inactive),
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --3	Modify
	LastModified = GETDATE() 
WHERE 
	RoleID = @RoleID

IF(@Inactive = 1)
BEGIN
	EXEC DeleteUserRoles
		@WebPersonID = NULL , 
		@RoleID = @RoleID , 
		@LastStatEmployeeID = @LastStatEmployeeID , 
		@AuditLogTypeID = 4
END



GO

GRANT EXEC ON UpdateRoles TO PUBLIC

GO
