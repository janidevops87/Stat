IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondaryDisposition')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondaryDisposition'
		DROP  Procedure  UpdateSecondaryDisposition
	END

GO

PRINT 'Creating Procedure UpdateSecondaryDisposition'
GO
CREATE Procedure UpdateSecondaryDisposition
	@SecondaryDispositionID int = null, 
	@CallID int, 
	@SubCriteriaID int, 
	@SecondaryDispositionAppropriate smallint, 
	@SecondaryDispositionApproach smallint, 
	@SecondaryDispositionConsent smallint, 
	@SecondaryDispositionConversion smallint, 
	@SecondaryDispositionCRO smallint, 
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null
AS

/******************************************************************************
**		File: UpdateSecondaryDisposition.sql
**		Name: UpdateSecondaryDisposition
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   spu_SecondaryDisposition
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
	SecondaryDisposition 
SET 
	SecondaryDispositionAppropriate = ISNULL(@SecondaryDispositionAppropriate, SecondaryDispositionAppropriate), 
	SecondaryDispositionApproach = ISNULL(@SecondaryDispositionApproach, SecondaryDispositionApproach), 
	SecondaryDispositionConsent = ISNULL(@SecondaryDispositionConsent, SecondaryDispositionConsent), 
	SecondaryDispositionConversion = ISNULL(@SecondaryDispositionConversion, SecondaryDispositionConversion), 
	SecondaryDispositionCRO = ISNULL(@SecondaryDispositionCRO, SecondaryDispositionCRO), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify		 
	LastModified = GetDate() 

WHERE 
	CallID = @CallID
AND
	SubCriteriaID = @SubCriteriaID
	 




GO

GRANT EXEC ON UpdateSecondaryDisposition TO PUBLIC

GO
