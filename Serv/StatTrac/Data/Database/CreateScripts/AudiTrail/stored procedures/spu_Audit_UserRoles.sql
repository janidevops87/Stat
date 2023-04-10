IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_Audit_UserRoles')
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_UserRoles'
		DROP  Procedure  spu_Audit_UserRoles
	END

GO

PRINT 'Creating Procedure spu_Audit_UserRoles'
GO
CREATE Procedure spu_Audit_UserRoles
	@1 int, -- WebPersonID
	@2 int, -- RoleID
	@3 int, -- LastStatEmployeeID
	@4 int, -- AuditLogTypeID
	@5 datetime, -- LastModified
	@pkc1 int, 
	@pkc2 int,
	@bitmap binary(2)

AS

/******************************************************************************
**		File: 
**		Name: spu_Audit_UserRoles
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
	DECLARE 
		@lastModified datetime,
		@lastStatEmployeeID int,
		@auditLogTypeID int

IF (
	SUBSTRING(@bitmap, 1, 1) & 1 = 1 -- WebPersonID
	OR SUBSTRING(@bitmap, 1, 1) & 2 = 2 -- RoleID
	OR SUBSTRING(@bitmap, 1, 1) & 4 = 4 -- LastStatEmployeeID
	OR SUBSTRING(@bitmap, 1, 1) & 8 = 8 -- AuditLogTypeID
	--IGNORE AND SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- LastModified
	)
BEGIN
	-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(LastModified, GetDate()),
		@lastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@4, AuditLogTypeID)
	FROM
		UserRoles
	WHERE 
		WebPersonID = @pkc1
	AND
		RoleID = @pkc2
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
	IF
		(
			(
			SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- WebPersonID
			AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- RoleID
			AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- LastStatEmployeeID
			AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- AuditLogTypeID
			)
			AND	SUBSTRING(@bitmap, 1, 1) & 16 = 16 -- LastModified
		)
	BEGIN
		SET @auditLogTypeID = 2	-- Review
	END
	ELSE
	BEGIN
		SET @auditLogTypeID = 3	-- Modify
	END

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
		@pkc1, -- WebPersonID
		@pkc2,-- RoleID
		ISNULL(@3, @lastStatEmployeeID), -- LastStatEmployeeID
		@auditLogTypeID, -- AuditLogTypeID
		ISNULL(@5, @lastModified) -- LastModified		
		) 
		
END


GO

GRANT EXEC ON spu_Audit_UserRoles TO PUBLIC

GO
