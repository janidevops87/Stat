 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_GetRegistryData]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[sps_GetRegistryData]
			PRINT 'Dropping Procedure: sps_GetRegistryData'
	END

PRINT 'Creating Procedure: sps_GetRegistryData'
GO

CREATE PROCEDURE [dbo].[sps_GetRegistryData]
	@DMVID INTEGER =0,
	@RegID INTEGER =0 
/******************************************************************************
**		File: sps_GetRegistryData.sql
**		Name: sps_GetRegistryData
**		Desc: Web Registry
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 12/13/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		12/13/2010	ccarroll	Added Suffix to fullname(DMV) and Lastname(registry)
*******************************************************************************/
AS

SET NOCOUNT ON
/*
 Designed AND Developed 01/2003
 Legal Information...
  c1996-2003 Statline, LLC. All rights reserved. 
  Statline is a registered trademark of Statline, LLC in the U.S.A. 
  7555 East Hampden Avenue, Ste. 104, 
  Denver, CO 80231. 
  1-888-881-7828. 
*/
 -- declare variables
 DECLARE
 @Restriction VARCHAR(30), -- Used to hold the restrictions from the registry table
 @ADDR1  VARCHAR(40), -- Address Holders
 @ADDR2  VARCHAR(20),
 @CITY  VARCHAR(25),
 @STATE  VARCHAR(2),
 @ZIP  VARCHAR(10),
 @ADDRType VARCHAR(30)
 
-- if DMVID is > 0 select data from DMV tables
IF @DMVID > 0 
	BEGIN
	-- check if the @RegID is > 0. Get Registry Comment if it is
		IF @RegID > 0
			BEGIN
				SELECT  @Restriction  = ISNULL(Comment, '')
				FROM  Registry
				WHERE ID  = @RegID;
 			END
		ELSE
 			BEGIN
  				SELECT @Restriction = ''
 			END

 		-- build the address field
		SELECT  TOP 1
			@ADDR1 = Addr1,
			@ADDR2 = ISNULL(Addr2,''),
			@CITY = City,
			@STATE = State,
			@ZIP = Zip,
			@ADDRType = RTRIM(LTRIM(AD.Description))
		FROM DMVADDR
 		LEFT JOIN AddrType AD ON AD.ID = DMVADDR.AddrTypeID
 		WHERE DMVID = @DMVID
 		ORDER BY AddrTypeID;

		SELECT 
			CASE WHEN License IS NULL THEN CAST(DMV.ID AS VARCHAR(20) )
   				ELSE License 
  			END AS 'RegistryID',
			RTRIM(FullName + ' ' + IsNull(Suffix, '')) AS 'FirstName',
			'' AS 'MiddleName',
			'' AS 'LastName',
			DOB,
			Suffix,
			Gender,
			CASE Donor 
       				WHEN 0 Then 'N'
				WHEN 1 THEN 'Y'
			END AS 'Donor',
  			CASE 
   				WHEN RenewalDate IS NULL THEN 
				CASE 
    					WHEN LastModified IS NULL THEN CreateDate
    					ELSE LastModified 
        			END
   				ELSE RenewalDate
  			END AS 'DonorFlagDate',  
			@Restriction 'Restriction',
			DMV.ID,
			@ADDR1 AS 'ADDR1',
			@ADDR2 AS 'ADDR2', 
			@CITY AS 'CITY', 
			@STATE AS 'STATE', 
			@ZIP AS 'ZIP',
			@ADDRType AS 'AddrType',
			'' AS 'DonorYear' ,
			CASE 
   				WHEN RIGHT(DFD.FILEDIRECTORY,1) = '\' THEN DFD.FILEDIRECTORY 
   				ELSE DFD.FILEDIRECTORY + '\'
  			END
  			+  TIFFFILE AS 'ImageFile'
   		FROM DMV,  DMVFILEDIR DFD  
		WHERE DMV.ID =  @DMVID
		AND DFD.ID = DMV.TiffDir;
	END
ELSE 
	BEGIN
		-- if DMVID = 0 select data from Registry
    
		-- build the address field
		SELECT TOP 1
			@ADDR1  = Addr1,
			@ADDR2  = ISNULL(Addr2, ''),
			@CITY  = City,
			@STATE  = State,
			@ZIP  = Zip,
			@ADDRType  = RTRIM(LTRIM(AD.Description))
		FROM RegistryAddr 
 		LEFT JOIN AddrType AD ON AD.ID = RegistryAddr.AddrTypeID
		WHERE RegistryID = @RegID
		ORDER BY AddrTypeID;
        
		SELECT 
			CASE 
				WHEN LEN(License)=9 THEN License
       				ELSE CAST(ID AS VARCHAR(20))
			END AS 'RegistryID',
			FirstName,
			MiddleName,
			RTRIM(LastName + ' ' + IsNull(Suffix, '')) AS 'LastName',
			DOB,
			Suffix,
			Gender,
			CASE Donor 
				WHEN 0 Then 'N'
				WHEN 1 THEN 'Y'
			END AS 'Donor',
			CASE 
				WHEN SignatureDate IS NULL 
				THEN CASE 
					WHEN OnlineRegDate IS NULL 
					THEN LastModified
					ELSE OnlineRegDate 
				END
				ELSE SignatureDate
			END AS 'DonorFlagDate',
  			ISNULL(RTRIM(LTRIM(Comment)), '') AS 'Restriction',
			ID,
			@ADDR1 AS 'ADDR1',
			@ADDR2 AS 'ADDR2', 
			@CITY AS 'CITY', 
			@STATE AS 'STATE', 
			@ZIP AS 'ZIP',
			@ADDRType AS 'AddrType',
			'' AS 'DonorYear' ,
			-- Added ability to get image files if there is a DMVId in Registry table.  3/8/05 - SAP
			(SELECT CASE WHEN RIGHT(DFD.FILEDIRECTORY,1) = '\' THEN DFD.FILEDIRECTORY 
   					ELSE DFD.FILEDIRECTORY + '\'
  				END
  				+  TIFFFILE AS 'ImageFile'
   				FROM DMV,  DMVFILEDIR DFD  
				WHERE DMV.ID =  Registry.DmvId
				AND DFD.ID = DMV.TiffDir) AS 'ImageFile'
		FROM Registry
 		WHERE ID = @RegID;
	END

GO
