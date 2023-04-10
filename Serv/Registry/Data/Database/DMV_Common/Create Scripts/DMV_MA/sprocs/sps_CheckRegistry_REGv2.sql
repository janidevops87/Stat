
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPS_CheckRegistry_REGv2]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[SPS_CheckRegistry_REGv2]
	PRINT 'Dropping Procedure: SPS_CheckRegistry_REGv2'
END
PRINT 'Creating Procedure: SPS_CheckRegistry_REGv2'

GO

CREATE Procedure [dbo].[SPS_CheckRegistry_REGv2]
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

/******************************************************************************
**		File: SPS_CheckRegistry_REGv2.sql
**		Name: SPS_CheckRegistry_REGv2
**		Desc: NEOB Registry MA
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
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/27/2008	ccarroll	Changed DonorConfirmed to allow Null value for Event Tracking
**		01/24/2014	ccarroll	Changed Registry location to DMV_Common	
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
SET NOCOUNT ON;

DECLARE @RegistryOwnerId int = 1, --NEOB 
		@RegistryState nvarchar(10) = 'MA'; -- Web Donor State 

print 'loc'
print @loc
	if  isnull(@loc,'') <>  ''
		Begin
		print 'enter'
		SELECT  --TOP 1
			@REGID = r.RegistryID ,
			@REGDonor = r.Donor ,
			@REGDate =  r.LastModified

		FROM DMV_Common.dbo.Registry r
		WHERE	r.RegistryID = @loc --DOB		= @DOB			
		AND	r.FirstName       = @FirstName			
		AND	r.LastName	= @LastName		 			
		--AND   (IsNull(DonorConfirmed, 0)	  = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')
		ORDER BY r.LastModified DESC;


		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount;
	return
	end

	-- get values for REG
	IF	coalesce(@MiddleName, '') +  
		coalesce(@SSN, '') +
		coalesce(@LICENSE, '') +
		coalesce(@StreetAddress, '') +
		coalesce(@City, '') +		
		coalesce(@Zip, '') = '' 
	BEGIN	
-- PRINT 'REG: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@REGID = r.RegistryID ,
			@REGDonor = r.Donor ,
			@REGDate = CASE 
					WHEN r.SignatureDate IS NULL THEN 
					CASE WHEN r.OnlineRegDate IS NULL THEN r.CreateDate ELSE r.OnlineRegDate End
			      		ELSE r.SignatureDate END
		FROM DMV_Common.dbo.Registry r
		JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryId = ra.RegistryId
		WHERE r.RegistryOwnerID = @RegistryOwnerId
		AND r.DeleteFlag = 0
		AND ra.[State] = @RegistryState
		AND	DOB	= @DOB			
		AND	r.FirstName = @FirstName			
		AND	r.LastName	= @LastName		 			
		AND   (coalesce(r.DonorConfirmed, 0)	  = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')
		ORDER BY r.LastModified DESC;

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
		
		-- Note: No record count is used in the registry query. The registry tables could have a duplicate
		---      records of the same person. The registration form allows donors to register as often as they want.
		
	END
	ELSE
	BEGIN
		-- license
		IF coalesce(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'REG: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@REGID = r.RegistryID ,
				@REGDonor = r.Donor ,
				@REGDate = CASE 
					WHEN r.SignatureDate IS NULL THEN 
					CASE WHEN r.OnlineRegDate IS NULL THEN r.CreateDate ELSE r.OnlineRegDate End
			      		ELSE r.SignatureDate END
		FROM DMV_Common.dbo.Registry r
		JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryId = ra.RegistryId
		WHERE r.RegistryOwnerID = @RegistryOwnerId
		AND r.DeleteFlag = 0
		AND ra.[State] = @RegistryState
			AND r.DOB	= @DOB			
			AND	r.FirstName = @FirstName			
			AND	r.LastName	= @LastName								
			AND	r.License	= @LICENSE
			AND	(coalesce(r.DonorConfirmed, 0)	  = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')
			ORDER BY r.LastModified DESC;

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
		
		-- PRINT 'record count before middlename if: ' + coalesce(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF coalesce(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR coalesce(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
			@REGID = r.RegistryID ,
			@REGDonor = r.Donor ,
			@REGDate = CASE 
					WHEN r.SignatureDate IS NULL THEN 
					CASE WHEN r.OnlineRegDate IS NULL THEN r.CreateDate ELSE r.OnlineRegDate End
			      		ELSE r.SignatureDate END
		FROM DMV_Common.dbo.Registry r
		JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryId = ra.RegistryId
		WHERE r.RegistryOwnerID = @RegistryOwnerId
		AND r.DeleteFlag = 0
		AND ra.[State] = @RegistryState
			AND r.DOB	= @DOB			
			AND	r.FirstName  = @FirstName			
			AND	r.MiddleName = @MiddleName	
			AND	r.LastName	= @LastName		
			AND	(coalesce(r.DonorConfirmed, 0)	  = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')
			ORDER BY r.LastModified DESC;

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount;

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		
		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF coalesce(@StreetAddress, '') + coalesce(@State, '') + coalesce(@Zip, '') <> '' AND (@RecordsReturned > 1 OR coalesce(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@REGID = r.RegistryID ,
				@REGDonor = r.Donor ,
				@REGDate = CASE 
						WHEN r.SignatureDate IS NULL THEN 
						CASE WHEN r.OnlineRegDate IS NULL THEN r.CreateDate ELSE r.OnlineRegDate End
			      			ELSE r.SignatureDate END
			FROM DMV_Common.dbo.Registry r
			JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryId = ra.RegistryId
			WHERE r.RegistryOwnerID = @RegistryOwnerId
			AND r.DeleteFlag = 0
			AND ra.[State] = @RegistryState
			AND r.DOB	= @DOB			
			AND	r.FirstName       = @FirstName			
			AND	r.LastName	= @LastName		
			AND   	(coalesce(r.DonorConfirmed, 0)	  = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')			
			AND   	(LEFT(ra.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR coalesce(@StreetAddress, '')='')
			AND   	(ra.State		  = @State	OR coalesce(@State, 	'')='')
			AND   	(LEFT(ra.Zip, 5)	  = LEFT(@Zip, 5)
								OR coalesce(@Zip	, 	'')='')
			ORDER BY r.LastModified DESC;

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount;		
			
			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
	
		END
		
		-- SSN
		IF coalesce(@SSN, '') <> '' AND (@RecordsReturned > 1 OR coalesce(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH SSN: ' + @SSN
		SELECT  --TOP 1
			@REGID = r.RegistryID ,
			@REGDonor = r.Donor ,
			@REGDate = CASE 
					WHEN r.SignatureDate IS NULL THEN 
					CASE WHEN r.OnlineRegDate IS NULL THEN r.CreateDate ELSE r.OnlineRegDate End
			      		ELSE r.SignatureDate END
		FROM DMV_Common.dbo.Registry r
		JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryId = ra.RegistryId
		WHERE r.RegistryOwnerID = @RegistryOwnerId
		AND r.DeleteFlag = 0
		AND ra.[State] = @RegistryState
		AND	r.SSN	= @SSN
			AND   	(coalesce(r.DonorConfirmed, 0) = @DonorConfirmed OR coalesce(@DonorConfirmed, 	'')='')	
			ORDER BY r.LastModified DESC;

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount;		

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
	END

-- PRINT 'REG: what is the REG record count: ' + coalesce(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF coalesce(@RecordsReturned,0) = 0
	BEGIN
		SELECT
		@REGID	  = 0,
		@REGDonor = 0,
		@REGDate  = '1/1/1900';
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END

GO


