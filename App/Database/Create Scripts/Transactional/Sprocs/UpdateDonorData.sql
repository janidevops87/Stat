IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateDonorData')
	BEGIN
		PRINT 'Dropping Procedure UpdateDonorData'
		DROP  Procedure  UpdateDonorData
	END

GO

PRINT 'Creating Procedure UpdateDonorData'
GO
CREATE Procedure UpdateDonorData
    @DonorDataId int , 
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
**		File: UpdateDonorData.sql
**		Name: UpdateDonorData
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
**      7/23/2007	Thien Ta			8.4.3.5.1, 8.4.3.5.2 Requirement
*******************************************************************************/
UPDATE
	DonorData
SET
	DonorDataMiddleName = @DonorDataMiddleName, 
	DonorDataLicense = @DonorDataLicense, 
	DonorDataAddress = @DonorDataAddress, 
	DonorDataCity = @DonorDataCity, 
	DonorDataState = @DonorDataState, 
	DonorDataZip = @DonorDataZip, 
	DonorDataNotAvailable = ISNULL(@DonorDataNotAvailable, DonorDataNotAvailable), 
	LastModified = GetDate(), 
	MultipleDonorsFound = @MultipleDonorsFound,
	LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID), 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE 
	DonorDataId = @DonorDataId
GO

GRANT EXEC ON UpdateDonorData TO PUBLIC

GO
