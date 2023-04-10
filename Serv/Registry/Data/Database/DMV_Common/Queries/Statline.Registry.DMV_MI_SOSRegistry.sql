PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/10/2017 10:55:27 AM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spf_CreateDMVTempTable.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spi_IMPORT_ImportApply_A.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spi_IMPORT_ImportApply_XML.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistry_DMVLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistry_REGLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistryv2.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_IMPORT_A_DataCleanupInvalidAddress.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_IMPORT_All_ImportDonorFull.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidDOB.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidFirstLast.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidFullName.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spf_CreateDMVTempTable.sql'
GO
/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc: Stored Procedure: spf_CreateDMVTempTable
**
**		Auth: Moonray Schepart
**		Date: 05/28/2014 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**      05/28/2014	Moonray Schepart	initial
**		09/08/2015	mmaitan				Adding comment to force the script generator to pick up this script
*******************************************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable];
END
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE spf_CreateDMVTempTable AS

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DMVTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[DMVTempTable];

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL,
 	[FullName] [varchar] (715) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TiffFile] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TiffDir] [tinyint] NULL ,
	[BirthMonth] [int] NULL,
	[enrollmentdate] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	branchnumber [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PreviousDonorState varchar(50) NULL
) ON [PRIMARY]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spi_IMPORT_ImportApply_A.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spi_IMPORT_ImportApply_A]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_A];
END
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE  PROCEDURE spi_IMPORT_ImportApply_A AS
/******************************************************************************
**		File: spi_IMPORT_ImportApply_A.sql
**		Name: spi_IMPORT_ImportApply_A
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Chris Carroll	
**		Date: 01/23/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		01/23/2007		Chris Carroll			initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/
INSERT IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE, FULLNAME, enrollmentdate, branchnumber)
SELECT           IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE, FULLNAME, enrollmentdate, branchnumber
FROM IMPORT_A;


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spi_IMPORT_ImportApply_A create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spi_IMPORT_ImportApply_A created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spi_IMPORT_ImportApply_XML.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spi_IMPORT_ImportApply_XML]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_XML];
END
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE spi_IMPORT_ImportApply_XML AS

DECLARE @ImportLogID int
SELECT @ImportLogID = (SELECT MAX(ID) FROM IMPORTLOG WHERE RunStatus = 'LOADING')

/******************************************************************************
**		File: spi_IMPORT_ImportApply_XML.sql
**		Name: spi_IMPORT_ImportApply_XML
**		Desc: Move data into Import_A for data clean-up. Also check for extended zip code and
**		   add '-' if required. All records from SOS are donors.
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Chris Carroll	
**		Date: 01/29/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		01/29/2007		Chris Carroll			initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/

INSERT IMPORT_A(IMPORTLOGID, AADDR1, ACITY, ASTATE, AZIP, DOB, DONOR, FULLNAME, enrollmentdate, branchnumber)
SELECT	@ImportLogID,
	address,
	city,
	state,
	zipcode + CASE WHEN zipcode_extension IS NOT NULL THEN '-' ELSE '' END + ISNULL(zipcode_extension,'') AS zipcode,
	Birthdate,
	'Y',
	name, 
	enrollmentdate, 
	branchnumber

FROM  Import_XML;


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spi_IMPORT_ImportApply_XML create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spi_IMPORT_ImportApply_XML Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistry_DMVLoad.sql'
GO
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_CheckRegistry_DMVLoad]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_CheckRegistry_DMVLoad';
	DROP PROCEDURE [dbo].[sps_CheckRegistry_DMVLoad];
END
	PRINT 'Creating sps_CheckRegistry_DMVLoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE sps_CheckRegistry_DMVLoad
(
 	@DOB			SMALLDATETIME   = NULL,
	@LastName		VARCHAR(25) = NULL,
	@FirstName		VARCHAR(25) = NULL, 
	@MiddleName		VARCHAR(25) = NULL,
	@SSN			VARCHAR(11) = NULL,
	@LICENSE		VARCHAR(15) = NULL,
	@StreetAddress	VARCHAR(45) = NULL,
	@City			VARCHAR(25) = NULL,
	@State			VARCHAR(2) = NULL,
	@Zip			VARCHAR(10) = NULL,
	@Loc			INT = NULL
)	
/******************************************************************************
**		File: sps_CheckRegistry_DMVLoad.sql
**		Name: sps_CheckRegistry_DMVLoad
**		Desc: This sp searches for qualified donor using the FirstName, MiddleName, & LastName fields
**             
**		Return values: none
**
**		Called by:  FrmReferralDonorData.vb  
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    10/15/2007	ccarroll			added FirstName and LastName to SELECT
**	  10/17/2016	mberenson			Return DLA records from DMV_Common with results
**	  10/19/2016	mberenson			Changed source for dmv records to "State"
**	  11/16/2016	mberenson			Moved DLA logic to DMV_Common.sps_CheckRegistry_DLALoad.sql
**	  12/12/2016	mberenson			Return just the newest record
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	--Allow Wildcard Searching
	IF @FirstName IS NOT Null
	BEGIN
		SET @FirstName = '%' + @FirstName + '%';
	END
	IF @LastName IS NOT Null
	BEGIN
		SET @LastName = '%' + @LastName + '%';
	END

	--Look Up DMV Results
	SELECT TOP 1
			DMV.FirstName,
			DMV.MiddleName ,
			DMV.LastName,
			DMV.License,
			DMVAddr.Addr1,
			DMVAddr.City,
			DMVAddr.[State],
			DMVAddr.Zip,
			DMV.LastModified AS 'SearchDate',
			DMV.ID AS 'Loc',
			'State' AS [Source]
	FROM DMV
	LEFT JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID
	WHERE		DMV.DOB = @DOB
		/* Search (wildcards permitted) - LastName */
			AND (@LastName IS NULL OR DMV.LastName IS NULL OR PATINDEX(@LastName, DMV.LastName) > 0)
		/* Search (wildcards permitted) - FirstName */
			AND (@FirstName IS NULL OR DMV.FirstName IS NULL OR PATINDEX(@FirstName, DMV.FirstName) > 0)
			AND (@MiddleName IS NULL OR DMV.MiddleName IS NULL OR PATINDEX(@MiddleName, DMV.MiddleName) > 0)
			AND (@License IS NULL OR DMV.License IS NULL OR PATINDEX(@License, DMV.License) > 0)
			AND (@StreetAddress IS NULL OR DMVADDR.Addr1 IS NULL OR PATINDEX(@StreetAddress, DMVADDR.Addr1) > 0)
			AND (@City IS NULL OR DMVADDR.City IS NULL OR PATINDEX(@City, DMVADDR.City) > 0)
			AND (@State IS NULL OR DMVADDR.State IS NULL OR PATINDEX(@State, DMVADDR.State) > 0)
			AND (@Zip IS NULL OR DMVADDR.Zip IS NULL OR PATINDEX(@Zip, DMVADDR.Zip) > 0)
	ORDER BY DMV.LastModified DESC;

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistry_REGLoad.sql'
GO
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_CheckRegistry_REGLoad')
BEGIN
	PRINT 'Dropping Procedure sps_CheckRegistry_REGLoad';
	DROP PROCEDURE sps_CheckRegistry_REGLoad;
END
	PRINT 'Creating Procedure sps_CheckRegistry_REGLoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistry_REGLoad]
(
	@DOB			VARCHAR(255) = NULL,
	@LastName		VARCHAR(25) = NULL,
	@FirstName		VARCHAR(25) = NULL,
	@MiddleName		VARCHAR(25) = NULL,
	@SSN			VARCHAR(11) = NULL,
	@LICENSE		VARCHAR(15) = NULL,
	@StreetAddress	VARCHAR(45) = NULL,
	@City			VARCHAR(25) = NULL,
	@State			VARCHAR(2) = NULL,
	@Zip			VARCHAR(10) = NULL,
	@Loc			INT = NULL
)
/******************************************************************************
**		File: sps_CheckRegistry_REGLoad.sql
**		Name: sps_CheckRegistry_REGLoad
**		Desc: Returns matching donors from the web registry based on input fields
**
**		Return values: none
** 
**		Called by: StatTrac FrmReferralDonorData.vb
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**    10/15/2007		ccarroll			added FirstName and LastName to SELECT
**	  12/15/2014		Moonray Schepart	Inclusion of Common Registry	
**	  10/19/2016		mberenson			Added to source control
**	  10/19/2016		mberenson			Added source column
**	  12/22/2016		mberenson			Limited row count to the top 1
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	SET NOCOUNT ON;

	DECLARE @RegistryOwnerId INT = 6, -- MIOP
			@RegistryState NVARCHAR(10) = 'MI'; -- Web Donor State 
			
	SELECT TOP(1)
		r.FirstName,
		r.MIDDLENAME,
		r.LastName,
		r.License,
		ra.Addr1,
		ra.city AS [City],
		ra.[State] AS [State],
		ra.zip AS [Zip],
		r.LastModified AS [SearchDate],
		r.RegistryID AS [loc],
		'Web' AS [Source]

	FROM DMV_Common.dbo.Registry r
	JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryID = ra.RegistryID

	WHERE RegistryOwnerID = @RegistryOwnerID
	AND ra.[State] = @RegistryState
	AND r.DeleteFlag = 0
	AND	r.DOB = @DOB
	AND (@FirstName IS NULL OR r.FirstName IS NULL OR PATINDEX(@FirstName, r.FirstName) > 0)
	AND (@MiddleName IS NULL OR r.MiddleName IS NULL OR PATINDEX(@MiddleName, r.MiddleName) > 0)
	AND (@LastName IS NULL OR r.LastName IS NULL OR PATINDEX(@LastName, r.LastName) > 0)
	AND (@LICENSE IS NULL OR r.License IS NULL OR PATINDEX(@License, r.License) > 0)
	AND (@StreetAddress IS NULL OR ra.Addr1 IS NULL OR PATINDEX(@StreetAddress, ra.Addr1) > 0)
	AND (@City IS NULL OR ra.City IS NULL OR PATINDEX(@City, ra.City) > 0)
	AND (@State IS NULL OR ra.State IS NULL OR PATINDEX(@State, ra.State) > 0)
	AND (@Zip IS NULL OR ra.Zip IS NULL OR PATINDEX(@Zip, ra.Zip) > 0 )

	ORDER BY r.LastModified DESC;

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_CheckRegistryv2.sql'
GO
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistryv2]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	PRINT 'Dropping Procedure: sps_CheckRegistryv2';
	DROP PROCEDURE [dbo].[sps_CheckRegistryv2];
END
	PRINT 'Creating Procedure: sps_CheckRegistryv2';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistryv2]
(
	@DOB   			DATETIME    	= NULL,
	@LastName		VARCHAR(25) 	= NULL,
	@FirstName 		VARCHAR(25) 	= NULL,
	@NADD 			INT	       		= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   			VARCHAR(11) 	= NULL,
	@LICENSE 		VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 			VARCHAR(25) 	= NULL,
	@State 			VARCHAR(2) 		= NULL,
	@Zip 			VARCHAR(10) 	= NULL,
	@loc			INT				= NULL,
	@Found			VARCHAR(25)		= NULL
)
/******************************************************************************
**		File: sps_CheckRegistryv2.sql
**		Name: sps_CheckRegistryv2
**		Desc:  Returns registry data based on DOB, FirstName, & LastName
**		Paramameters
**			See above
**
**		Called by:  StatQuery.vb
**              
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		12/15/2014	Moonray Schepart	initial check from production database
**		10/17/2016	mberenson			Added DLA logic
**		11/16/2016	mberenson			Moved DLA logic to DMV_Common.sps_CheckRegistryv2
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;
	PRINT @loc;

	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT;
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0;

	-- get values for registry 
	IF  @Found = 'Web'  OR isnull(@Found,'') = '' 
	BEGIN
		EXEC sps_CheckRegistry_REGv2
			@DOB, 
			@LastName, 
			@FirstName, 
			@MiddleName, 
			@SSN, 
			@LICENSE, 
			@StreetAddress,
			@City,
			@State,
			@Zip,
			@loc,
			1,			-- This is the suspense variable see Note:			
			@RegistryID OUTPUT,
			@RegistryDonor OUTPUT,
			@RegistryDate OUTPUT,
			@REGRecordsReturned OUTPUT;
	END
	--PRINT @RegistryID;
	--PRINT @RegistryDonor;
	--PRINT @REGRecordsReturned;
	/*
	   Suspense Variable Note:
	   NULL returns both registry (non-suspense) and suspense records
	   1	returns registry  (non-suspense) records
	   0	returns suspense records

	*/
	PRINT @loc;
	-- check for multiple records from registry 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@REGRecordsReturned > 1 
		AND
		(ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = '' 
		)
	BEGIN
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' AS 'Organization',
		@REGRecordsReturned AS 'RecordsReturned';
		
		RETURN;
	END
	ELSE IF @REGRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
	BEGIN
			
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'N' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' AS 'Organization',
		@REGRecordsReturned AS 'RecordsReturned';
		
		RETURN;
	END
	PRINT @loc;

	IF @Found = 'State' OR ISNULL(@Found,'') = '' 
	BEGIN
		EXEC sps_CheckRegistry_DMVv2	
			@DOB, 
			@LastName, 
			@FirstName, 
			@MiddleName, 
			@SSN, 
			@LICENSE, 
			@StreetAddress,
			@City,
			@State,
			@Zip,
			@loc,
			@DMVID OUTPUT,
			@DMVDonor OUTPUT,
			@DMVDate OUTPUT,
			@DMVRecordsReturned OUTPUT;
	END
	
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = ''		 
		)
	BEGIN
		
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' AS 'Organization',
		@DMVRecordsReturned AS 'RecordsReturned';
		
		RETURN;
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
	BEGIN
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'N' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' AS 'Organization',
		@DMVRecordsReturned AS 'RecordsReturned';
		
		RETURN;	
	END
	PRINT @loc;

	--PRINT @DMVDonor;
	--PRINT @RegistryDonor;
	--PRINT @OnlineDonor;

	-- if all the values are null return a blank record set
	IF (ISNULL(@DMVID, '') + ISNULL(@RegistryID, '') = '' )	
	-- no values were found
	-- return empty record st
	BEGIN
			
		SELECT
			'No Registration' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' ,
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' AS 'Organization',
			@REGRecordsReturned AS 'RecordsReturned';
				
			RETURN;

	END	
	-- check for the Oldest Date
	ELSE
	BEGIN
		IF	(ISNULL(@RegistryDate,'1/1/1900') > ISNULL(@DMVDate,'1/1/1900') )

		--Return Registry
		BEGIN
			SELECT
				'Registry' AS 'Source',
				@RegistryID AS 'ID',
				CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
				@RegistryDate AS 'Date'	,
				@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
				AS 'RestrictionID';
			RETURN;				
		END		
		-- check if dmv is the latest date	
		ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
		-- Return DMV;
		BEGIN
			SELECT
				'DMV' AS 'Source',
				@DMVID AS 'ID',
				CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
				@DMVDate AS 'Date',
				CASE @RegistryDonor WHEN 1 THEN @RegistryID ELSE 0 END AS 'RestrictionID';
			RETURN;
		END
		-- check if all the values are not = N for No
		-- Both registry and dmv dates are equal, check that both = Y
		ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
		BEGIN
			-- if registry is not null return registry
			IF (@RegistryID IS NOT NULL)
			BEGIN
				PRINT ('Registry');
				SELECT
								
					'Registry' AS 'Source',
					@RegistryID AS 'ID',
					CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor',
					@RegistryDate AS 'Date'	,
					@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
					AS 'RestrictionID';
				RETURN;							
			END
			ELSE
			BEGIN 
				PRINT('DMV');
				SELECT
								
					'DMV' AS 'Source',
					@DMVID AS 'ID',
					CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
					@DMVDate AS 'Date',
					CASE @RegistryDonor WHEN 1 THEN @RegistryID ELSE 0 END AS 'RestrictionID';
				RETURN;
						
			END				
		END
		ELSE 	-- a result cannot be determined			
		-- return empty record st
		BEGIN
				
			SELECT
				'Undetermined Registration' AS 'Source',
				0 AS 'ID',
				'N' AS 'Donor' ,
				'1/1/1900' AS 'Date',
				@RestrictionID AS 'RestrictionID',
				'R' AS 'Organization',
				@REGRecordsReturned AS 'RecordsReturned';

				RETURN;
		END			
	END

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_IMPORT_A_DataCleanupInvalidAddress.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[sps_IMPORT_A_DataCleanupInvalidAddress];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE  PROCEDURE sps_IMPORT_A_DataCleanupInvalidAddress AS
/******************************************************************************
**		File: sps_IMPORT_A_DataCleanupInvalidAddress.sql
**		Name: sps_IMPORT_A_DataCleanupInvalidAddress
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Moonray Schepart	
**		Date: 05/28/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		05/28/2014		Moonray Schepart		initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields 
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/
DECLARE @suspect varchar(255)
SELECT @suspect = 'Invalid Address IMPORT_A'
BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect , enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE (
	(COALESCE(AADDR1,'') ='' )
   OR   (COALESCE(ACITY,'') = '' )
   OR 	(COALESCE(ACITY,'') LIKE '%[0-9]%')
   OR   (COALESCE(ASTATE,'') = '')
   OR   (COALESCE(AZIP,'') = '' )
 );

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE ((COALESCE(AADDR1,'') ='' )
   OR    (COALESCE(ACITY,'') = '' )
   OR 	(COALESCE(ACITY,'') LIKE '%[0-9]%')
   OR    (COALESCE(ASTATE,'') = '')
   OR    (COALESCE(AZIP,'') = '' )
 );

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_A_DataCleanupInvalidAddress create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_A_DataCleanupInvalidAddress created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\sps_IMPORT_All_ImportDonorFull.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonorFull]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_IMPORT_All_ImportDonorFull';
	DROP PROCEDURE [dbo].[sps_IMPORT_All_ImportDonorFull];
END
GO

	PRINT 'Creating sps_IMPORT_All_ImportDonorFull';
GO

CREATE  PROCEDURE sps_IMPORT_All_ImportDonorFull AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.sql
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc: This sporc is used to add New (DMVImport) to the following tables:
**			1. DMVTempTable
**			2. DMVADDRTempTable
**			3. DMVOrganTempTable 	
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
**		Auth: Moonray Schepart
**		Date: 03/06/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		03/06/2014  Moonray Schepart		initial conversion to Sequence based insert
**		05/28/2014	Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END
CREATE Table #TempIDTable
	(	[IMPORTID] [int] NOT NULL,
		[ID] [int] NOT NULL		
	);
	
DECLARE @CurrentID int;
DECLARE @alterSequenceSQL NVARCHAR(200);
DECLARE @IMPORTLOGID int;

SELECT @CurrentID = COALESCE(MAX(ID),5000)
FROM DMV;

SELECT @IMPORTLOGID = ID
FROM IMPORTLOG
WHERE UPPER(RunStatus) = 'LOADING';

IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'CountBy1') 
BEGIN
	DROP SEQUENCE CountBy1 ;	
END	
	CREATE SEQUENCE dbo.CountBy1
		START WITH 1
		INCREMENT BY 1 ;

   SET @alterSequenceSQL = 'ALTER SEQUENCE dbo.CountBy1 RESTART WITH ' + CONVERT(varchar(30),@CurrentID + 1);
   EXECUTE sp_executesql @alterSequenceSQL;

INSERT INTO #TempIDTable
SELECT  [ID],
		NEXT VALUE FOR dbo.CountBy1 
FROM IMPORT;

SET IDENTITY_INSERT DMVTempTable ON;


INSERT DMVTempTable ([ID],
					IMPORTLOGID,
					SSN,  
					License, 
					DOB, 
					FirstName, 
					MiddleName, 
					LastName, 
					Suffix, 
					Gender, 
					Donor, 
					RenewalDate, 
					DeceasedDate,  
					CSORState, 
					CSORLicense,
					LastModified, 
					CreateDate, 
					Fullname,
					TiffDir, 
					enrollmentdate, 
					branchnumber)
SELECT			
					T.ID,
					@IMPORTLOGID,
					NULL,
					LICENSE,
					CASE ISDATE(DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,DOB) END,
					LEFT(FIRST,25),
					LEFT(MIDDLE,25),
					LEFT(LAST,25),
					SUFFIX,
					GENDER,
					CASE UPPER(DONOR)
                        WHEN 'Y' THEN 1
                        ELSE 0
                      END,
					CASE ISDATE(RENEWALDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,RENEWALDATE) END,
						CASE ISDATE(DECEASEDDATE) WHEN 0 THEN NULL ELSE CONVERT(datetime,DECEASEDDATE) END,
						CSORSTATE,
					CSORLICENSE,
					ISNULL(CREATEDATE,GETDATE()),
					ISNULL(CREATEDATE,GETDATE()),
					FullName,
					1 AS 'TiffDir', 
					enrollmentdate, 
					branchnumber
					FROM IMPORT
						INNER JOIN
							#TempIDTable T
						ON T.IMPORTID = IMPORT.[ID];

SET IDENTITY_INSERT DMVTempTable OFF;

INSERT DMVADDRTempTable (
						DMVID,
						ADDRTYPEID,
						Addr1,
						Addr2,
						City,
						State,
						Zip)
SELECT					
						T.ID,
						1,
						AADDR1,
						NULL,
						ACITY,
						ASTATE,
						AZIP
FROM IMPORT
INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID] 
WHERE COALESCE(AADDR1,'') + COALESCE(ACITY,'') + COALESCE(ASTATE,'') + COALESCE(AZIP,'') <> '';


INSERT DMVADDRTempTable (
						DMVID,
						ADDRTYPEID,
						Addr1,
						Addr2,
						City,
						State,
						Zip)
SELECT	
						T.ID,
						2,
						BADDR1,
						NULL,
						BCITY,
						BSTATE,
						BZIP
FROM IMPORT
INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID] 
WHERE COALESCE(BADDR1,'') + COALESCE(BCITY,'') + COALESCE(BSTATE,'') + COALESCE(BZIP,'') <> '';

INSERT DMVORGANTempTable (
						DMVID,
						ORGANTYPEID)
SELECT	
						T.ID,
						CASE UPPER(DONOR) WHEN 'Y' THEN 1 ELSE 0 END
FROM IMPORT
	INNER JOIN
		#TempIDTable T
	ON T.IMPORTID = IMPORT.[ID]
WHERE COALESCE(DONOR,'') <> '';

IF (object_id('tempdb..#TempIDTable') IS NOT NULL)
BEGIN
	DROP TABLE #TempIDTable;
END
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidDOB.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidDOB]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidDOB];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


-- sp_helptext IMPORT_DataCleanupInvalidDOB
CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidDOB AS
/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidDOB.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidDOB
**		Desc: Removes records with invallid DOB and puts them in Suspense
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Christopher Carroll	
**		Date: 01/23/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		01/23/2007		Christopher Carroll		initial release
**		05/28/2014		Moonray Schepart		Include Branch Number and Enrollment Date fields 
**		09/08/2015		mmaitan					Adding comment to force the script generator to pick up this script
*******************************************************************************/

DECLARE @suspect varchar(255);

SELECT @suspect = 'Invalid Date of Birth IMPORT_A'
BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect, enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE COALESCE(DOB,'') = '';

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE COALESCE(DOB,'') = '';

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_A_DataCleanupInvalidDOB create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_A_DataCleanupInvalidDOB Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidFirstLast.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidFirstLast AS
/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidFirstLast.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidFirstLast
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
**		None
**
**		Auth: Moonray Schepart
**		Date: 05/28/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		05/28/2014  Moonray Schepart		initial 
**		05/28/2014	Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan				Adding comment to force the script generator to pick up this script
*******************************************************************************/
DECLARE @suspect varchar(255);

SELECT @suspect = 'Invalid First or Last Name IMPORT_A';

BEGIN TRANSACTION IMPORT_A
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect, enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE COALESCE(FIRST,'') = ''
 OR COALESCE(LAST,'') = '';

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE COALESCE(FIRST,'') = ''
  OR COALESCE(LAST,'') = '';

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_A_DataCleanupInvalidFirstLast create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_A_DataCleanupInvalidFirstLast Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI_SOS\sprocs\spu_IMPORT_A_DataCleanupInvalidFullName.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidFullName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_A_DataCleanupInvalidFullName];
END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE  PROCEDURE spu_IMPORT_A_DataCleanupInvalidFullName AS
/******************************************************************************
**		File: spu_IMPORT_A_DataCleanupInvalidFullName.sql
**		Name: spu_IMPORT_A_DataCleanupInvalidFullName
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
**		None
**
**		Auth: Moonray Schepart
**		Date: 05/28/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------	--------				--------------------------------------
**		05/28/2014  Moonray Schepart		initial 
**		05/28/2014	Moonray Schepart		Include Branch Number and Enrollment Date fields
**		09/08/2015		mmaitan				Adding comment to force the script generator to pick up this script
*******************************************************************************/
DECLARE @suspect varchar(255);

SELECT @suspect = 'Invalid Full Name IMPORT_A';

BEGIN TRANSACTION IMPORT_A;
  INSERT SUSPENSE_A
  SELECT IMPORTLOGID,LAST,FIRST,MIDDLE,SUFFIX,AADDR1,ACITY,ASTATE,AZIP,BADDR1,BCITY,BSTATE,BZIP,DOB,GENDER,LICENSE,DONOR,RENEWALDATE,DECEASEDDATE,CSORSTATE,CSORLICENSE,FULLNAME, 0, @suspect, enrollmentdate, branchnumber
  FROM IMPORT_A
  WHERE COALESCE(FULLNAME,'') = ''
  OR COALESCE(FULLNAME,'') LIKE '%[0-9]%';

  UPDATE IMPORTLOG
  SET RecordsSuspended = RecordsSuspended + @@rowcount
  WHERE RunStatus = 'LOADING';

  DELETE FROM IMPORT_A
  WHERE COALESCE(FULLNAME,'') = ''
  OR COALESCE(FULLNAME,'') LIKE '%[0-9]%';

COMMIT TRANSACTION IMPORT_A;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spu_IMPORT_A_DataCleanupInvalidFullName create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spu_IMPORT_A_DataCleanupInvalidFullName Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/


GO
