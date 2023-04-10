IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertSecondaryDisposition')
	BEGIN
		PRINT 'Dropping Procedure InsertSecondaryDisposition'
		DROP  Procedure  InsertSecondaryDisposition
	END

GO

PRINT 'Creating Procedure InsertSecondaryDisposition'
GO
CREATE Procedure InsertSecondaryDisposition
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
**		File: InsertSecondaryDisposition.sql
**		Name: InsertSecondaryDisposition
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

INSERT 
	SecondaryDisposition 
	(
		CallID,
		SubCriteriaID,
		SecondaryDispositionAppropriate,
		SecondaryDispositionApproach,
		SecondaryDispositionConsent,
		SecondaryDispositionConversion,
		SecondaryDispositionCRO,
		LastStatEmployeeID,
		AuditLogTypeID,
		LastModified	
	) 
VALUES 
	( 
		@CallID, 
		@SubCriteriaID, 
		@SecondaryDispositionAppropriate, 
		@SecondaryDispositionApproach, 
		@SecondaryDispositionConsent, 
		@SecondaryDispositionConversion, 
		@SecondaryDispositionCRO, 
		@LastStatEmployeeID, 
		1, -- @AuditLogTypeID 1 = Created
		GetDate()-- @LastModified, 
	
	) 

SELECT 
	SecondaryDispositionID,
	CallID,
	SubCriteriaID,
	SecondaryDispositionAppropriate,
	SecondaryDispositionApproach,
	SecondaryDispositionConsent,
	SecondaryDispositionConversion,
	SecondaryDispositionCRO
FROM 
	SecondaryDisposition 
WHERE 
	SecondaryDispositionID = SCOPE_IDENTITY()



GO

GRANT EXEC ON InsertSecondaryDisposition TO PUBLIC

GO
