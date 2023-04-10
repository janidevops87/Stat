IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateOrganizationNote')
	BEGIN
		PRINT 'Dropping Procedure UpdateOrganizationNote'
		DROP  Procedure  UpdateOrganizationNote
	END

GO

PRINT 'Creating Procedure UpdateOrganizationNote'
GO
CREATE Procedure UpdateOrganizationNote
    @OrganizationID int = NULL , 
    @OrganizationReferralNotes ntext = NULL , 
    @OrganizationMessageNotes ntext = NULL , 
    @LastStatEmployeeID int = NULL , 
    @AuditLogTypeID int = NULL  
AS

/******************************************************************************
**		File: 
**		Name: UpdateOrganizationNote
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
**
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See list
**
**		Auth: Bret Knoll
**		Date: 10/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      10/08/2007	Bret Knoll			8.4.3.8 AuditTrail
**		10/23/2008	ccarroll			8.4.7 AuditTrail - Added GetDate() for LastModified 
*******************************************************************************/

UPDATE
	Organization
SET
	OrganizationReferralNotes = @OrganizationReferralNotes, 
	OrganizationMessageNotes = @OrganizationMessageNotes,
	LastModified = GetDate(), 
	LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID), 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify
WHERE
	OrganizationID = @OrganizationID 
	


GO

GRANT EXEC ON UpdateOrganizationNote TO PUBLIC

GO
