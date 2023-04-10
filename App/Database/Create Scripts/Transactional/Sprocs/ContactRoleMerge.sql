IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ContactRoleMerge')
	BEGIN
		PRINT 'Dropping Procedure ContactRoleMerge'
		DROP Procedure ContactRoleMerge
	END
GO

PRINT 'Creating Procedure ContactRoleMerge'
GO
CREATE Procedure ContactRoleMerge
(
		@WebPersonId int = null,
		@PersonId int = null,
		@RoleId int = null,
		@RoleName varchar(512) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@Hidden BIT = null										
)
AS
/******************************************************************************
**	File: ContactRoleMerge.sql
**	Name: ContactRoleMerge
**	Desc: Updates OrganizationDisplaySetting Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	7/22/2010		Bret Knoll			Initial Sproc Creation
**	05/25/2011		Bret Knoll			Add Website Permissions.
**	03/26/2018		Mike Berenson		Updated logic for deleting permissions on roles that were just removed
*******************************************************************************/
---- 11/03/2014 Bret this is temporary logging script to determine why or how people loose permissions
insert ContactRoleMergeLog
values (@WebPersonId, @PersonId, @RoleId, @RoleName, @LastModified, @LastStatEmployeeId, @AuditLogTypeId, @Hidden );

MERGE dbo.UserRoles AS target
USING	(SELECT 
		@WebPersonId, 
		@PersonId, 
		@RoleId,
		@Hidden) AS source 
		(WebPersonId, 
		PersonId, 
		RoleId,
		Hidden)
ON		
	(
		target.WebPersonId = source.WebPersonId
		AND
		target.RoleId = source.RoleId
	)
WHEN MATCHED AND source.Hidden = 1  THEN 
	UPDATE		
	SET 
			WebPersonId = @WebPersonId,
			RoleID = @RoleId,
			LastModified = GetDate(),
			LastStatEmployeeId = @LastStatEmployeeId,
			AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify;
WHEN MATCHED AND source.Hidden = 0  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 1 THEN
	INSERT	
	(
		WebPersonId,
		RoleId,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
	VALUES
	(
		@WebPersonId,
		@RoleId,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	);

IF EXISTS(SELECT UserRoles.RoleID FROM UserRoles WHERE WebPersonID = @WebPersonId AND RoleID = @RoleId)
BEGIN
	-- UPDATE the legacy report sites access permissions
	INSERT WebPersonPermission (WebPersonID, PermissionID)
	SELECT 
		@WebPersonId, 
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
				RoleID = @RoleId

		)
	AND
		PermissionID NOT IN
		(	-- What permissions does the person have
			SELECT
				wpp.permissionID 
			FROM 
				dbo.WebPersonPermission wpp 
			WHERE 
				webpersonid = @WebPersonId

		)

	-- update the persons navigation permissions
	INSERT WebPersonPermission (WebPersonID, PermissionID)
	SELECT 
		@WebPersonId, 
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
			WHERE	RoleID = @RoleId
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
				webpersonid = @WebPersonId

		)
END
ELSE
BEGIN	

	--Find & delete permissions that need to be removed for this webperson and this role
	DELETE wpp
	FROM WebPersonPermission wpp
		JOIN Permission p ON wpp.PERMISSIONID = p.PERMISSIONID
		JOIN ReportRule rr ON p.FUNCTIONID = rr.ReportID
		JOIN UserRoles ur ON rr.RoleID = ur.RoleID
	WHERE ur.WebPersonID = @WebPersonId
		AND ur.RoleID = @RoleId;

END
GO

GRANT EXEC ON ContactRoleMerge TO PUBLIC
GO
