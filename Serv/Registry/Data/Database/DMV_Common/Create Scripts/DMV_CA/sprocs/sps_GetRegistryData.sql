
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetRegistryData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_GetRegistryData'
	drop procedure [dbo].[sps_GetRegistryData]
End
GO

	PRINT 'Creating sps_GetRegistryData'
GO




CREATE  PROCEDURE sps_GetRegistryData
	@DMVID	INTEGER =0,
	@RegID	INTEGER =0	

AS
/******************************************************************************
**		File: sps_GetRegistryData.sql
**		Name: sps_GetRegistryData
**		Desc: Checks Registry and DMV donors used by registry searches. DMV searches
**			return blank limitation values to provide consistency with verification form.
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
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/
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
		FROM 	Registry
		WHERE	ID		= @RegID
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
 		'' AS 'Limitations',
		'' AS 'LimitationsOther',
		ISNULL(License,'') AS'License',
		'' AS'Email',
		1 AS 'DonorConfirmed',
		'' AS 'Email',

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
		'DMV Registrant' AS 'Source'
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
	FROM	RegistryAddr	
	LEFT 
	JOIN	AddrType AD ON AD.ID = RegistryAddr.AddrTypeID
	WHERE	RegistryID	= @RegID
	ORDER 
	BY	AddrTypeID
        
    	SELECT 
    		CASE 	WHEN LEN(License)=9 THEN License
    			ELSE CAST(ID AS VARCHAR(20))
    		END AS 'RegistryID',
		ISNULL(FirstName, '') AS 'FirstName',
		ISNULL(MiddleName, '') AS 'MiddleName',
		ISNULL(LastName, '') AS 'LastName',
		ISNULL(DOB, '') AS 'DOB',
		ISNULL(Suffix, '') AS 'Suffix',
		ISNULL(Gender,'') AS 'Gender',
 		ISNULL(Limitations,'') AS 'Limitations',
		ISNULL(LimitationsOther,'') AS 'LimitationsOther',
		ISNULL(License,'') AS'License',
		ISNULL(Email,'') AS'Email',
		       DonorConfirmed,
		ISNULL(Email,'') AS 'Email',
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
		ID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear',
		'Online Registrant' AS 'Source'
	FROM	Registry
	WHERE	ID	=	@RegID
    
    END

GO


