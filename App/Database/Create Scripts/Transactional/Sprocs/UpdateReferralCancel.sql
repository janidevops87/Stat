IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferralCancel')
	BEGIN
		PRINT 'Dropping Procedure UpdateReferralCancel'
		DROP  Procedure  UpdateReferralCancel
	END

GO

PRINT 'Creating Procedure UpdateReferralCancel'
GO
CREATE Procedure UpdateReferralCancel
    @ReferralID int = NULL , 
    @CallID int = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateReferralCancel.sql 
**		Name: UpdateReferralCancel
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
	Referral
SET
	LastModified = getDate(), 	
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE	
	CallID = @CallID


	

	


GO

GRANT EXEC ON UpdateReferralCancel TO PUBLIC

GO
