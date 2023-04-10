IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_GetRegistryDataSOS')
	BEGIN
		PRINT 'Dropping Procedure sps_GetRegistryDataSOS'
		DROP  Procedure  sps_GetRegistryDataSOS
	END

GO

PRINT 'Creating Procedure sps_GetRegistryDataSOS'
GO
CREATE Procedure sps_GetRegistryDataSOS
	@SOSID INTEGER = 0

AS
/******************************************************************************
**		File: 
**		Name: sps_GetRegistryDataSOS
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
**
**		Auth: ccarroll
**		Date: 01/25/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------		--------	-------------------------------------------
**    01/25/2007		ccarroll	
**	  12/13/2010		ccarroll	Added suffix to fullname field
*******************************************************************************/

 DECLARE
 @ADDR1  VARCHAR(40), -- Address Holders
 @ADDR2  VARCHAR(20),
 @CITY  VARCHAR(25),
 @STATE  VARCHAR(2),
 @ZIP  VARCHAR(10),
 @ADDRType VARCHAR(30)

 		-- build the address field
		SELECT  TOP 1
			@ADDR1 = Addr1,
			@ADDR2 = ISNULL(Addr2,''),
			@CITY = City,
			@STATE = State,
			@ZIP = Zip,
			@ADDRType = RTRIM(LTRIM(AD.Description))
		FROM DMV_MI_SOS.dbo.DMVADDR dr
 		LEFT JOIN AddrType AD ON AD.ID = dr.AddrTypeID
 		WHERE DMVID = @SOSID
 		ORDER BY AddrTypeID;

		SELECT 
			CASE WHEN License IS NULL THEN CAST(DMV.ID AS VARCHAR(20)) ELSE License END AS 'RegistryID',
			RTRIM(FullName + ' ' + IsNull(Suffix, '')) AS 'FirstName',
			'' AS 'MiddleName',
			'' AS 'LastName',
			DOB,
			Suffix,
			Gender,
			CASE Donor WHEN 0 Then 'N' WHEN 1 THEN 'Y' END AS 'Donor',
  			CASE WHEN RenewalDate IS NULL THEN CASE WHEN LastModified IS NULL THEN CreateDate ELSE LastModified END ELSE RenewalDate END AS 'DonorFlagDate',  
			'' AS 'Restriction',
			DMV.ID,
			@ADDR1 AS 'ADDR1',
			@ADDR2 AS 'ADDR2', 
			@CITY AS 'CITY', 
			@STATE AS 'STATE', 
			@ZIP AS 'ZIP',
			@ADDRType AS 'AddrType',
			'' AS 'DonorYear',
			'' AS 'ImageFile'
   		FROM DMV_MI_SOS.dbo.DMV dmv
		WHERE DMV.ID =  @SOSID;

GO

