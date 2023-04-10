PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:10/13/2011 3:11:00 PM-- -- --  
-- $/StatTrac/Statline/Registry/Data/Database/DMV_Common/Create Scripts/DMV_CO/sprocs/sps_checkregistry_DMVLoad.sql
-- $/StatTrac/Statline/Registry/Data/Database/DMV_Common/Create Scripts/DMV_CO/sprocs/SPS_CheckRegistry_DMVv2.sql

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_checkregistry_DMVLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_checkregistry_DMVLoad'
	drop procedure [dbo].[sps_checkregistry_DMVLoad]
END
GO
PRINT 'Creating Procedure sps_checkregistry_DMVLoad'
GO


/****** Object:  StoredProcedure [dbo].[sps_checkregistry_DMVLoad]    Script Date: 10/11/2011 11:14:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sps_checkregistry_DMVLoad]
 
	@DOB   varchar(25)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL, 
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc  int = null
	
AS
/******************************************************************************
**		File: 
**		Name: sps_CheckRegistry_DMVLoad
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   FrmDonorData
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			Added FirstName, and LastName to select
**    10/11/2011	ccarroll			Added check for blank addresses CCRST164
**	  10/12/2011	ccarroll			Added LEFT JOIN on Address HS29072, wi:13150
*******************************************************************************/
SET NOCOUNT ON
	declare
		@RecordsReturned int,
		@strproc	varchar(8000)
				set @strproc =  'Select DMV.FirstName, DMV.MiddleName, DMV.LastName, Dmv.License as  License, '	
				set @strproc = @strproc + 'DMVAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'DMVAddr.city as   City, '
				set @strproc = @strproc   + 'DMVAddr.State as  State, '
				set @strproc = @strproc   + 'DMVAddr.zip as  Zip, '
				
				set @strproc = @strproc   + 'DMV.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'DMV.ID as Loc'
			
				
				set @strproc = @strproc   +  ' FROM DMV LEFT JOIN DMVAddr On DMV.ID = DMVAddr.Dmvid '
				set @strproc = @strproc   +   ' WHERE	DMV.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				set @strproc = @strproc   +   ' IsNull(DMVAddr.ZIP,''-'') <> ''0'' AND' 
				--set @strproc = @strproc   +  'AND	'
				If  @MiddleName is not null
					Begin
						Set @strproc = @strproc + ' dmv.middleName = ' + "'" + @MiddleName + "'" +  ' And '
					End
				If  @License is not null
					Begin
						Set @strproc = @strproc + ' dmv.License = ' + "'" + @License + "'" +  ' And '
					End
				If  @StreetAddress is not null
					Begin
						if Left(@StreetAddress,1) = '*' or Right(@StreetAddress,1)  = '*'
							Begin
								set @StreetAddress = REPLACE(@StreetAddress,'*','%');
								Set @strproc = @strproc + '  DMVAddr.Addr1  like ' + "'" + @StreetAddress + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
							end
					End
				If  @City is not null
					Begin
						if Left(@City,1) = '*' or Right(@City,1)  = '*'
							Begin
								set @City = REPLACE(@City,'*','%');
								Set @strproc = @strproc + '  DMVAddr.City like ' + "'" + @City + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.City = ' + "'" + @City + "'" +  ' And '
							end
					End
				If  @State is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.State = ' + "'" + @State+ "'" +  ' And '
					End
				If  @Zip is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.Zip = ' + "'" + @Zip + "'" +  ' And '
					End
				set @strproc = @strproc   +   ' dmv.FirstName           = '  +  "'" + @FirstName + "'"
				set @strproc = @strproc    + ' AND	dmv.LastName             = ' + "'" + @LastName	+"'" 
				set @strproc = @strproc   +  ' ORDER BY dmv.middleName,DMVAddr.Zip,DMVAddr.City,DMVAddr.Addr1 '


print @strproc
exec(@strproc)

GO




SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVv2    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMVv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure SPS_CheckRegistry_DMVv2'
	drop procedure [dbo].[SPS_CheckRegistry_DMVv2]
END
GO
PRINT 'Creating Procedure SPS_CheckRegistry_DMVv2'
GO




CREATE Procedure SPS_CheckRegistry_DMVv2
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
/******************************************************************************
**		File: 
**		Name: SPS_CheckRegistry_DMVv2
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   sps_CheckRegistryv2
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		08/16/2011	ccarroll			Add JOIN to DMVADDR StatTrac DMV:CO HS:29072, wi:13150 Reg match displays for No Donor
**		10/11/2011	ccarroll			Removed join - caused issues - hot fix CCRST164
*******************************************************************************/
SET NOCOUNT ON

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
				AND	FirstName           = @FirstName
				AND	LastName             = @LastName		 
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
		--ccarroll 08/16/2011 Add JOIN to DMVADDR StatTrac DMV:CO HS:29072, wi:13150 Reg match displays for No Donor
		--ccarroll 10/11/2011 Removed join - caused issues hot fix CCRST164
		--JOIN DMVADDR ON D.ID = DMVADDR.DMVID AND DMVADDR.AddrTypeID = 1
		WHERE	FirstName         = @FirstName
		AND	LastName          = @LastName		 
		AND	DOB		  = @DOB
		
		ORDER BY D.LastModified DESC

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

