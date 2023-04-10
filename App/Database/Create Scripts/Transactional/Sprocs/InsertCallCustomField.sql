IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertCallCustomField')
	BEGIN
		PRINT 'Dropping Procedure InsertCallCustomField'
		DROP  Procedure  InsertCallCustomField
	END

GO

PRINT 'Creating Procedure InsertCallCustomField'
GO
CREATE Procedure InsertCallCustomField
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
**		File: InsertCallCustomField.sql
**		Name: InsertCallCustomField
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
INSERT
	CallCustomField
	(
	CallID,
	CallCustomField1, 
	CallCustomField2, 
	CallCustomField3, 
	CallCustomField4, 
	CallCustomField5, 
	CallCustomField6, 
	CallCustomField7, 
	CallCustomField8, 
	CallCustomField9, 
	CallCustomField10, 
	CallCustomField11, 
	CallCustomField12, 
	CallCustomField13, 
	CallCustomField14, 
	CallCustomField15, 
	CallCustomField16, 
	LastModified, 
	LastStatEmployeeID, 
	AuditLogTypeID 

	)
VALUES
	(
	@CallID, 
	@CallCustomField1, 
	@CallCustomField2, 
	@CallCustomField3, 
	@CallCustomField4, 
	@CallCustomField5, 
	@CallCustomField6, 
	@CallCustomField7, 
	@CallCustomField8, 
	@CallCustomField9, 
	@CallCustomField10, 
	@CallCustomField11, 
	@CallCustomField12, 
	@CallCustomField13, 
	@CallCustomField14, 
	@CallCustomField15, 
	@CallCustomField16, 
	GetDate(), 
	@LastStatEmployeeID, 
	1 -- @auditLogTypeID 1 = Create 
	
	)

SELECT 
	CallID,
	CallCustomField1,
	CallCustomField2,
	CallCustomField3,
	CallCustomField4,
	CallCustomField5,
	CallCustomField6,
	CallCustomField7,
	CallCustomField8,
	CallCustomField9,
	CallCustomField10,
	CallCustomField11,
	CallCustomField12,
	CallCustomField13,
	CallCustomField14,
	CallCustomField15,
	CallCustomField16
FROM 
	CallCustomField 
WHERE 
	CallID = @CallID  

GO

GRANT EXEC ON InsertCallCustomField TO PUBLIC

GO
