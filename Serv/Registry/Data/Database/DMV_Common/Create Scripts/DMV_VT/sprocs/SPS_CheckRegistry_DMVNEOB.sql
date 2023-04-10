 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'SPS_CheckRegistry_DMVNEOB')
	BEGIN
		PRINT 'Dropping Procedure SPS_CheckRegistry_DMVNEOB'
		DROP  Procedure  SPS_CheckRegistry_DMVNEOB
	END

GO

PRINT 'Creating Procedure SPS_CheckRegistry_DMVNEOB'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVNEOB    Script Date: 1/11/2008 10:59:12 AM ******/

CREATE       Procedure SPS_CheckRegistry_DMVNEOB
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
	@DMVID INT OUTPUT,
	@DMVDonor BIT OUTPUT,
	@DMVDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT,
	@DMVSource VARCHAR(10) OUTPUT

AS
SET NOCOUNT ON
/******************************************************************************
**		File: sps_EventCategory.sql
**		Name: sps_EventCategory
**		Desc: 
**		This stored procedure is called by sps_CheckRegistry_NEOB to query 
**		DMV tables in the NEOB domain and return the resulting DMVSource. For 
**		example, 'DMV_CT'. The DMVsource is then used to dispay the correct Verification
**		sheet.
**
**		The donor verification Sheets are prefixed with the DMVSource and are stored in a
**		virtual directory on the web server ('NEOB_Verification') For Example:
**		/NEOB_Verification/DMV_CT_qryVerificationSheet.sls
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll						12/04/2007
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     		01/21/2008		ccarroll				Initial
**			06/02/2009		ccarroll				added VT
*******************************************************************************/

	-- get values for dmv
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN
	
-- PRINT 'DMV: QUERY WITH DOB, LAST AND FIRST'

SELECT 	@DMVID = ID,
	@DMVDonor = Donor,
	@DMVDate = DMVDate,
	@DMVSource = DMVSource 

FROM
		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_RI.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName

		FROM DMV_CT.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_MA.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName


	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_ME.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_NH' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_NH.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName
		
	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_VT.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	)d

		-- get the number of records returned
		SET @RecordsReturned = @@RowCount

		-- PRINT @RecordsReturned

		-- if records returned is greater than 0 then clear the variables
		-- Note: record count is only done in DMV query. DMV Should never have a duplicate
		-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
		IF @RecordsReturned > 1 
		BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
		END

	END

	ELSE
	BEGIN

		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN


-- PRINT 'DMV: QUERY WITH LICENSE: ' + @LICENSE
	SELECT 	@DMVID = ID,
		@DMVDonor = Donor,
		@DMVDate = DMVDate,
		@DMVSource = DMVSource 
	FROM

		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License
		FROM DMV_RI.dbo.DMV		
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_CT.dbo.DMV		
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_MA.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_ME.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_NH' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License
		FROM DMV_NH.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName
		
	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License
		FROM DMV_VT.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName
	)d


			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount
			
			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
			END
		
		END
		
-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH MIDDLENAME: ' + @MiddleName
	SELECT 	@DMVID = ID,
		@DMVDonor = Donor,
		@DMVDate = DMVDate,
		@DMVSource = DMVSource 
	FROM

		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_RI.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_CT.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_MA.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_ME.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_NH' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_NH.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName
		FROM DMV_VT.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName
	)d

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
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
			WHERE	DOB		  = @DOB
			AND	FirstName         = @FirstName
			AND	LastName          = @LastName
			AND   (LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   (DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   (LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
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
			WHERE	SSN	= @SSN
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
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
		@DMVDate  = '1/1/1900',
		@DMVSource = ''
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

