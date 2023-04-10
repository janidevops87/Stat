IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Audit_Roles')
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_Roles'
		DROP  Procedure  spu_Audit_Roles
	END

GO

PRINT 'Creating Procedure spu_Audit_Roles'
GO
CREATE Procedure spu_Audit_Roles
	@c1 int , -- RoleID
	@c2 nvarchar(512) , -- RoleName
	@c3 nvarchar(100) , -- RoleDescription
	@c4 int , -- LastStatEmployeeID
	@c5 int , -- AuditLogTypeID
	@c6 datetime , -- LastModified
	@c7 smallint , -- Inactive
	@pkc1 int, 
	@bitmap binary(1)
AS

/******************************************************************************
**		File: 
**		Name: spu_Audit_Roles
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
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
*******************************************************************************/
	DECLARE 
		@lastModified datetime,
		@lastStatEmployeeID int,
		@auditLogTypeID int

IF (--- check to see if any of the values have changed	
	SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- RoleID
	OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- RoleName
	OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- RoleDescription	
	OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- LastStatEmployeeID
	OR SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- AuditLogTypeID
	-- IGNORE OR SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
	OR SUBSTRING(@bitmap, 1, 1) & 64 = 64 -- Inactive	
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(LastModified, GetDate()),
		@lastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c4, AuditLogTypeID)
	FROM
		Roles
	WHERE 
		RoleID = @pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
	IF
		(
			(
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- RoleID
			AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- RoleName
			AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- RoleDescription
			-- AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- LastStatEmployeeID
			--AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- AuditLogTypeID			
			AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- Inactive				
			)
			AND SUBSTRING(@bitmap, 1, 1) & 32 = 32 -- LastModified
		)
	BEGIN
		SET @auditLogTypeID = 2	-- Review
	END
	ELSE
	BEGIN
		SET @auditLogTypeID = 3	-- Modify
	END
	
	INSERT 
		Roles 
		(
			RoleID,
			RoleName,
			RoleDescription,
			LastStatEmployeeID,
			AuditLogTypeID,
			LastModified,
			Inactive
		) 
	VALUES 
		(
		@pkc1, -- RoleID
		CASE WHEN /*RoleName*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
		CASE WHEN /*RoleDescription*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
		ISNULL(@c4, @lastStatEmployeeID), -- LastStatEmployeeID
		@auditLogTypeID, -- AuditLogTypeID
		ISNULL(@c6, @lastModified), -- LastModified
		@c7 -- Inactive		
		) 

		
END


GO

GRANT EXEC ON spu_Audit_Roles TO PUBLIC

GO
