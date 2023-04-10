PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:3/30/2017 11:10:30 AM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST247NoCall\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_CA\sprocs\sps_CheckRegistry_DMVLoad.sql
-- C:\Statline\StatTrac\Development\CCRST247NoCall\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_CA\sprocs\sps_CheckRegistry_DMVv2.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST247NoCall\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_CA\sprocs\sps_CheckRegistry_DMVLoad.sql'
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
**		See above
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/15/2007  ccarroll			initial
**		10/17/2016	mberenson			Return DLA records from DMV_Common with results
**		10/19/2016	mberenson			Changed source for dmv records to "State"
**		11/16/2016	mberenson			Moved DLA logic to DMV_Common.sps_CheckRegistry_DLALoad.sql
**		12/12/2016	mberenson			Return just the newest record
**		03/28/2017	mberenson			Key search on FullName instead of FirstName & LastName
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
			AND (@LastName IS NULL OR DMV.LastName IS NULL OR PATINDEX(@LastName, DMV.FullName) > 0)
		/* Search (wildcards permitted) - FirstName */
			AND (@FirstName IS NULL OR DMV.FirstName IS NULL OR PATINDEX(@FirstName, DMV.FullName) > 0)
			AND (@MiddleName IS NULL OR DMV.MiddleName IS NULL OR PATINDEX(@MiddleName, DMV.FullName) > 0)
			AND (@License IS NULL OR DMV.License IS NULL OR PATINDEX(@License, DMV.License) > 0)
			AND (@StreetAddress IS NULL OR DMVADDR.Addr1 IS NULL OR PATINDEX(@StreetAddress, DMVADDR.Addr1) > 0)
			AND (@City IS NULL OR DMVADDR.City IS NULL OR PATINDEX(@City, DMVADDR.City) > 0)
			AND (@State IS NULL OR DMVADDR.State IS NULL OR PATINDEX(@State, DMVADDR.State) > 0)
			AND (@Zip IS NULL OR DMVADDR.Zip IS NULL OR PATINDEX(@Zip, DMVADDR.Zip) > 0)
	ORDER BY DMV.LastModified DESC;

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST247NoCall\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_CA\sprocs\sps_CheckRegistry_DMVv2.sql'
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMVv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping SPS_CheckRegistry_DMVv2'
	drop procedure [dbo].[SPS_CheckRegistry_DMVv2]
End
GO

	PRINT 'Creating SPS_CheckRegistry_DMVv2'
GO


CREATE  Procedure SPS_CheckRegistry_DMVv2
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@loc int = NULL,
	@DMVID INT OUTPUT,
	@DMVDonor BIT OUTPUT,
	@DMVDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/******************************************************************************
**		File: SPS_CheckRegistry_DMVv2.sql
**		Name: SPS_CheckRegistry_DMVv2
**		Desc: This sp searches for qualified donor using the FULLNAME string
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
print 'loc'
print @loc

if  isnull(@loc,'') <>  ''
		begin
		print 'enter'
		--print @loc
			SELECT  --TOP 1
			@DMVID = D.ID ,
			@DMVDonor = D.Donor ,
			@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
						CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
					ELSE D.RENEWALDATE END

				FROM DMV D
				WHERE	d.id = @loc --DOB		  = @DOB			
				AND Patindex('%'+ @FirstName + '%' ,FULLNAME) > 0
				AND Patindex('%'+ @LastName+ '%' ,FULLNAME) > 0


				ORDER BY LASTMODIFIED DESC

				-- get the number of records returned
				SELECT @RecordsReturned = @@RowCount
			Return
		end
	-- get values for dmv
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'DMV: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@DMVID = D.ID ,
			@DMVDonor = D.Donor ,
			@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
						CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
					ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE	Patindex('%' + @FirstName +'%' ,FULLNAME) > 0
		AND      Patindex('%' + @LastName +'%' ,FULLNAME) > 0

--		WHERE	FirstName         = @FirstName
--		AND	LastName          = @LastName		 
		AND	DOB		  = @DOB					
		
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount

		-- if records returned is greater than 0 then clear the variables
		-- Note: record count is only done in DMV query. DMV Should never have a duplicate
		-- 	 Duplicates are check for by CA DMV, Statline and again in this sp
		IF @RecordsReturned > 1 
		BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
		END

	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'DMV: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	License		= @LICENSE
			
				
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount
			
			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by CA DMV, Statline and again in this sp
			
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END
		
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END

						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	MiddleName	= @MiddleName
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by CA DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END


		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			JOIN DMVAddr DA ON DA.DMVID = D.ID
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by CA DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	SSN	= @SSN
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by CA DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		
	
	
	END

-- PRINT 'DMV: what is the DMV record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
	BEGIN
		SELECT
		@DMVID	  = 0,
		@DMVDonor = 0,
		@DMVDate  = '1/1/1900'
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END

GO



GO
