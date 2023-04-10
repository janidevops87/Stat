IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondaryMedicationOther')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondaryMedicationOther'
		DROP  Procedure  DeleteSecondaryMedicationOther
	END

GO

PRINT 'Creating Procedure DeleteSecondaryMedicationOther'
GO
CREATE Procedure DeleteSecondaryMedicationOther
	@SecondaryMedicationOtherId int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeleteSecondaryMedicationOther.sql
**		Name: DeleteSecondaryMedicationOther
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
**      06/01/2007	Bret Knoll			8.4.3.8 AuditTrail
**		10/24/2008	ccarroll			8.4.7 Record information to show what is being deleted.
*******************************************************************************/
UPDATE 
	SecondaryMedicationOther 
SET 
	SecondaryMedicationOtherName		= SecondaryMedicationOtherName + CHAR(10), /* record in AuditTrail */
	SecondaryMedicationOtherTypeUse		= SecondaryMedicationOtherTypeUse + CHAR(10), /* record in AuditTrail */
	SecondaryMedicationOtherDose		= SecondaryMedicationOtherDose + CHAR(10), /* record in AuditTrail */
	SecondaryMedicationOtherStartDate	= SecondaryMedicationOtherStartDate, /* record in AuditTrail */
	SecondaryMedicationOtherEndDate		= SecondaryMedicationOtherEndDate, /* record in AuditTrail */
	LastStatEmployeeID					= @LastStatEmployeeID,
	AuditLogTypeID						= 4, -- 4 = Delete
	LastModified						= GetDate()
WHERE 
	SecondaryMedicationOtherId = @SecondaryMedicationOtherId


DELETE 
	SecondaryMedicationOther 
WHERE 
	SecondaryMedicationOtherId = @SecondaryMedicationOtherId
GO

GRANT EXEC ON DeleteSecondaryMedicationOther TO PUBLIC

GO
