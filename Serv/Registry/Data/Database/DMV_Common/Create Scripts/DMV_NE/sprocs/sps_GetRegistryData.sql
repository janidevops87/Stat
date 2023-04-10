IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_GetRegistryData]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sps_GetRegistryData]
	PRINT 'Dropping Procedure: sps_GetRegistryData'
END
PRINT 'Creating Procedure: sps_GetRegistryData'

GO

CREATE Procedure [dbo].[sps_GetRegistryData]
	@DMVID	INTEGER =0,
	@RegID	INTEGER =0	

AS
/******************************************************************************
**		File: sps_GetRegistryData.sql
**		Name: sps_GetRegistryData
**		Desc: 
**
**		Return values:
** 
**		Called by: StatTrac
**              
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		02/21/2014	ccarroll			Modified for DMV_Common registry
**		07/29/2014	Moonray Schepart	Inlcusion of Display Name
**		08/23/2016	Mike Berenson		Added Source & Fixed Population of Restriction
**		01/17/2017	Mike Berenson		Added defaults to Coalesce function in select of 
**										FirstName, MiddleName, and LastName
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
SET NOCOUNT ON;

	DECLARE
	@Restriction	VARCHAR(30), -- Used to hold the restrictions from the registry table
	@ADDR1		VARCHAR(40), -- Address Holders
	@ADDR2		VARCHAR(20),
	@CITY		VARCHAR(25),
	@STATE		VARCHAR(2),
	@ZIP		VARCHAR(10),
	@ADDRType	VARCHAR(30);
	
    -- if DMVID is > 0 select data from DMV tables
    IF @DMVID > 0 
    BEGIN
	-- check if the @RegID is > 0. Get Registry Comment if it is
	IF @RegID > 0
	BEGIN
		SELECT 	@Restriction 	= COALESCE(Comment, '')
		FROM 	Registry
		WHERE	ID	= @RegID;
	END
	ELSE
	BEGIN
		SELECT @Restriction = ''
	END
	-- build the address field
	SELECT  TOP 1
		@ADDR1	= Addr1,
		@ADDR2	= COALESCE(Addr2,''),
		@CITY	= COALESCE(City,''),
		@STATE	= COALESCE(State,''),
		@ZIP	= COALESCE(Zip,''),
		@ADDRType = RTRIM(LTRIM(AD.Description))
	FROM	DMVADDR
	LEFT 
	JOIN	AddrType AD ON AD.ID = DMVADDR.AddrTypeID
	WHERE	DMVID	= @DMVID
	ORDER 
	BY	AddrTypeID;

	SELECT 
		License AS 'RegistryID',
		COALESCE(FirstName_Display, FirstName, '') AS 'FirstName',
		COALESCE(MiddleName_Display, MiddleName, '') AS 'MiddleName',
		COALESCE(LastName_Display, LastName, '') AS 'LastName',
		COALESCE(DOB, '') AS 'DOB',
		COALESCE(Suffix, '') AS 'Suffix',
		COALESCE(Gender,'') AS 'Gender', 
		CASE Donor 
		    	WHEN 0 Then 'N'
		    	WHEN 1 THEN 'Y'
			Else ''
    		END AS 'Donor',
		CASE 
			WHEN RenewalDate IS NULL 
			THEN CASE 
				WHEN LastModified IS NULL 
				THEN CreateDate
				ELSE LastModified 
			     END
			ELSE RenewalDate
		END AS 'DonorFlagDate',		
		@Restriction 'Restriction',
		ID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear',
		'DMV' AS 'Source'		
	FROM	DMV	
	WHERE	ID	= 	@DMVID;

    END
    ELSE 
    BEGIN
    -- if DMVID = 0 select data from Registry
    
	-- build the address field
	SELECT TOP 1
		@ADDR1		= Addr1,
		@ADDR2		= COALESCE(Addr2, ''),
		@CITY		= City,
		@STATE		= State,
		@ZIP		= Zip,
		@ADDRType 	= RTRIM(LTRIM(AD.Description))
	FROM	DMV_Common.dbo.RegistryAddr	RegistryAddr
	LEFT JOIN DMV_Common.dbo.AddrType AD ON AD.AddrTypeID = RegistryAddr.AddrTypeID
	WHERE	RegistryID	= @RegID
	ORDER 
	BY	AD.AddrTypeID;
        
    	SELECT 
    		CASE 	WHEN LEN(License)=9 THEN License
    			ELSE CAST(RegistryID AS VARCHAR(20))
    		END AS 'RegistryID',
		COALESCE(FirstName, '') AS 'FirstName',
		COALESCE(MiddleName, '') AS 'MiddleName',
		COALESCE(LastName, '') AS 'LastName',
		COALESCE(DOB, '') AS 'DOB',
		COALESCE(Suffix, '') AS 'Suffix',
		COALESCE(Gender,'') AS 'Gender', 
    		CASE Donor 
    			WHEN 0 Then 'N'
    			WHEN 1 THEN 'Y'
			ELSE ''
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
		COALESCE(RTRIM(LTRIM(Limitations)), '') AS 'Restriction',
		RegistryID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear',
		'Web' AS 'Source'		
	FROM	DMV_Common.dbo.Registry Registry
	WHERE	RegistryID	=	@RegID;
    
    END

GO


