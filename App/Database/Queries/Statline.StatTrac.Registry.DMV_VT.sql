PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:12/28/2011 1:46:05 PM-- -- --  
-- D:\Projects\Statline\Registry\Data/Database/DMV_Common/Create Scripts/DMV_VT/sprocs/spi_IMPORT_ImportApply_A.sql
-- D:\Projects\Statline\Registry\Data/Database/DMV_Common/Create Scripts/DMV_VT/sprocs/sps_CheckRegistry_RegLoad.sql
-- D:\Projects\Statline\Registry\Data/Database/DMV_Common/Create Scripts/DMV_VT/sprocs/sps_CheckRegistry_REGv2.sql
-- D:\Projects\Statline\Registry\Data/Database/DMV_Common/Create Scripts/DMV_VT/sprocs/sps_CheckRegistryv2.sql

PRINT 'D:\Projects\Statline\Registry\Data\Database\DMV_Common\Create Scripts\DMV_VT\sprocs\spi_IMPORT_ImportApply_A.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_IMPORT_ImportApply_A]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_A]
	PRINT 'Dropping Procedure: spi_IMPORT_ImportApply_A'
END
	PRINT 'Creating Procedure: spi_IMPORT_ImportApply_A'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[spi_IMPORT_ImportApply_A] AS
/******************************************************************************
**		File: spi_IMPORT_ImportApply_A.sql
**		Name: spi_IMPORT_ImportApply_A
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 12/28/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		12/28/2011	ccarroll	initial
*******************************************************************************/
update IMPORT
set DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
from IMPORT i, IMPORT_A a
where i.LICENSE = a.LICENSE
insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LICENSE NOT IN (select LICENSE
                      from IMPORT)


--Update the Import table with PreviousDonorState
UPDATE
	Import
SET 
	Import.PreviousDonorState = DMV.Donor
FROM 
	DMV
WHERE 
	DMV.License = Import.License





GO



GO
PRINT 'D:\Projects\Statline\Registry\Data\Database\DMV_Common\Create Scripts\DMV_VT\sprocs\sps_CheckRegistry_RegLoad.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistry_RegLoad]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_CheckRegistry_RegLoad]
	PRINT 'Dropping Procedure: sps_CheckRegistry_RegLoad'
END
	PRINT 'Creating Procedure: sps_CheckRegistry_RegLoad'
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistry_RegLoad]
(
	@DOB   varchar(255)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc int = null
)
/******************************************************************************
**		File: sps_CheckRegistry_RegLoad.sql
**		Name: sps_CheckRegistry_RegLoad
**		Desc:  NEOB Registry VT
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 11/01/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		11/10/2011	ccarroll	initial
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
SET NOCOUNT ON

	SELECT 
			Registry.FirstName,
			Registry.MiddleName,
			Registry.Lastname,
			Registry.License,
			RegistryAddr.Addr1,
			RegistryAddr.City,
			RegistryAddr.State,
			RegistryAddr.Zip,
			Registry.LastModified AS  SearchDate,
			Registry.RegistryID AS loc
	FROM
			DMV_Common.dbo.Registry AS Registry
	JOIN	DMV_Common.dbo.registryAddr AS RegistryAddr On registry.RegistryID = registryAddr.RegistryID

	WHERE	Registry.DOB = @DOB AND
			Registry.FirstName = IsNull(@FirstName, Registry.FirstName) AND
			Registry.LastName = IsNull(@LastName, Registry.LastName) AND
			Registry.MiddleName = IsNull(@MiddleName, Registry.MiddleName) AND
			IsNull(Registry.License, '') = IsNull(@License, '') AND
			RegistryAddr.Addr1 = IsNull(Replace(@StreetAddress, '*', '%'), RegistryAddr.Addr1) AND		
			RegistryAddr.City = IsNull(Replace(@City, '*', '%'), RegistryAddr.City) AND		
			RegistryAddr.State = 'VT' AND
			RegistryAddr.Zip = IsNull(@Zip, RegistryAddr.Zip)

	ORDER BY
			Registry.MiddleName,
			RegistryAddr.Zip,
			RegistryAddr.City,
			RegistryAddr.Addr1
	DESC

GO
PRINT 'D:\Projects\Statline\Registry\Data\Database\DMV_Common\Create Scripts\DMV_VT\sprocs\sps_CheckRegistry_REGv2.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistry_REGv2]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_CheckRegistry_REGv2]
	PRINT 'Dropping Procedure: sps_CheckRegistry_REGv2'
END
	PRINT 'Creating Procedure: sps_CheckRegistry_REGv2'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sps_CheckRegistry_REGv2]
(
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = Null,
	@Zip VARCHAR(10) = NULL,
	@loc int = NULL,
	@DonorConfirmed BIT = NULL,
	@REGID INT OUTPUT,
	@REGDonor BIT OUTPUT,
	@REGDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 
)
/******************************************************************************
**		File: sps_CheckRegistry_REGv2.sql
**		Name: sps_CheckRegistry_REGv2
**		Desc:  NEOB Registry VT
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 05/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/11/2009	ccarroll	initial - 
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SET NOCOUNT ON

print 'loc'
print @loc
	if  isnull(@loc,'') <>  ''
		Begin
		print 'enter'
		SELECT  --TOP 1
			@REGID = D.RegistryID ,
			@REGDonor = D.Donor ,
			@REGDate =  D.LastModified

		FROM DMV_Common.dbo.Registry D
		JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID
		WHERE	d.RegistryID = @loc --DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName

		/* Limit search to NEOB(1) owner */
		AND RegistryOwnerID = 1
		AND DA.State = 'VT'
		 			
		--AND   (DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY D.LastModified DESC


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
			@REGID = D.RegistryID ,
			@REGDonor = D.Donor ,
			@REGDate = CASE 
					WHEN SignatureDate IS NULL THEN 
					CASE WHEN OnlineRegDate IS NULL THEN D.CreateDate ELSE OnlineRegDate End
			      		ELSE SignatureDate END
		FROM DMV_Common.dbo.Registry D
		LEFT JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID

		WHERE	DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName

		/* Limit search to NEOB(1) owner */
		AND RegistryOwnerID = 1
		AND DA.State = 'VT'
		 			
		AND   (DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY D.LastModified DESC

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
				@REGID = D.RegistryID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN D.CreateDate ELSE OnlineRegDate End
			     	 		ELSE SignatureDate END
			FROM 	DMV_Common.dbo.Registry D
			JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID

			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName								

			/* Limit search to NEOB(1) owner */
			AND RegistryOwnerID = 1
			AND DA.State = 'VT'

			AND	License		= @LICENSE
			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY D.LastModified DESC

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
				@REGID = D.RegistryID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN D.CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM 	DMV_Common.dbo.Registry D
			JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID

			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	MiddleName	= @MiddleName	
			AND	LastName	= @LastName		

			/* Limit search to NEOB(1) owner */
			AND RegistryOwnerID = 1
			AND DA.State = 'VT'	

			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY D.LastModified DESC

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
				@REGID = D.RegistryID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN D.SignatureDate IS NULL THEN 
						CASE WHEN D.OnlineRegDate IS NULL THEN D.CreateDate ELSE D.OnlineRegDate End
			      			ELSE D.SignatureDate END
			FROM DMV_Common.dbo.Registry D
			JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName		

			/* Limit search to NEOB(1) owner */
			AND RegistryOwnerID = 1
			AND DA.State = 'VT'

			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			ORDER BY D.LastModified DESC

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
				@REGID = D.RegistryID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN D.CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM DMV_Common.dbo.Registry D
			JOIN DMV_Common.dbo.RegistryAddr DA ON DA.RegistryID = D.RegistryID

			WHERE	SSN	= @SSN

			/* Limit search to NEOB(1) owner */
			AND RegistryOwnerID = 1
			AND DA.State = 'VT'

			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')	
			ORDER BY D.LastModified DESC

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
PRINT 'D:\Projects\Statline\Registry\Data\Database\DMV_Common\Create Scripts\DMV_VT\sprocs\sps_CheckRegistryv2.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistryv2]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[sps_CheckRegistryv2]
	PRINT 'Dropping Procedure: sps_CheckRegistryv2'
END
	PRINT 'Creating Procedure: sps_CheckRegistryv2'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistryv2]
(
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
	@Found Varchar(25) = NULL
)
/******************************************************************************
**		File: sps_CheckRegistryv2.sql
**		Name: sps_CheckRegistryv2
**		Desc:  NEOB Registry
**		Paramameters
**			See above
**
**		Called by:  
**              
**		Auth: ccarroll
**		Date: 05/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/11/2009	ccarroll	initial - 
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
SET NOCOUNT ON
print @loc

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
		--print @REGRecordsReturned
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	print @loc
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
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
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
	       End
	
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
		'R' as 'Organization',
		@DMVRecordsReturned as 'RecordsReturned'
		
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
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@DMVRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
		

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
						print ('Registry')
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
						print('DMV')
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

 
GO
