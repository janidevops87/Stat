IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'dbo.sps_CheckRegistry_NEOB')
	BEGIN
		PRINT 'Dropping Procedure dbo.sps_CheckRegistry_NEOB'
		DROP  Procedure  dbo.sps_CheckRegistry_NEOB
	END

GO

PRINT 'Creating Procedure dbo.sps_CheckRegistry_NEOB'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


/****** Object:  Stored Procedure dbo.sps_CheckRegistry_NEOB    Script Date: 1/11/2008 10:59:14 AM ******/


CREATE  Procedure sps_CheckRegistry_NEOB
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
/* ccarroll 09/20/2006 - Similar to sps_CheckRegistry
 adapted to search NEOB registry using sps_CheckRegistryDMVNEOB
   
 Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

SP_HELP DMV 

	DECLARE VARIABLES*/
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT,
		@DMVSource VARCHAR(10)

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
		1,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records


  check for multiple records from registry 
  IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION */

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
/*  ccarroll 09/20/2006 - added call to check all NEOB databases*/	
	EXEC sps_CheckRegistry_DMVNEOB	
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
		@DMVRecordsReturned OUTPUT,
		@DMVSource OUTPUT
	
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
						--ccarroll 08/23/2006 - Pass DMV ID back as source
						@DMVSource AS 'Source',
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
								--ccarroll 08/23/2006 - Pass DMV ID back as source
								@DMVSource AS 'Source',
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





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

