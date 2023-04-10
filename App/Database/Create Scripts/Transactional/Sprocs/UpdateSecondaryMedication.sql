IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondaryMedication')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondaryMedication'
		DROP  Procedure  UpdateSecondaryMedication
	END

GO

PRINT 'Creating Procedure UpdateSecondaryMedication'
GO
CREATE Procedure UpdateSecondaryMedication
	@CallId int, 
	@MedicationId int, 
	@LastStatEmployeeID int,
	@AuditLogTypeID int = null
AS

/******************************************************************************
**		File: UpdateSecondaryMedication.sql
**		Name: UpdateSecondaryMedication
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
	MedicationId = ISNULL(@MedicationId, MedicationID),
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify		 
	LastModified = GetDate()

WHERE 
	CallID = @CallId



GO

GRANT EXEC ON UpdateSecondaryMedication TO PUBLIC

GO
