IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Audit_Roles')
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_Roles'
		DROP  Procedure  spi_Audit_Roles
	END

GO

PRINT 'Creating Procedure spi_Audit_Roles'
GO
CREATE Procedure spi_Audit_Roles
	@1 int , -- RoleID
	@2 nvarchar(512) , -- RoleName
	@3 nvarchar(100) , -- RoleDescription
	@4 int , -- LastStatEmployeeID
	@5 int , -- AuditLogTypeID
	@6 datetime , -- LastModified
	@7 smallint  -- Inactive
AS

/******************************************************************************
**		File: spi_Audit_Roles.sql
**		Name: spi_Audit_Roles
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
**		--------	--------			------------------------------------------
**		11/12/2007	Bret Knoll			initial
*******************************************************************************/
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
		@1, -- RoleID
		@2, -- RoleName
		@3, -- RoleDescription
		@4, -- LastStatEmployeeID
		@5, -- AuditLogTypeID
		@6, -- LastModified
		@7 -- Inactive
	)



GO

GRANT EXEC ON spi_Audit_Roles TO PUBLIC

GO
