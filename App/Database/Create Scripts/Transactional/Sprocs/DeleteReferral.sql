IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertReferral')
	BEGIN
		PRINT 'Dropping Procedure InsertReferral'
		DROP  Procedure  InsertReferral
	END

GO

PRINT 'Creating Procedure InsertReferral'
GO
CREATE Procedure InsertReferral
	@ReferralID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: InsertReferral.sql 
**		Name: InsertReferral
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
**     see list above
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
	Referral
SET
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID, 4 = Delete
WHERE	
	ReferralID = @ReferralID 

DELETE
	Referral
WHERE	
	ReferralID = @ReferralID 


GO

GRANT EXEC ON InsertReferral TO PUBLIC

GO
