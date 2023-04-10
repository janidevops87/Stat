IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertUserRoles')
	BEGIN
		PRINT 'Dropping Procedure InsertUserRoles'
		DROP  Procedure  InsertUserRoles
	END

GO

PRINT 'Creating Procedure InsertUserRoles'
GO
CREATE Procedure InsertUserRoles
	@WebPersonID int , 
	@RoleID int , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: InsertUserRoles.sql
**		Name: InsertUserRoles
**		Desc: 
**
**		This template can be customized:
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
INSERT 
	UserRoles 
	(
	WebPersonID,
	RoleID,
	LastStatEmployeeID,
	AuditLogTypeID,
	LastModified
	) 
VALUES 
	(
	@WebPersonID, 
	@RoleID, 
	@LastStatEmployeeID, 
	ISNULL(@AuditLogTypeID, 1 ), -- 1 Create
	GETDATE()
	) 

-- UPDATE the legacy report sites access permissions
INSERT WebPersonPermission (WebPersonID, PermissionID)
SELECT 
	@WebPersonID, 
	PermissionID 
FROM 
	Permission 
WHERE 
	FunctionID IN
	(	-- What reports exist in the Role
		SELECT 
			ReportID 
		FROM
			ReportRule 
		WHERE
			RoleID = @RoleID

	)
AND
	PermissionID NOT IN
	(	-- What permissions does the person have
		SELECT
			wpp.permissionID 
		FROM 
			dbo.WebPersonPermission wpp 
		WHERE 
			webpersonid = @WebPersonID

	)

-- update the persons navigation permissions
INSERT WebPersonPermission (WebPersonID, PermissionID)
SELECT 
	@WebPersonID, 
	PermissionID 
FROM 
	Permission 
where 
	PermissionName IN 
	(
-- select * from Permission
	SELECT	DISTINCT 'Navigation: ' +	CASE 
										WHEN ReportTypeName = 'Custom Reports' THEN 'Custom'
										WHEN ReportTypeName = 'Referral Stats' THEN 'Ref Stats'
										ELSE ReportTypeName 
										END

	FROM	Report r
	JOIN	ReportType rt ON rt.ReportTypeID = r.ReportTypeID
	WHERE	ReportID IN 
		(
		SELECT	ReportID 
		FROM	ReportRule 
		WHERE	RoleID = @RoleID
		)
	)
AND
	PermissionID NOT IN
	(	-- What permissions does the person have
		SELECT
			wpp.permissionID
		FROM 
			dbo.WebPersonPermission wpp 
		WHERE 
			webpersonid = @WebPersonID

	)



SELECT 
	WebPersonID,
	RoleID,
	LastStatEmployeeID,
	AuditLogTypeID
FROM 
	UserRoles 
WHERE 
	WebPersonID = @WebPersonID
AND
	RoleID = @RoleID



GO

GRANT EXEC ON InsertUserRoles TO PUBLIC

GO
