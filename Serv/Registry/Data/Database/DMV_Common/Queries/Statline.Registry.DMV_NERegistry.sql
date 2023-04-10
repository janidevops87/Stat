PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:2/8/2017 10:52:45 AM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\spf_CreateDMVAddrTempTable.sql
-- C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\spf_CreateDMVTempTable.sql
-- C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\sps_GetRegistryData.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\spf_CreateDMVAddrTempTable.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVAddrTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVAddrTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVAddrTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVAddrTempTable'
GO

USE [DMV_NE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVAddrTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVAddrTempTable.sql
**		Name: spf_CreateDMVAddrTempTable
**		Desc:  NE DMVAddr Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 10/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		10/28/2009	ccarroll	initial
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVAddrTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	drop table [dbo].[DMVAddrTempTable]
END
CREATE TABLE [dbo].[DMVAddrTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DMVID] [int] NULL,
	[AddrTypeID] [int] NULL,
	[Addr1] [varchar](40) NULL,
	[Addr2] [varchar](20) NULL,
	[City] [varchar](25) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[ZipExt] [varchar](4) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL
	) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'IDX_DMVADDRTempTable_DMVID_AddrTypeID')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_DMVID_AddrTypeID]
	ON [dbo].[DMVADDRTempTable] ([DMVID], [AddrTypeID]) ON IDX;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'[IDX_DMVADDRTempTable_AddrTypeID_Includes]')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_AddrTypeID_Includes]
	ON [dbo].[DMVADDRTempTable] ([AddrTypeID]) INCLUDE ([DMVID]) ON IDX;
GO


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\spf_CreateDMVTempTable.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVTempTable'
GO

USE [DMV_NE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc:  NE DMV Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 10/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		10/28/2009	ccarroll	initial
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	drop table [dbo].[DMVTempTable]
END
CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportLogID] [int] NULL,
	[SSN] [varchar](11) NULL,
	[LicenseType] [varchar](2) NULL,
	[License] [varchar](9) NULL,
	[IssueDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[DOB] [datetime] NULL,
	[FirstName] [varchar](20) NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](25) NULL,
	[Suffix] [varchar](4) NULL,
	[Gender] [varchar](1) NULL,
	[Donor] [bit] NOT NULL,
	[RenewalDate] [datetime] NULL,
	[DeceasedDate] [datetime] NULL,
	[CSORState] [varchar](2) NULL,
	[CSORLicense] [varchar](25) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[PreviousDonorState] [varchar](50) NULL,
	[RaceID] [int] NULL,
	[SendInfoFlag] [smallint] NULL,
	[SendInfoDate] [datetime] NULL
) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVTempTable]') AND name = N'[IDX_DMVTempTable_ID]')
	CREATE NONCLUSTERED INDEX [IDX_DMVTempTable_ID]
	ON [dbo].[DMVTempTable] ([ID]) on IDX;
GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST244ReferralAuditTrailBugFix\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NE\sprocs\sps_GetRegistryData.sql'
GO
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



GO
