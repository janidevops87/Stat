IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteOrganization')
	BEGIN
		PRINT 'Dropping Procedure DeleteOrganization'
		DROP  Procedure  DeleteOrganization
	END

GO

PRINT 'Creating Procedure DeleteOrganization'
GO
CREATE Procedure DeleteOrganization
	@OrganizationID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: 
**		Name: DeleteOrganization
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
**		@OrganizationID int, 
**		@LastStatEmployeeID int
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/

UPDATE
	Organization
SET
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete
WHERE
	OrganizationID = @OrganizationID 

DELETE
	Organization
WHERE
	OrganizationID = @OrganizationID 

GO

GRANT EXEC ON DeleteOrganization TO PUBLIC

GO
