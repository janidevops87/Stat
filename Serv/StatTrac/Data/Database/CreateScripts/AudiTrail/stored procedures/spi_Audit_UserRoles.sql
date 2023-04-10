IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Audit_UserRoles')
	BEGIN
		PRINT 'Dropping Procedure spi_Audit_UserRoles'
		DROP  Procedure  spi_Audit_UserRoles
	END

GO

PRINT 'Creating Procedure spi_Audit_UserRoles'
GO
CREATE Procedure spi_Audit_UserRoles
	@1 int , -- WebPersonID
	@2 int , -- RoleID
	@3 int , -- LastStatEmployeeID
	@4 int , -- AuditLogTypeID
	@5 datetime  -- LastModified
AS

/******************************************************************************
**		File: spi_Audit_UserRoles.sql
**		Name: spi_Audit_UserRoles
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
	@1, -- WebPersonID
	@2, -- RoleID
	@3, -- LastStatEmployeeID
	@4, -- AuditLogTypeID
	@5 -- LastModified
	 
	) 




GO

GRANT EXEC ON spi_Audit_UserRoles TO PUBLIC

GO
