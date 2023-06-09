SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMV    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMV]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_DMV]
GO







CREATE Procedure SPS_CheckRegistry_DMV
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
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the DMV table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/

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
		WHERE	FirstName         = @FirstName
		AND	LastName          = @LastName		 
		AND	DOB		  = @DOB					
		
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
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			
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
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
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
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
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
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

