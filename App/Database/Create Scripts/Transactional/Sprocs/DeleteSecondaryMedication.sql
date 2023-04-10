IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondaryMedication')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondaryMedication'
		DROP  Procedure  DeleteSecondaryMedication
	END

GO

PRINT 'Creating Procedure DeleteSecondaryMedication'
GO
CREATE Procedure DeleteSecondaryMedication
	@CallId int, 
	@MedicationId int, 
	@LastStatEmployeeID int	
AS

/******************************************************************************
**		File: DeleteSecondaryMedication.sql
**		Name: DeleteSecondaryMedication
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
	SecondaryMedication 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- 4 = Delete
	LastModified = GetDate()

WHERE 
	CallId = @CallId
AND
	MedicationId = @MedicationId	
	
DELETE 
	SecondaryMedication 
WHERE 
	CallId = @CallId	
AND
	MedicationId = @MedicationId	



GO

GRANT EXEC ON DeleteSecondaryMedication TO PUBLIC

GO
