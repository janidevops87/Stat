SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure [dbo].[InsertRoles]'
	drop procedure [dbo].[InsertRoles]
END
	PRINT 'CREATE PROCEDURE dbo.InsertRoles'
GO

CREATE PROCEDURE dbo.InsertRoles
	@Rolename	nvarchar(256) = null,
	@RoleDescription nvarchar(250) = null,
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null,
	@Inactive int = null
AS

/******************************************************************************
**		File: InsertRoles.sql
**		Name: InsertRoles
**		Desc: Insert new role 
**
**              
** 
**		Called by:   Reporting Site
**              
**
**		Auth: Bret Knoll
**		Date: 10/19/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    10/19/2007	Bret Knoll			initial 
**	  11/12/2007	Bret Knoll			Add fields for AuditTrail
*******************************************************************************/
DECLARE 
	@WebPersonID INT,
	@RoleID INT

SELECT TOP 1 @WebPersonID = WebPersonID FROM WebPerson WHERE PersonID = (SELECT PersonID FROM StatEmployee WHERE StatEmployeeID = @LastStatEmployeeID)
	INSERT INTO Roles
		(
		RoleName, 
		RoleDescription,
		LastStatEmployeeID, 
		AuditLogTypeID, 
		LastModified,
		Inactive)
	VALUES
		(
		ISNULL(@RoleName, ''),
		ISNULL(@RoleDescription, ''),
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1), --1	Create
		GetDate(),
		ISNULL(@Inactive, 0)
		)
SELECT @RoleID = SCOPE_IDENTITY()
-- give the user access to the role		
EXEC InsertUserRoles
	@WebPersonID = @WebPersonID,
	@RoleID = @RoleID , 
	@LastStatEmployeeID = @LastStatEmployeeID, 
	@AuditLogTypeID = @AuditLogTypeID
		
	SELECT 
		RoleID,
		RoleName, 
		RoleDescription,
		Inactive	
	FROM
		Roles
	WHERE
		RoleID = @RoleID
RETURN




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

