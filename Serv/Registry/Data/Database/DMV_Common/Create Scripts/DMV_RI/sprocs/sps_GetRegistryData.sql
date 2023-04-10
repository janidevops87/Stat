IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_GetRegistryData]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_GetRegistryData]
	PRINT 'Dropping Procedure: sps_GetRegistryData'
END
	PRINT 'Creating Procedure: sps_GetRegistryData'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sps_GetRegistryData]
(
	@DMVID	INTEGER =0,
	@RegID	INTEGER =0	

)
/******************************************************************************
**		File: sps_GetRegistryData.sql
**		Name: sps_GetRegistryData
**		Desc:  NEOB Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 05/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/11/2009	ccarroll	initial
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- declare variables
	DECLARE
	@Restriction	VARCHAR(30), -- Used to hold the restrictions from the registry table
	@ADDR1		VARCHAR(40), -- Address Holders
	@ADDR2		VARCHAR(20),
	@CITY		VARCHAR(25),
	@STATE		VARCHAR(2),
	@ZIP		VARCHAR(10),
	@ADDRType	VARCHAR(30)
	
    -- if DMVID is > 0 select data from DMV tables
    IF @DMVID > 0 
    BEGIN
	-- check if the @RegID is > 0. Get Registry Comment if it is
	IF @RegID > 0
	BEGIN
		SELECT 	@Restriction 	= ISNULL(Comment, '')
		FROM 	DMV_Common.dbo.Registry
		WHERE	RegistryID		= @RegID
	END
	ELSE
	BEGIN
		SELECT @Restriction = ''
	END
	-- build the address field
	SELECT  TOP 1
		@ADDR1	= Addr1,
		@ADDR2	= ISNULL(Addr2,''),
		@CITY	= ISNULL(City,''),
		@STATE	= ISNULL(State,''),
		@ZIP	= ISNULL(Zip,''),
		@ADDRType = RTRIM(LTRIM(AD.Description))
	FROM	DMVADDR
	LEFT 
	JOIN	AddrType AD ON AD.ID = DMVADDR.AddrTypeID
	WHERE	DMVID	= @DMVID
	ORDER 
	BY	AddrTypeID

	SELECT 
		License AS 'RegistryID',
		ISNULL(FirstName, '') AS 'FirstName',
		ISNULL(MiddleName, '') AS 'MiddleName',
		ISNULL(LastName, '') AS 'LastName',
		ISNULL(DOB, '') AS 'DOB',
		ISNULL(Suffix, '') AS 'Suffix',
		ISNULL(Gender,'') AS 'Gender', 
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
		'' AS 'DonorYear'		
	FROM	DMV	
	WHERE	ID	= 	@DMVID

		
	
    END
    ELSE 
    BEGIN
    -- if DMVID = 0 select data from Registry
    
	-- build the address field
	SELECT TOP 1
		@ADDR1		= Addr1,
		@ADDR2		= ISNULL(Addr2, ''),
		@CITY		= City,
		@STATE		= State,
		@ZIP		= Zip,
		@ADDRType 	= RTRIM(LTRIM(AD.Description))
	FROM	DMV_Common.dbo.RegistryAddr	AS RegistryAddr
	LEFT 
	JOIN	AddrType AD ON AD.ID = RegistryAddr.AddrTypeID
	WHERE	RegistryID	= @RegID
	ORDER 
	BY	AddrTypeID
        
    	SELECT 
    		CASE 	WHEN LEN(License)=9 THEN License
    			ELSE CAST(RegistryID AS VARCHAR(20))
    		END AS 'RegistryID',
		ISNULL(FirstName, '') AS 'FirstName',
		ISNULL(MiddleName, '') AS 'MiddleName',
		ISNULL(LastName, '') AS 'LastName',
		ISNULL(DOB, '') AS 'DOB',
		ISNULL(Suffix, '') AS 'Suffix',
		ISNULL(Gender,'') AS 'Gender', 
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
		ISNULL(RTRIM(LTRIM(Comment)), '') AS 'Restriction',
		RegistryID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear'		
	FROM	DMV_Common.dbo.Registry
	WHERE	RegistryID	=	@RegID
    
    END
 