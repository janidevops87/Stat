IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertSecondaryMedicationOther')
	BEGIN
		PRINT 'Dropping Procedure InsertSecondaryMedicationOther'
		DROP  Procedure  InsertSecondaryMedicationOther
	END

GO

PRINT 'Creating Procedure InsertSecondaryMedicationOther'
GO
CREATE Procedure InsertSecondaryMedicationOther
	@CallId								INT, 
	@MedicationId						INT, 
	@SecondaryMedicationOtherTypeUse	VARCHAR(100) = NULL, 
	@SecondaryMedicationOtherName		VARCHAR(100) = NULL, 
	@SecondaryMedicationOtherDose		VARCHAR(100) = NULL, 
	@SecondaryMedicationOtherStartDate	SMALLDATETIME = NULL, 
	@SecondaryMedicationOtherEndDate	SMALLDATETIME = NULL, 
	@LastStatEmployeeID					INT,
	@AuditLogTypeID						INT = NULL
AS

/******************************************************************************
**		File: InsertSecondaryMedicationOther.sql
**		Name: InsertSecondaryMedicationOther
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
BEGIN

	INSERT 
		SecondaryMedicationOther 
		( 
			CallId,
			MedicationId,
			SecondaryMedicationOtherTypeUse,
			SecondaryMedicationOtherName,
			SecondaryMedicationOtherDose,
			SecondaryMedicationOtherStartDate,
			SecondaryMedicationOtherEndDate,
			LastStatEmployeeID,
			AuditLogTypeID,
			LastModified	
		) 
	VALUES 
		( 
			@CallId, 
			@MedicationId, 
			@SecondaryMedicationOtherTypeUse, 
			@SecondaryMedicationOtherName, 
			@SecondaryMedicationOtherDose, 
			@SecondaryMedicationOtherStartDate, 
			@SecondaryMedicationOtherEndDate, 
			@LastStatEmployeeID, 
			1, -- 1 = Create
			GETDATE()
		); 

END
GO

GRANT EXEC ON InsertSecondaryMedicationOther TO PUBLIC;
GO
