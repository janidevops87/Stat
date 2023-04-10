IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertDonorData')
	BEGIN
		PRINT 'Dropping Procedure InsertDonorData'
		DROP  Procedure  InsertDonorData
	END

GO

PRINT 'Creating Procedure InsertDonorData'
GO
CREATE Procedure InsertDonorData
    @DonorDataId int = NULL , 
    @CallID int = NULL , 
    @DonorDataMiddleName varchar(20) = NULL , 
    @DonorDataLicense varchar(9) = NULL , 
    @DonorDataAddress varchar(40) = NULL , 
    @DonorDataCity varchar(25) = NULL , 
    @DonorDataState varchar(2) = NULL , 
    @DonorDataZip varchar(10) = NULL , 
    @DonorDataNotAvailable bit = NULL ,   
    @MultipleDonorsFound smallint = NULL,   
    @LastStatEmployeeID int ,    
    @AuditLogTypeID int = NULL  
AS

/******************************************************************************
**		File: InsertDonorData.sql
**		Name: InsertDonorData
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
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      7/23/2007	Thien Ta			3.5.1, 3.5.2 Requirement
*******************************************************************************/
INSERT
	DonorData
	(
	CallID, 
	DonorDataMiddleName, 
	DonorDataLicense, 
	DonorDataAddress, 
	DonorDataCity, 
	DonorDataState, 
	DonorDataZip, 
	DonorDataNotAvailable, 
	LastModified, 
	MultipleDonorsFound,
	LastStatEmployeeID,	 
	AuditLogTypeID
	)
VALUES
	(		
	@CallID, 
	@DonorDataMiddleName, 
	@DonorDataLicense, 
	@DonorDataAddress, 
	@DonorDataCity, 
	@DonorDataState, 
	@DonorDataZip, 
	@DonorDataNotAvailable, 
	GetDate(), 
	@MultipleDonorsFound,
	@LastStatEmployeeID, 	
	1 -- @AuditLogTypeID 1 = Create
	)

SELECT
	DonorDataId, 
	CallID, 
	DonorDataMiddleName, 
	DonorDataLicense, 
	DonorDataAddress, 
	DonorDataCity, 
	DonorDataState, 
	DonorDataZip, 
	DonorDataNotAvailable,
	MultipleDonorsFound
FROM
	DonorData	
WHERE
	DonorDataId = SCOPE_IDENTITY() 




GO

GRANT EXEC ON InsertDonorData TO PUBLIC

GO
