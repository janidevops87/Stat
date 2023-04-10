IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteUserRoles')
	BEGIN
		PRINT 'Dropping Procedure DeleteUserRoles'
		DROP  Procedure  DeleteUserRoles
	END

GO

PRINT 'Creating Procedure DeleteUserRoles'
GO
CREATE Procedure DeleteUserRoles
	@WebPersonID int = NULL , 
	@RoleID int = NULL , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: DeleteUserRoles.sql
**		Name: DeleteUserRoles
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
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 4 ), -- 4 Delete
	LastModified = GETDATE()
WHERE 
	WebPersonID = ISNULL(@WebPersonID, WebPersonID)
AND	
	RoleID = @RoleID	

DELETE 
	UserRoles 

WHERE 
	WebPersonID = ISNULL(@WebPersonID, WebPersonID)
AND	
	RoleID = @RoleID

DELETE 
	WebPersonPermission
WHERE 
	WebPersonID = ISNULL(@WebPersonID, WebPersonID)
AND
	PermissionID IN
	(
		SELECT
			PermissionID 
		FROM 
			permission 
		WHERE 
			FunctionID in
			(	-- What reports exist in the Role
				SELECT 
					ReportID 
				FROM
					ReportRule 
				WHERE
					RoleID = @RoleID	

				AND ReportID NOT IN (

										SELECT ReportID 
										FROM ReportRule
										WHERE RoleID IN (

												SELECT RoleID 
												FROM UserRoles 		
												WHERE WebPersonID = ISNULL(@WebPersonID, WebPersonID)
												AND ROLEID <> @RoleID
											)

					)			)
		AND
			PermissionID IN 
			(	-- What permissions does the person have
				SELECT
					wpp.permissionID 
				FROM 
					dbo.WebPersonPermission wpp 
				WHERE 
					webpersonid = ISNULL(@WebPersonID, WebPersonID)
			)
	)



GRANT EXEC ON DeleteUserRoles TO PUBLIC

GO
