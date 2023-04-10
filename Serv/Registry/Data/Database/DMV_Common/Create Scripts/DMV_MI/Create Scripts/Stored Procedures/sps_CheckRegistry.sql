
CREATE Procedure sps_CheckRegistryv2
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
	@Zip 		VARCHAR(10) 	= NULL,
	@loc		int	= null,
	@Found 	varchar(25) = NULL
AS

SET NOCOUNT ON


--print '@loc ' + Cast(Isnull(@loc, '') as varchar)
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
	if  @Found = 'Web'  or isnull(@Found,'') = '' 
	     Begin
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
		@REGRecordsReturned OUTPUT
	     End
		--print @RegistryID
		--print @RegistryDonor
		--print 'regrecordsreturned'
		--print @REGRecordsReturned
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	--print @loc

-- check for multiple records from registry 
-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
-- loc is a locator field for the registry
	IF 	@REGRecordsReturned >= 1  and  isnull(@loc,'') =  ''
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
			print 'entered registration undertermined'
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'U' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN
		END
	ELSE IF @REGRecordsReturned >= 1 
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
/*
PRINT '@NADD ' + Cast(Isnull(@NADD, '') as varchar)
PRINT '@MiddleName ' + Cast(Isnull(@MiddleName, '') as varchar)
PRINT '@SSN ' + Cast(Isnull(@SSN, '') as varchar)
PRINT '@LICENSE ' + Cast(Isnull(@LICENSE, '') as varchar)
PRINT '@StreetAddress ' + Cast(Isnull(@StreetAddress, '') as varchar)
PRINT '@City ' + Cast(Isnull(@City, '') as varchar)
PRINT '@State ' + Cast(Isnull(@State, '') as varchar)
PRINT '@Zip ' + Cast(Isnull(@Zip, '') as varchar)
*/
			print 'CCCC entered registration undertermined'
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
	print @loc


	if  @Found = 'State'  or isnull(@Found,'') = '' 
	     Begin
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
		@DMVRecordsReturned OUTPUT
	  end
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	--loc is a locator field for registry
	IF 	@DMVRecordsReturned >= 1 and  isnull(@loc,'') =  ''
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
		--print 'entered registration undertermined'
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' as 'Organization',
		@REGRecordsReturned as 'RecordsReturned'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned >= 1 
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
			--print 'entered registration undertermined'

			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
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
	--pRINT @OnlineDonor 

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
				'R' as 'Organization',
				@REGRecordsReturned as 'RecordsReturned'
				
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
						--print ('Registry')
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
						--print('DMV')
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
						@RestrictionID AS 'RestrictionID',
						'R' as 'Organization',
						@REGRecordsReturned as 'RecordsReturned'

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
