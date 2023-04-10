IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteDonorData')
	BEGIN
		PRINT 'Dropping Procedure DeleteDonorData'
		DROP  Procedure  DeleteDonorData
	END

GO

PRINT 'Creating Procedure DeleteDonorData'
GO
CREATE Procedure DeleteDonorData
	@DonorDataId int,
	@CallID int, 
	@LastStatEmployeeID int

AS

/******************************************************************************
**		File: DeleteDonorData.sql
**		Name: DeleteDonorData
**		Desc: 
**

**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@DonorDataId int, 
**		@LastStatEmployeeID int
**		@CallID int
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************
Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      7/23/2007	Thien Ta			3.5.1, 3.5.1 requirement 
*******************************************************************************/
UPDATE
	DonorData
SET
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4 -- @AuditLogTypeID  4 = Delete
	
WHERE 
	DonorDataId = @DonorDataId

DELETE 
	DonorData
WHERE 
	DonorDataId = @DonorDataId


GO

GRANT EXEC ON DeleteDonorData TO PUBLIC

GO
