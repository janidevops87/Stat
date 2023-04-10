IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateNOK')
	BEGIN
		PRINT 'Dropping Procedure UpdateNOK'
		DROP  Procedure  UpdateNOK
	END

GO

PRINT 'Creating Procedure UpdateNOK'
GO
CREATE Procedure UpdateNOK
    @NOKID int = NULL , 
    @NOKFirstName varchar(50) = NULL , 
    @NOKLastName varchar(50) = NULL , 
    @NOKPhone varchar(14) = NULL , 
    @NOKAddress varchar(255) = NULL , 
    @NOKCity varchar(50) = NULL , 
    @NOKStateID int = NULL , 
    @NOKZip varchar(10) = NULL , 
    @NOKApproachRelation varchar(50) = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: 
**		Name: UpdateNOK
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
**		see list
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
	NOK
SET
	NOKFirstName = @NOKFirstName, 
	NOKLastName = @NOKLastName, 
	NOKPhone = @NOKPhone, 
	NOKAddress = @NOKAddress, 
	NOKCity = @NOKCity, 
	NOKStateID = @NOKStateID, 
	NOKZip = @NOKZip, 
	NOKApproachRelation = @NOKApproachRelation, 
	LastModified = GetDate(), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE
	NOKID = @NOKID 
		


GO

GRANT EXEC ON UpdateNOK TO PUBLIC

GO
