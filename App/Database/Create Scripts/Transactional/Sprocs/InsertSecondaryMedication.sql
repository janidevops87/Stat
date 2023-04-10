IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertSecondaryMedication')
	BEGIN
		PRINT 'Dropping Procedure InsertSecondaryMedication'
		DROP  Procedure  InsertSecondaryMedication
	END

GO

PRINT 'Creating Procedure InsertSecondaryMedication'
GO
CREATE Procedure InsertSecondaryMedication
	@CallId int, 
	@MedicationId int, 
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null
AS

/******************************************************************************
**		File: InsertSecondaryMedication.sql
**		Name: InsertSecondaryMedication
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
IF (
	SELECT 
		COUNT(*) 
	FROM
		SecondaryMedication 
	WHERE 
		CallID = @CallId	
	AND
		MedicationID = @MedicationId
    ) = 0
BEGIN	
	INSERT 
		SecondaryMedication 
		( 
			CallId,
			MedicationId,
			LastStatEmployeeID,
			AuditLogTypeID,
			LastModified	
		) 
	VALUES 
		( 
			@CallId, 
			@MedicationId, 
			@LastStatEmployeeID, 
			1, --- @AuditLogTypeID  1 = Create 
			GetDate()	
		) 
END

SELECT 
	CallId,
	MedicationId
FROM 
	SecondaryMedication 
WHERE 
	CallId = @CallId
AND
	MedicationID = @MedicationId	



GO

GRANT EXEC ON InsertSecondaryMedication TO PUBLIC

GO
