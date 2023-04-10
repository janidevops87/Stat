IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondaryDisposition')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondaryDisposition'
		DROP  Procedure  DeleteSecondaryDisposition
	END

GO

PRINT 'Creating Procedure DeleteSecondaryDisposition'
GO
CREATE Procedure DeleteSecondaryDisposition
	@SecondaryDispositionID int, 
	@LastStatEmployeeID int
AS

/******************************************************************************
**		File: DeleteSecondaryDisposition.sql
**		Name: DeleteSecondaryDisposition
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
	SecondaryDisposition 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- 4 = Delete
	LastModified = GetDate() 

WHERE 
	SecondaryDispositionID = @SecondaryDispositionID

DELETE 
	SecondaryDisposition 
WHERE 
	SecondaryDispositionID = @SecondaryDispositionID

GO

GRANT EXEC ON DeleteSecondaryDisposition TO PUBLIC

GO
