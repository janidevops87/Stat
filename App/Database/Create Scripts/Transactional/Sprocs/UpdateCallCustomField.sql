IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateCallCustomField')
	BEGIN
		PRINT 'Dropping Procedure UpdateCallCustomField'
		DROP  Procedure  UpdateCallCustomField
	END

GO

PRINT 'Creating Procedure UpdateCallCustomField'
GO
CREATE Procedure UpdateCallCustomField
	@CallID int = NULL , 
	@CallCustomField1 varchar(40) = NULL , 
	@CallCustomField2 varchar(40) = NULL , 
	@CallCustomField3 varchar(40) = NULL , 
	@CallCustomField4 varchar(40) = NULL , 
	@CallCustomField5 varchar(40) = NULL , 
	@CallCustomField6 varchar(40) = NULL , 
	@CallCustomField7 varchar(255) = NULL , 
	@CallCustomField8 varchar(255) = NULL , 
	@CallCustomField9 varchar(40) = NULL , 
	@CallCustomField10 varchar(40) = NULL , 
	@CallCustomField11 varchar(40) = NULL , 
	@CallCustomField12 varchar(40) = NULL , 
	@CallCustomField13 varchar(40) = NULL , 
	@CallCustomField14 varchar(40) = NULL , 
	@CallCustomField15 varchar(40) = NULL , 
	@CallCustomField16 varchar(40) = NULL , 
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = null  
	
AS

/******************************************************************************
**		File: UpdateCallCustomField.sql
**		Name: UpdateCallCustomField
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List.
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
	CallCustomField
SET
	CallCustomField1 = @CallCustomField1, 
	CallCustomField2 = @CallCustomField2, 
	CallCustomField3 = @CallCustomField3, 
	CallCustomField4 = @CallCustomField4, 
	CallCustomField5 = @CallCustomField5, 
	CallCustomField6 = @CallCustomField6, 
	CallCustomField7 = @CallCustomField7, 
	CallCustomField8 = @CallCustomField8, 
	CallCustomField9 = @CallCustomField9, 
	CallCustomField10 = @CallCustomField10, 
	CallCustomField11 = @CallCustomField11, 
	CallCustomField12 = @CallCustomField12, 
	CallCustomField13 = @CallCustomField13, 
	CallCustomField14 = @CallCustomField14, 
	CallCustomField15 = @CallCustomField15, 
	CallCustomField16 = @CallCustomField16, 
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
	
WHERE
	CallID = @CallID 

GO

GRANT EXEC ON UpdateCallCustomField TO PUBLIC

GO
