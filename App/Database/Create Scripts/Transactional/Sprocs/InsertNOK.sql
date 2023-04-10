IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertNOK')
	BEGIN
		PRINT 'Dropping Procedure InsertNOK'
		DROP  Procedure  InsertNOK
	END

GO

PRINT 'Creating Procedure InsertNOK'
GO
CREATE Procedure InsertNOK
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
**		Name: InsertNOK
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
** 		@NOKID int, 
** 		@NOKFirstName varchar(50), 
** 		@NOKLastName varchar(50), 
** 		@NOKPhone varchar(14), 
** 		@NOKAddress varchar(255), 
** 		@NOKCity varchar(50), 
** 		@NOKStateID int, 
** 		@NOKZip varchar(10), 
** 		@NOKApproachRelation varchar(50), 
** 		@LastStatEmployeeID int, 
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
	NOK
	(
	NOKFirstName, 
	NOKLastName, 
	NOKPhone, 
	NOKAddress, 
	NOKCity, 
	NOKStateID, 
	NOKZip, 
	NOKApproachRelation, 
	LastModified, 
	LastStatEmployeeID, 
	AuditLogTypeID
	)
VALUES
	(	
	@NOKFirstName, 
	@NOKLastName, 
	@NOKPhone, 
	@NOKAddress, 
	@NOKCity, 
	@NOKStateID, 
	@NOKZip, 
	@NOKApproachRelation, 
	GetDate(), -- LastModified
	@LastStatEmployeeID, 
	1 -- @AuditLogTypeID 1 = Create	
	)	

SELECT
	NOKID, 
	NOKFirstName, 
	NOKLastName, 
	NOKPhone, 
	NOKAddress, 
	NOKCity, 
	NOKStateID, 
	NOKZip, 
	NOKApproachRelation
FROM
	NOK
WHERE
	NOKID = SCOPE_IDENTITY() 
	 

GO

GRANT EXEC ON InsertNOK TO PUBLIC

GO
