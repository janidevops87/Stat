SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistry    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CheckRegistry]
GO









CREATE Procedure sps_CheckRegistry
	@DOB   		DATETIME    	= NULL,
	@LastName	VARCHAR(25) 	= NULL,
	@FirstName 	VARCHAR(25) 	= NULL,
	@NADD 		INT	       	= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   		VARCHAR(11) 	= NULL,
	@LICENSE 	VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 		VARCHAR(25) 	= NULL,
	@State 		VARCHAR(2) 	= NULL,
	@Zip 		VARCHAR(10) 	= NULL
AS

SET NOCOUNT ON
/*

Desigened AND Developed 01/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

-- SP_HELP DMV
*/
	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0 

	-- get values for registry 
	EXEC sps_CheckRegistry_REG
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
		NULL,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	
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
			0 AS 'RestrictionID'
		
			RETURN
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
			0 AS 'RestrictionID'
		
			RETURN		
		END
	
	EXEC sps_CheckRegistry_DMV	
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
		@DMVID OUTPUT,
		@DMVDonor OUTPUT,
		@DMVDate OUTPUT,
		@DMVRecordsReturned OUTPUT
	
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
		0 AS 'RestrictionID'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/23/03 
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
			0 AS 'RestrictionID'
		
			RETURN		
		END
		

	/*

		SELECT  D.ID ,
			D.Donor ,
			CASE WHEN D.RENEWALDATE IS NULL THEN 
					CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
			     ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE LastName           = 'knoll'
		AND   FirstName          = 'bret'
		AND   DOB		  = '11/17/1970'

	*/

	--PRINT @DMVDonor
	--PRINT @RegistryDonor 
	--PRINT @OnlineDonor 

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
				0 AS 'RestrictionID'
				
				RETURN

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
						AS 'RestrictionID'
					RETURN				
				END		
			-- check if dmv is the latest date	
			ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
				-- Return DMV
				BEGIN
					SELECT
						'DMV' AS 'Source',
						@DMVID AS 'ID',
						CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@DMVDate AS 'Date',
						CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
					RETURN
				END
			-- check if all the values are not = N for No
			-- Both registry and dmv dates are equal, check that both = Y
			ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
				BEGIN
					-- if registry is not null return registry
					IF (@RegistryID IS NOT NULL)
						BEGIN
							SELECT
								'Registry' AS 'Source',
								@RegistryID AS 'ID',
								CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@RegistryDate AS 'Date'	,
								@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
								AS 'RestrictionID'
							RETURN								
						END
					ELSE 
						BEGIN 
							SELECT
								'DMV' AS 'Source',
								@DMVID AS 'ID',
								CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@DMVDate AS 'Date',
								CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
							RETURN
						
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
						@RestrictionID AS 'RestrictionID'

						RETURN
				END			
		END




/* Query Sample
SELECT * 
FROM DMV
WHERE (LastName           LIKE 'Knoll'   or ISNULL('Knoll',   '')='')
AND   (FirstName          LIKE 'Bret'  or ISNULL('Bret',  '')='')
AND   (MiddleName         LIKE 'James' or ISNULL('JAMES', '')='')
AND   (License            LIKE '921243832'    or ISNULL('921243832',    '')='')
AND   (DOB		  LIKE '1970-11-17'	   OR ISNULL('1970-11-17', 	  '')='')
AND   (SSN	          LIKE '521471351' 	   OR ISNULL('521471351',	  '')='')

*/
-- SELECT COUNT(DONOR) FROM DMV WHERE DONOR = 1













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

