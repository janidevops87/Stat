IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'SPS_CheckRegistry_REGv2')
	BEGIN
		PRINT 'Dropping Procedure SPS_CheckRegistry_REGv2'
		DROP  Procedure  SPS_CheckRegistry_REGv2
	END

GO

PRINT 'Creating Procedure SPS_CheckRegistry_REGv2'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure SPS_CheckRegistry_REGv2
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
	@DonorConfirmed BIT = NULL,
	@REGID INT OUTPUT,
	@REGDonor BIT OUTPUT,
	@REGDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/******************************************************************************
**		File: SPS_CheckRegistry_REGv2.sql
**		Name: SPS_CheckRegistry_REGv2
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
**		See above
**
**		Auth: unknown
**		Date: 01/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		03/27/2008		ccarroll				Changed DonorConfirmed to allow Null value for Event Tracking
*******************************************************************************/
print 'loc'
print @loc
	if  isnull(@loc,'') <>  ''
		Begin
		print 'enter'
		SELECT  --TOP 1
			@REGID = D.ID ,
			@REGDonor = D.Donor ,
			@REGDate =  D.LastModified

		FROM Registry D
		WHERE	d.id = @loc --DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName		 			
		--AND   (IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY LASTMODIFIED DESC


		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
	return
	end

	-- get values for REG
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'REG: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@REGID = D.ID ,
			@REGDonor = D.Donor ,
			@REGDate = CASE 
					WHEN SignatureDate IS NULL THEN 
					CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      		ELSE SignatureDate END
		FROM Registry D
		WHERE	DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName		 			
		AND   (IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
		
		-- Note: No record count is used in the registry query. The registry tables could have a duplicate
		---      records of the same person. The registration form allows donors to register as often as they want.
		
	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'REG: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			     	 		ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName								
			AND	License		= @LICENSE
			AND	(IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	MiddleName	= @MiddleName	
			AND	LastName	= @LastName		
			AND	(IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		
		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN D.SignatureDate IS NULL THEN 
						CASE WHEN D.OnlineRegDate IS NULL THEN D.CreateDate ELSE D.OnlineRegDate End
			      			ELSE D.SignatureDate END
			FROM Registry D
			JOIN RegistryAddr DA ON DA.RegistryID = D.ID
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName		
			AND   	(IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		
			
			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM Registry D
			WHERE	SSN	= @SSN
			AND   	(IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')	
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
	END

-- PRINT 'REG: what is the REG record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF ISNULL(@RecordsReturned,0) = 0
	BEGIN
		SELECT
		@REGID	  = 0,
		@REGDonor = 0,
		@REGDate  = '1/1/1900'
		
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

