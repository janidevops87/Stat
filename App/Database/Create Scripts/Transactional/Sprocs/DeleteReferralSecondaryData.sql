IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteReferralSecondaryData')
	BEGIN
		PRINT 'Dropping Procedure DeleteReferralSecondaryData'
		DROP  Procedure  DeleteReferralSecondaryData
	END

GO

PRINT 'Creating Procedure DeleteReferralSecondaryData'
GO
CREATE Procedure DeleteReferralSecondaryData
	@ReferralID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeleteReferralSecondaryData.sql
**		Name: DeleteReferralSecondaryData
**		Desc: 
**
**
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
	ReferralSecondaryData 
SET 
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 --- @AuditLogTypeID,  4 = Delete
WHERE 
	ReferralID = @ReferralID

DELETE 
	ReferralSecondaryData 
WHERE 
	ReferralID = @ReferralID


GO

GRANT EXEC ON DeleteReferralSecondaryData TO PUBLIC

GO
