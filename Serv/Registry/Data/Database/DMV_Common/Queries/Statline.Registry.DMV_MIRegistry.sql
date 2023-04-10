PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/10/2017 10:58:59 AM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\sps_CheckRegistry_DMVLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\SPS_CheckRegistry_REGLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\sps_CheckRegistryv2.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\sps_CheckRegistry_DMVLoad.sql'
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
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\SPS_CheckRegistry_REGLoad.sql'
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
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    10/15/2007		ccarroll				added FirstName and LastName to SELECT
**	  10/19/2016		mberenson				Added source column
**	  12/22/2016		mberenson				Limited row count to the top 1
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;	
	
	SELECT TOP(1)
				r.FirstName,
				r.MiddleName,
				r.LastName,
				r.License,
				ra.Addr1,
				ra.City,
				ra.State,
				ra.Zip,
				DATENAME(MONTH, DATEADD(MONTH, r.BirthMonth, -1)) AS 'SearchDate',
				r.ID AS 'loc',
				'Web' AS [Source]

	FROM		Registry r
	LEFT JOIN	RegistryAddr ra ON ra.RegistryID = r.ID
		
	WHERE		(@FirstName IS NULL OR r.FirstName IS NULL OR PATINDEX(@FirstName, r.FirstName) > 0)
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
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MI\Create Scripts\Stored Procedures\sps_CheckRegistryv2.sql'
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
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		10/17/2016	mberenson	Added to source control 
**		10/17/2016	mberenson	Added DLA logic
**		11/16/2016	mberenson	Moved DLA logic to DMV_Common.sps_CheckRegistryv2
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
