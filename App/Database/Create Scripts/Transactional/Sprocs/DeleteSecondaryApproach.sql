IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteSecondaryApproach')
	BEGIN
		PRINT 'Dropping Procedure DeleteSecondaryApproach'
		DROP  Procedure  DeleteSecondaryApproach
	END

GO

PRINT 'Creating Procedure DeleteSecondaryApproach'
GO
CREATE Procedure DeleteSecondaryApproach
	@CallId int, 
	@LastStatEmployeeID int

AS

/******************************************************************************
**		File: DeleteSecondaryApproach.sql
**		Name: DeleteSecondaryApproach
**		Desc: 
**			Deletes data into the SecondaryApproach table
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
**      7/02/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/

UPDATE 
	SecondaryApproach 
SET 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = 4, -- 4 = Delete
	LastModified = GetDate() 
WHERE 
	SecondaryApproached = @CallId


DELETE 
	SecondaryApproach 

WHERE 
	SecondaryApproached = @CallId
GO

GRANT EXEC ON DeleteSecondaryApproach TO PUBLIC

GO
