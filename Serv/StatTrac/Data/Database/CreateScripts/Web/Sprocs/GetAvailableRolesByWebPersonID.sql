IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetAvailableRolesByWebPersonID')
	BEGIN
		PRINT 'Dropping Procedure GetAvailableRolesByWebPersonID'
		DROP  Procedure  GetAvailableRolesByWebPersonID
	END

GO

PRINT 'Creating Procedure GetAvailableRolesByWebPersonID'
GO
CREATE Procedure GetAvailableRolesByWebPersonID
	@WebPersonID INT, -- WebPersonID of User being changed
	@UserID INT -- WebPersonID of person making changes
AS

/******************************************************************************
**		File: GetAvailableRolesByWebPersonID.sql
**		Name: GetAvailableRolesByWebPersonID
**		Desc: Obtains a list of Roles a user does not have access to.
**
**              
**		Return values:
**					Table Roles
**		Called by:   
**              AdminReferrenceDB.FillAvailableRolesList
**
**		Auth: Bret Knoll
**		Date: 01/13/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-----------------------------------------
**		1/13/08		Bret Knoll			Initial
*******************************************************************************/
-- determine if the user making the change is statline 
DECLARE @StatlineUser bit
SELECT 
	@StatlineUser =	dbo.IsStatline(@UserID)

SELECT     
	RoleID, 
	RoleName,
	ISNULL(Inactive, 0) 'Inactive'
FROM         
	Roles r
WHERE     
	-- WHERE THE user be changed does not have role
	(RoleID NOT IN
                          (
							SELECT     RoleID
                            FROM          UserRoles ur
                            WHERE      ur.WebPersonID = @WebPersonID
                           )
	 )
AND	 
	-- The user making the changes has access
	(RoleID IN
				(
				SELECT	RoleID 
				FROM	Roles 
				WHERE	@StatlineUser = 1
				UNION
				SELECT	RoleID
				FROM	UserRoles ur
				WHERE	ur.WebPersonID = @UserID
				)
	)
ORDER BY 
	r.RoleName
	 


GO

GRANT EXEC ON GetAvailableRolesByWebPersonID TO PUBLIC

GO
