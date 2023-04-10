IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondaryMedicationOther')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondaryMedicationOther'
		DROP  Procedure  UpdateSecondaryMedicationOther
	END

GO

PRINT 'Creating Procedure UpdateSecondaryMedicationOther'
GO
CREATE Procedure UpdateSecondaryMedicationOther
	@SecondaryMedicationOtherId int, 
	@CallId int = NULL , 
	@MedicationId int = NULL , 
	@SecondaryMedicationOtherTypeUse varchar(100) = NULL , 
	@SecondaryMedicationOtherName varchar(100) = NULL , 
	@SecondaryMedicationOtherDose varchar(100) = NULL , 
	@SecondaryMedicationOtherStartDate smalldatetime = NULL , 
	@SecondaryMedicationOtherEndDate smalldatetime = NULL , 
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL 	
AS

/******************************************************************************
**		File: UpdateSecondaryMedicationOther.sql
**		Name: UpdateSecondaryMedicationOther
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
*******************************************************************************/

UPDATE 
	SecondaryMedicationOther 
SET
	MedicationId = ISNULL(@MedicationId, MedicationId), 
	SecondaryMedicationOtherTypeUse = ISNULL(@SecondaryMedicationOtherTypeUse, SecondaryMedicationOtherTypeUse), 
	SecondaryMedicationOtherName = ISNULL(@SecondaryMedicationOtherName, SecondaryMedicationOtherName), 
	SecondaryMedicationOtherDose = ISNULL(@SecondaryMedicationOtherDose, SecondaryMedicationOtherDose), 
	SecondaryMedicationOtherStartDate = ISNULL(@SecondaryMedicationOtherStartDate, SecondaryMedicationOtherStartDate), 
	SecondaryMedicationOtherEndDate = ISNULL(@SecondaryMedicationOtherEndDate, SecondaryMedicationOtherEndDate), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify		
	LastModified = GetDate()
WHERE 
	SecondaryMedicationOtherId = @SecondaryMedicationOtherId




GO

GRANT EXEC ON UpdateSecondaryMedicationOther TO PUBLIC

GO
