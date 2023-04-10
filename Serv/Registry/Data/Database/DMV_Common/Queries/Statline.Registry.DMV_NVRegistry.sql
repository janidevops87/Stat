PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/9/2017 8:07:06 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\GetDMVRegistrySearchResults_select.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\spf_CreateDMVTempTable.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\spf_Reseed_DMVTempTable.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeByStatus.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeByZipCode.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeCountsEvent.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistry_DMVLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistry_RegLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistryv2.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_IMPORT_All_ImportDonor.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\GetDMVRegistrySearchResults_select.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDMVRegistrySearchResults_select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDMVRegistrySearchResults_select]
	PRINT 'Dropping Procedure: GetDMVRegistrySearchResults_select'
END
	PRINT 'Creating Procedure: GetDMVRegistrySearchResults_select'
GO

CREATE PROCEDURE [dbo].[GetDMVRegistrySearchResults_select]
	@FirstName varchar(40) = NULL,
	@MiddleName varchar(40) = NULL,
	@LastName varchar(40) = NULL,
	@City varchar(40) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(40) = NULL,
	@License  varchar(10) = NULL,/* May also be State ID */
	@DOB	datetime = NULL,
	@DisplayDMVDonorsYesOnly bit = Null
AS
/******************************************************************************
**		File: GetDMVRegistrySearchResults_select.sql
**		Name: GetDMVRegistrySearchResults_select
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll	
**		Date: 02/27/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		02/27/2009		ccarroll				initial release
**		09/25/2009		ccarroll				added LEFT statements for temp table limitations
**		01/11/2011		ccarroll				Bug Fix for wi-9231, HS-25889 added RegistrySearchResultSourceState
**		08/05/2013		ccarroll				Added RegistrySearchResultDonorActivityDate for sorting
**		03/05/2014		Moonray Schepart		Added filter for CSORLICENSE on License match.
**		08/07/2014		Moonray Schepart		Inclusion of Display Name fields (CCRST196)
**		01/14/2016		Andriy Mazur    		Refactor Zip filter to use widechar.
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

DECLARE @Donor bit;

IF coalesce(@DisplayDMVDonorsYesOnly, 0) = 1
BEGIN
	SET @Donor = 1
END

SELECT  DISTINCT
		'DMV'AS 'RegistrySearchResultSourceName',
		Null AS 'RegistrySearchResultSourceState',
		DMV.ID AS 'RegistrySearchResultSourceID',
		LEFT(COALESCE(DMV.FirstName_Display,DMV.FirstName), 20) AS 'RegistrySearchResultFirstName',
		LEFT(COALESCE(DMV.MiddleName_Display, DMV.MiddleName), 20) AS 'RegistrySearchResultMiddleName',
		LEFT(COALESCE(DMV.LastName_Display,DMV.LastName), 25) AS 'RegistrySearchResultLastName',
		''AS 'RegistrySearchResultVerificationForm', --RegistryOwnerState.RegistryOwnerStateVerificationForm AS 'RegistrySearchResultVerificationForm',
		Convert(varchar, DMV.DOB, 101) AS 'RegistrySearchResultDOB',
		LEFT(DMV.License, 10) AS 'RegistrySearchResultSID',
		LEFT(DMVAddr.Addr1, 40) AS 'RegistrySearchResultAddress',
		LEFT(DMVAddr.City, 25) AS 'RegistrySearchResultCity',
		LEFT(DMVAddr.State, 2) AS 'RegistrySearchResultState',
		LEFT(DMVAddr.Zip, 10) AS 'RegistrySearchResultZip',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN 'Original Date: ' + CONVERT(varchar, DMV.CreateDate, 101) 
				ELSE 'Renewal Date: ' + CONVERT(varchar, DMV.RenewalDate, 101) END AS 'RegistrySearchResultDonorDate',
		CASE WHEN DMV.RenewalDate Is Null 
			 THEN DMV.CreateDate
				ELSE DMV.RenewalDate END AS 'RegistrySearchResultDonorActivityDate',
		CASE WHEN coalesce(DMV.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorStatus',
		CASE WHEN coalesce(DMV.Donor, 0) = 1 
			 THEN 'Y' 
				ELSE 'N' END AS 'RegistrySearchResultDonorConfirmed'

FROM	DMV
LEFT	JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID AND (DMVAddr.AddrTypeID = 1)	
LEFT	JOIN DMV_Common.dbo.RegistryOwnerStateConfig AS RegistryOwnerState ON RegistryOwnerState.RegistryOwnerStateAbbrv = LEFT(DMVAddr.State,2)

WHERE
	(@Donor IS NULL OR coalesce(DMV.Donor, 0)=@Donor ) AND
	(@DOB IS NULL OR DMV.DOB = @DOB) AND
	(@License IS NULL OR PATINDEX(@License+ '%',  RTRIM(COALESCE(DMV.License, DMV.CSORLICENSE, ''))) > 0) AND
	(@State IS NULL OR LEFT(DMVAddr.State,2) = @State) AND
	(@Zip IS NULL OR PATINDEX(@Zip, DMVAddr.Zip) > 0) AND
	(@FirstName IS NULL OR PATINDEX(@FirstName + '%', DMV.FirstName) > 0) AND
	(@MiddleName IS NULL OR PATINDEX(@MiddleName+ '%', COALESCE(MiddleName,''))  > 0)  AND
	(@LastName IS NULL OR PATINDEX(@LastName+ '%', DMV.LastName) > 0) AND
	(@City IS NULL OR PATINDEX(@City+ '%', DMVAddr.City) > 0)
GO



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\spf_CreateDMVTempTable.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVTempTable'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc:  NV DMV Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 04/07/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/07/2010	ccarroll			initial
**		08/07/2014	Moonray Schepart	Inclusion of Display Name fields (CCRST196)
**		02/26/2016	Bret Knoll			Changed License from a 9 to 20.
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	drop table [dbo].[DMVTempTable]
END
CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL,
	[PreviousDonorState] [varchar] (50) NULL,
	[FirstName_Display] [varchar](255) NULL,
	[MiddleName_Display] [varchar](255) NULL,
	[LastName_Display] [varchar](255) NULL,
) ON [PRIMARY]

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\spf_Reseed_DMVTempTable.sql'
GO
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spf_Reseed_DMVTempTable')
	BEGIN
		PRINT 'Dropping Procedure spf_Reseed_DMVTempTable'
		DROP  Procedure  spf_Reseed_DMVTempTable
	END

GO

PRINT 'Creating Procedure spf_Reseed_DMVTempTable'
GO


CREATE Procedure spf_Reseed_DMVTempTable

AS

/******************************************************************************
**		File: spf_Reseed_DMVTempTable.sql
**		Name: spf_Reseed_DMVTempTable
**		Desc: This sproc is placed after CreateDMVTempTable task and before the 
**		Import task in the Full Import DTS package. This will cause the new DMV
**		data to receive IDs outside the scope of the old data. HS-10508
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		NA
**
**		Auth: ccarroll						01/09/2008
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     01/09/2008		ccarroll				Initial
*******************************************************************************/
DECLARE @OldSeed int
DECLARE @NewSeed int


SET @OldSeed = (select Max(id) from (
				select ISNULL((select max(coalesce(id, 0)) from DMV), 0) id
				union all 
				select ISNULL((select max(coalesce(id, 0)) from DMVARCHIVE), 0) id
				) ud);
SET @NewSeed = (@OldSeed + 1)


DBCC CHECKIDENT (DMVTempTable, RESEED, @NewSeed );


GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeByStatus.sql'
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ActionableDesignationVolumeByStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_ActionableDesignationVolumeByStatus'
	drop procedure [dbo].[sps_ActionableDesignationVolumeByStatus]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_ActionableDesignationVolumeByStatus'
GO

CREATE PROCEDURE sps_ActionableDesignationVolumeByStatus
	@StartDateTime	DATETIME = NULL,
	@EndDateTime	DATETIME = NULL,
	@StateDisplayName varchar(50) = NULL,
	@DMV			Bit = Null,
	@Reg			Bit = Null,
	@Dla			BIT = NULL,
	@ReportFormat   varchar(25) = NULL /* Get Data Options: Determines the granularity returned
										 (1)Standard,
										 (2)Age,
										 (3)Gender,
										 (4)AgeGender
										*/  
AS
/******************************************************************************
**		File: sps_ActionableDesignationVolumeByStatus.sql
**		Name: sps_ActionableDesignationVolumeByStatus
**		Desc: Uses Common registry (NV)
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 04/02/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**      04/04/2008		ccarroll			initial
**		09/08/2010		ccarroll			To improve performance, moved to #TempTable,
**											disabled 'remove duplicate' section and
**											changed to insert and update for registry data
**		01/28/2014		Moonray Schepart	Integrate into Common Registry and Remove State Level Filter
**      12/12/2016		Mike Berenson		Added DLA Registry
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @RegistryOwnerID int = 0;

/*** NDN ***/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM DMV_Common..RegistryOwner WHERE RegistryOwnerName = 'NDN') ;

SELECT
		@StartDateTime = ISNULL(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)

DECLARE @TotalYes int;
DECLARE @StateRegistryCount int;
DECLARE @WebRegistryCount int, 
		@DlaRegistryCount INT;

if (object_id('tempdb..#SelectionTable') is not null)
begin
	drop table #SelectionTable;
end
if (object_id('tempdb..#CountTable') is not null)
begin
	drop table #CountTable;
end

--DECLARE #SelectionTable TABLE
Create Table #SelectionTable
	(	[ID] [int] IDENTITY(1,1) NOT NULL,
		StateDisplayName		varchar(50) Null,
		SourceType				varchar(10)	Null,
		FirstName				varchar(255) Null,
		LastName				varchar(255) Null,
		DOB						datetime Null,
		LastModified			datetime Null, 
		DonorDesignationStatus	varchar(25)	Null,
		AgeRange				varchar(5)	Null,
		Gender					varchar(1)	Null,
		TotalYes				int Null
	);

CREATE TABLE #CountTable 
	(
		StateDisplayName		varchar(50) Null,
		SourceType				varchar(10) Null,
		DonorDesignationStatus	varchar(25)	Null,
		AgeRange				varchar(5)	Null,
		Gender					varchar(1)	Null,
		Number					int Null
	);

If @DMV = 1 
BEGIN
/* Add donor detail for DMV*/

	INSERT #SelectionTable 

		SELECT DISTINCT
			@StateDisplayName AS 'StateDisplayName',
			'DMV' 	AS 'SourceType',
			Firstname AS 'Firstname',
			LastName AS 'LastName',
			DOB AS 'DOB',
			DMV.LastModified AS 'LastModified', 
	
			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorState Is Null AND (Donor = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonorState = 1 AND (Donor = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonorState = 1 AND (Donor = 0) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonorState = 0 AND (Donor = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonorState = 0 AND (Donor = 0) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorState Is Null AND (Donor = 0) -- New No
						THEN 'New No'
					ELSE 'Unknown'
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			/* Total Yes Count */
			CASE WHEN
				(PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1)	OR -- Yes To Yes
				(PreviousDonorState = 0 AND Donor = 1) -- No To Yes
				THEN 1
				ELSE 0
			END AS TotalYes			
			
			
		FROM DMV
		WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified < @EndDateTime);
			/* Only Select ActionableDesignationVolume Items 
			AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
				(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
				(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
				
			*/
END


	
If @Reg = 1
BEGIN
/* Add donor detail for Registry*/
	INSERT #SelectionTable 

		SELECT DISTINCT
			-- Registry.ID AS 'SourceID',
			@StateDisplayName AS 'StateDisplayName',
			'Reg' 	AS 'SourceType',
			Registry.Firstname AS 'Firstname',
			Registry.LastName AS 'LastName',
			Registry.DOB AS 'DOB',
			Registry.LastModified AS 'LastModified', 

			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
						THEN 'New No'
					ELSE 'Unknown'
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Registry.Gender = 'M'
				THEN 'M'
				WHEN Registry.Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			/* Total Yes Count */
			CASE WHEN
				(PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
				(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
				(PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
				THEN 1
				ELSE 0
			END AS TotalYes						
			
			
		FROM DMV_Common..Registry AS Registry
		JOIN DMV_Common..RegistryAddr AS RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID AND (RegistryAddr.AddrTypeID =1)
		/* only insert if person does not exist in previous selection*/
		LEFT JOIN #SelectionTable st ON st.FirstName = Registry.FirstName AND st.LastName = Registry.LastName AND st.DOB = Registry.DOB  
		WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
			AND Registry.RegistryOwnerId = @RegistryOwnerID
			AND DonorConfirmed = 1
			AND Registry.Gender is Not Null  
			AND (st.FirstName IS NULL AND st.LastName IS NULL AND st.DOB IS NULL)

			AND ((PreviousDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
				(PreviousDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
				(PreviousDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
				(PreviousDonor = 0 AND Donor = 1 AND DonorConfirmed = 1));				 -- No To Yes

				
			
END


	
IF @Dla = 1
BEGIN
/* Add donor detail for DLA*/
	INSERT #SelectionTable 

		SELECT DISTINCT
			@StateDisplayName AS 'StateDisplayName',
			'Dla' 	AS 'SourceType',
			FirstName AS 'Firstname',
			LastName,
			DOB,
			LastModified, 

			/* Correlate donor histoy*/
			'Unknown' AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GETDATE()) / 365.25) AS INT) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			/* Total Yes Count */
			Donor AS TotalYes
			
		FROM DMV_Common..RegistryDlaResponseItem 
		WHERE LastModified BETWEEN @StartDateTime AND @EndDateTime
			AND GENDER IS NOT NULL;				
			
END


	--Debug SELECT * FROM #SelectionTable

/* Remove duplicates 
	uses dervied Right to Left table comparision to 
	find duplicates in (#SelectionTable) and then removes them
	by deleting duplicates which do not have the most
	current (LastModified) date.
	Duplicates are based on the following criteria:
		- FirstName
		- LastName
		- DOB
--*/

IF (CAST(COALESCE(@DMV, 0) AS INT) + CAST(COALESCE(@Reg, 0) AS INT) + CAST(COALESCE(@Dla, 0) AS INT) > 0)
BEGIN -- Update DMV counts If registry counts are newer
	UPDATE #SelectionTable 
	SET 
		LastModified = r.LastModified,
		SourceType = r.SourceType,
		DonorDesignationStatus = r.DonorDesignationStatus,
		TotalYes = r.TotalYes
		
	FROM 
		(SELECT DISTINCT
			-- Registry.ID AS 'SourceID',
			@StateDisplayName AS 'StateDisplayName',
			'Reg' 	AS SourceType,
			Registry.Firstname AS 'Firstname',
			Registry.LastName AS 'LastName',
			Registry.DOB AS 'DOB',
			Registry.LastModified AS 'LastModified', 

			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
						THEN 'New No'
					ELSE 'Unknown'
			  END AS DonorDesignationStatus,

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, Registry.DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS AgeRange,

			/* Gender default*/  
			CASE	WHEN Registry.Gender = 'M'
				THEN 'M'
				WHEN Registry.Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS Gender,
			
			/* Total Yes Count */
			CASE WHEN
				(PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
				(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
				(PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
				THEN 1
				ELSE 0
			END AS TotalYes						
			
			
		FROM DMV_Common..Registry AS Registry
		JOIN DMV_Common..RegistryAddr AS RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID AND (RegistryAddr.AddrTypeID =1)
		/* only update if person does exists in previous selection*/
		JOIN #SelectionTable st ON st.FirstName = Registry.FirstName AND st.LastName = Registry.LastName AND st.DOB = Registry.DOB  
		WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
			AND Registry.RegistryOwnerId = @RegistryOwnerID
			AND DonorConfirmed = 1
			AND Registry.Gender is Not Null  
			AND Registry.LastModified > st.LastModified

			AND ((PreviousDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
				(PreviousDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
				(PreviousDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
				(PreviousDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes

)r
WHERE r.FirstName = #SelectionTable.FirstName AND
	r.LastName = #SelectionTable.LastName AND
	r.DOB = #SelectionTable.DOB;




/*
	DELETE #SelectionTable
	FROM 
	(SELECT  lt.LastName AS 'd_LastName',
		lt.FirstName AS 'd_FirstName',
		lt.DOB AS 'd_DOB',
		MAX(lt.LastModified) AS 'd_LastModified'
	FROM #SelectionTable AS lt
	WHERE Exists
		(SELECT LastName, FirstName, DOB
		FROM #SelectionTable rt
		WHERE rt.LastName = lt.LastName
	 		AND rt.FirstName = lt.FirstName
			AND rt.DOB = lt.DOB
		GROUP BY rt.LastName, rt.FirstName, rt.DOB
		HAVING Count(*) > 1
		)
	GROUP BY  lt.LastName, lt.FirstName, lt.DOB
	)dt

	WHERE 	LastName = dt.d_LastName
		AND FirstName = dt.d_FirstName
		AND DOB = dt.d_DOB
		AND LastModified <> dt.d_LastModified
*/

END --Remove duplicates


IF @ReportFormat = 'Standard'
BEGIN
	INSERT #CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						'' AS 'Gender',
						Count(*) AS 'Number'
						
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus
						
						
/* Add Total Yes Counts for Standard */
	INSERT #CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						'' AS 'AgeRange',
						'' AS 'Gender',
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType;
--			ORDER BY
--						StateDisplayName,
--						SourceType


/*** Make Finial Selection for Standard Format ***/
			SELECT 
						StateDisplayName,
						--SourceType,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						'' AS 'Gender',
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry', 
						SUM(CASE WHEN SourceType = 'Dla' THEN Number ELSE 0 END)AS 'DlaRegistry'

			FROM #CountTable
			GROUP BY
						StateDisplayName,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus;


END


IF @ReportFormat = 'Age'
BEGIN
	INSERT #CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						'' AS 'Gender',
						Count(*) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						AgeRange
						
						
						
/* Add Total Yes Counts for Age*/
	INSERT #CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						AgeRange,
						'' AS 'Gender',
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						AgeRange;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						AgeRange



/*** Make Finial Selection for Age ***/
			SELECT 
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange,
						'' AS 'Gender',
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry', 
						SUM(CASE WHEN SourceType = 'Dla' THEN Number ELSE 0 END)AS 'DlaRegistry'

			FROM #CountTable
			GROUP BY
						StateDisplayName,
						AgeRange,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange;



END


IF @ReportFormat = 'Gender'
BEGIN
	INSERT #CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						Gender,
						Count(*) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						Gender;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						Gender


/* Add Total Yes Counts for Gender*/
	INSERT #CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						'' AS 'AgeRange',
						Gender,
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						Gender;
--			ORDER BY
--						StateDisplayName,
--						SourceType, 
--						Gender


/*** Make Finial Selection for Gender  ***/
			SELECT 
						StateDisplayName,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						Gender,
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry', 
						SUM(CASE WHEN SourceType = 'Dla' THEN Number ELSE 0 END)AS 'DlaRegistry'

			FROM #CountTable
			GROUP BY
						StateDisplayName,
						Gender,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						Gender;




END

IF @ReportFormat = 'AgeGender'
BEGIN
	INSERT #CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						Gender,
						Count(*) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						Gender;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						AgeRange,
--						Gender


/* Add Total Yes Counts for Age and Gender*/
	INSERT #CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						AgeRange,
						Gender,
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						AgeRange,
						Gender;
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						AgeRange,
--						Gender


/*** Make Finial Selection for AgeGender ***/
			SELECT 
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange,
						Gender,
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry', 
						SUM(CASE WHEN SourceType = 'Dla' THEN Number ELSE 0 END)AS 'DlaRegistry'

			FROM #CountTable
			GROUP BY
						StateDisplayName,
						AgeRange,
						Gender,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange,
						Gender;

END

if (object_id('tempdb..#SelectionTable') is not null)
begin
	drop table #SelectionTable;
end
if (object_id('tempdb..#CountTable') is not null)
begin
	drop table #CountTable;
end


--SELECT * FROM #CountTable

GO



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeByZipCode.sql'
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ActionableDesignationVolumeByZipCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_ActionableDesignationVolumeByZipCode';
	drop procedure [dbo].[sps_ActionableDesignationVolumeByZipCode];
END
GO

SET QUOTED_IDENTIFIER ON; 
GO
SET ANSI_NULLS ON;
 
PRINT 'Creating Procedure: sps_ActionableDesignationVolumeByZipCode';
GO

CREATE PROCEDURE [dbo].[sps_ActionableDesignationVolumeByZipCode]
	@StartDateTime			DATETIME = NULL,
	@EndDateTime			DATETIME = NULL,
	@ZipCodeOptions			Int = NULL,
	@ZipCodeData			varchar(2000) = NULL,
	@StateDisplayName		varchar(50) = NULL,
	@DMV					Bit = Null,
	@Reg					Bit = Null,
	@Dla					BIT = NULL

					/* @ZipCodeoptions Int
						1 = Top 10 Higest and Lowest Producing Zip Codes
						2 = Many (or Single) Zip Code(s)
						3 = Return All Zip Codes 
					*/
	
AS
/******************************************************************************
**		File: sps_ActionableDesignationVolumeByZipCode.sql
**		Name: sps_ActionableDesignationVolumeByZipCode
**		Desc: NEOB Registry (NV)
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 04/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------		--------	-------------------------------------------
**      04/16/2008		ccarroll			initial
**		05/07/2008		ccarroll			modified way zip codes are selected for Top 10
**											@ZipCodeOptions = 1. Now combines DMV and Reg counts
**											by zip code in determining Highest - Lowest. Added SortTotals
**											field for sorting 'Total Yes' values in report.  
**		03/28/2012		ccarroll			Added SET NOCOUNT ON
**		08/06/2013		ccarroll			Changed PATINDEX to look for mixed (5-4) range of zipcode 
**		10/01/2013		Moonray Schepart	added De-Duplication when searching Web or Web and DMV
**		10/09/2013		Moonray Schepart	added function to trim zip code to 5 digits to accomodate for zip+4 zip codes
**		01/28/2014		Moonray Schepart	Integrate into Common Registry and Remove State Level Filter
**      12/12/2016		Mike Berenson		Added DLA Registry
*******************************************************************************/

DECLARE @RegistryOwnerID int = 0;

/*** NDN ***/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM DMV_Common..RegistryOwner WHERE RegistryOwnerName = 'NDN') ;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
		@StartDateTime = coalesce(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = coalesce	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)

IF @ZipCodeOptions = 3
  BEGIN
	SET @ZipCodeData = Null
  END

DECLARE @TotalYes int
DECLARE @StateRegistryCount int
DECLARE @WebRegistryCount int,
		@DlaRegistryCount INT;
DECLARE @ZipCounter int

CREATE TABLE #SelectionTable 
	(
		StateDisplayName		varchar(50) Null,
		ZipCode					varchar(10) Null,
		SourceType				varchar(10)	Null,
		FirstName				varchar(255) Null,
		LastName				varchar(255) Null,
		DOB						datetime Null,
		LastModified			datetime Null, 
		DonorDesignationStatus	varchar(25)	Null,
		TotalYes				int Null
	)
	
DECLARE @CountTable TABLE
	(
		StateDisplayName		varchar(50) Null,
		HighestLowestProducing varchar(50) Null,
		ZipCode					varchar(10) Null,
		SourceType				varchar(10) Null,
		DonorDesignationStatus	varchar(25)	Null,
		Number					int Null
	)


If @ZipCodeOptions = 1 /* Top 10 Higest and Lowest Producing Zip Codes */
BEGIN

CREATE TABLE #ZipCodeSelectTable 
	(
		ZipCode					varchar(10) Null,
		DMVCount				int Null,
		RegCount				int Null,
		DlaCount				INT	NULL
	)

DECLARE @ZipCodeTable TABLE
	(
		ZipCode					varchar(10) Null,
		ZipCodeCount				int Null,
		HighestLowestName			varchar(50)
	)


	If @DMV = 1 
	BEGIN	--Begin DMV Zip Code selection

	/* Create ZipCode List for DMV*/
		INSERT  #ZipCodeSelectTable 
		SELECT
			LEFT(Zip, 5) AS 'ZipCode',
			Count(DMV.Donor) AS 'DMVCount',
			0 AS 'RegCount',
			0 AS 'DlaCount'
			FROM DMV
			JOIN DMVADDR ON DMV.ID = DMVADDR.DMVID AND (DMVADDR.AddrTypeID = 1)
			WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified <= @EndDateTime)
				/* Only Select ActionableDesignationVolume Items */
				AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
				(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
				(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
			Group By LEFT(Zip,5)

	END	--End DMV Zip Code selection
	

	If @Reg = 1 
	BEGIN	--Begin Registry Zip Code selection

	/* Create Top 10 ZipCode List for Registry*/
		INSERT  #ZipCodeSelectTable --Highest Zip Codes
			SELECT
				LEFT(Zip, 5) AS 'ZipCode',
				0 AS 'DMVCount',
				Count(Registry.Donor) AS 'RegCount',
				0 AS 'DlaCount'
			
			FROM DMV_Common..Registry AS Registry
			JOIN DMV_Common..RegistryADDR AS RegistryADDR ON Registry.RegistryID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
				AND Registry.RegistryOwnerId = @RegistryOwnerID
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
					--(PreviousDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
					(PreviousDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes
			Group By LEFT(Zip,5)

	END	--End Registry Code selection
	

	IF @Dla = 1 
	BEGIN	--Begin Dla Zip Code selection

	/* Create Top 10 ZipCode List for Dla*/
		INSERT  #ZipCodeSelectTable --Highest Zip Codes
			SELECT
				Zip AS 'ZipCode',
				0 AS 'DMVCount',
				0 AS 'RegCount', 
				COUNT(Donor) AS 'DlaCount'
			
			FROM DMV_Common..RegistryDlaResponseItem
			WHERE 	LastModified BETWEEN @StartDateTime AND @EndDateTime
				AND GENDER IS NOT NULL
				AND Donor = 1
			GROUP BY Zip;

	END	--End Dla Code selection



/* Limit Zip Codes to only 10 Higher and 10 Lower 
	If both DMV and Reg are selected, up to 40 zip codes could be returned in the list, Therefore, only 10 of the Highest and 
	Lowest combined (Reg and DMV) zip codes should be returned. */
	 
	 -- Get Top 10 Highest ZipCodes
	INSERT @ZipCodeTable
		SELECT TOP 10 
			ZipCode AS 'ZipCodes',
			SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount) AS 'ZipCodeCount',
			'Top 10 Highest Producing Zip Codes' AS 'HighestLowestName'
		 FROM #ZipCodeSelectTable
		 GROUP BY ZipCode
		 ORDER BY (SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount)) DESC;

	 -- Get Top 10 Lowest ZipCodes
	INSERT @ZipCodeTable
		SELECT TOP 10 
			ZipCode AS 'ZipCodes',
			SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount) AS 'ZipCodeCount',
			'Top 10 Lowest Producing Zip Codes' AS 'HighestLowestName'
		 FROM #ZipCodeSelectTable
		 GROUP BY ZipCode
		 ORDER BY (SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount));

	/* Debug
		SELECT * FROM @ZipCodeTable
		ORDER BY HighestLowestName, ZipCodeCount */

/* Convert Zipcode table to String for use with Patindex */
	SET @ZipCodeData = '-' -- Provide a default starting value

		DECLARE ZipCode_Cursor CURSOR FOR
			SELECT ZipCode FROM @ZipCodeTable
		 	ORDER BY ZipCodeCount DESC 
		OPEN ZipCode_Cursor
			DECLARE @ZipCodeString varchar(10)
	
			FETCH NEXT FROM ZipCode_Cursor INTO @ZipCodeString
			WHILE @@FETCH_STATUS = 0
				BEGIN
				  SET @ZipCodeData = @ZipCodeData + @ZipCodeString + ',' 
				  FETCH NEXT FROM ZipCode_Cursor INTO @ZipCodeString
				END
			-- remove last,
			SET @ZipCodeData = LEFT(@ZipCodeData, LEN(@ZipCodeData)-1)
		--Debug: PRINT @ZipCodeData
		CLOSE ZipCode_Cursor
		DEALLOCATE ZipCode_Cursor

END -- @ZipCodeOptions = 1, Top 10 Higest and Lowest Producing Zip Codes 

	/* Note: The following are available @ZipCodeOptions:
			1 - Top 10 Higest and Lowest Producing Zip Codes
			2 - Many, Single ZipCode(s)
			3 - All Zip Codes	*/

	If @DMV = 1 
	BEGIN 	/* Add donor detail for DMV*/
		INSERT #SelectionTable 
			SELECT 
				@StateDisplayName AS 'StateDisplayName',
				LEFT(Zip, 5) AS 'ZipCode',
				'DMV' 	AS 'SourceType',
				Firstname AS 'Firstname',
				LastName AS 'LastName',
				DOB AS 'DOB',
				DMV.LastModified AS 'LastModified', 
		
				/* Correlate donor histoy*/
				CASE 	WHEN PreviousDonorState Is Null AND (Donor = 1) -- New Yes
							THEN 'New Yes'
						WHEN PreviousDonorState = 1 AND (Donor = 1) -- Yes To Yes
							THEN 'Yes To Yes'
						WHEN PreviousDonorState = 1 AND (Donor = 0) -- Yes To No
							THEN 'Yes To No'
						WHEN PreviousDonorState = 0 AND (Donor = 1) -- No To Yes
							THEN 'No To Yes'
						WHEN PreviousDonorState = 0 AND (Donor = 0) -- No To No
							THEN 'No To No'
						WHEN PreviousDonorState Is Null AND (Donor = 0) -- New No
							THEN 'New No'
						ELSE 'Unknown'
				END AS 'DonorDesignationStatus',

				/* Total Yes Count */
				CASE WHEN
					(PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
					(PreviousDonorState = 1 AND Donor = 1)	OR -- Yes To Yes
					(PreviousDonorState = 0 AND Donor = 1) -- No To Yes
					THEN 1
					ELSE 0
				END AS TotalYes			
			FROM DMV
			JOIN DMVADDR ON DMV.ID = DMVADDR.DMVID AND (DMVADDR.AddrTypeID = 1)
			WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified <= @EndDateTime)
				AND PATINDEX('%'+ DMV_Common.dbo.FiveDigitZipCode(DMVADDR.Zip) + '%', coalesce(@ZipCodeData, DMV_Common.dbo.FiveDigitZipCode(DMVADDR.Zip))) > 0
				/* Only Select ActionableDesignationVolume Items */
				AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
					(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
					(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
					(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
	END --@DMV = 1 Selection
	
	If @Reg = 1
	BEGIN

	/* Add donor detail for Registry*/
		INSERT #SelectionTable 

			SELECT 
				-- Registry.RegistryID AS 'SourceID',
				@StateDisplayName AS 'StateDisplayName',
				LEFT(Zip, 5) AS 'ZipCode',
				'Reg'AS 'SourceType',
				Firstname AS 'Firstname',
				LastName AS 'LastName',
				DOB AS 'DOB',
				Registry.LastModified AS 'LastModified', 

				/* Correlate donor histoy*/
				CASE 	WHEN PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
							THEN 'New Yes'
						WHEN PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
							THEN 'Yes To Yes'
						WHEN PreviousDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
							THEN 'Yes To No'
						WHEN PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
							THEN 'No To Yes'
						WHEN PreviousDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
							THEN 'No To No'
						WHEN PreviousDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
							THEN 'New No'
						ELSE 'Unknown'
				END AS 'DonorDesignationStatus',

				/* Total Yes Count */
				CASE WHEN
					(PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
					(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
					(PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
					THEN 1
					ELSE 0
				END AS TotalYes						
				
			FROM DMv_common..Registry AS Registry
			JOIN DMv_common..RegistryADDR AS RegistryADDR ON Registry.RegistryID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
				AND Registry.RegistryOwnerId = @RegistryOwnerID
				AND PATINDEX('%'+ DMV_Common.dbo.FiveDigitZipCode(RegistryADDR.Zip) + '%', coalesce(@ZipCodeData, DMV_Common.dbo.FiveDigitZipCode(RegistryADDR.Zip))) > 0
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR	 -- Yes To Yes
					(PreviousDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR	 -- Yes To No
					(PreviousDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))	 -- No To Yes

	END -- @Reg = 1 Selection
	
	IF @Dla = 1
	BEGIN

	/* Add donor detail for DLA */
		INSERT #SelectionTable 

			SELECT 
				@StateDisplayName AS 'StateDisplayName',
				Zip AS 'ZipCode',
				'Dla'AS 'SourceType',
				Firstname AS 'Firstname',
				LastName,
				DOB AS 'DOB',
				LastModified AS 'LastModified', 

				/* Correlate donor histoy*/
				'Unknown' AS 'DonorDesignationStatus',

				/* Total Yes Count */
				Donor AS TotalYes						
				
			FROM DMV_Common..RegistryDlaResponseItem
			WHERE 	LastModified BETWEEN @StartDateTime AND @EndDateTime
				AND (@ZipCodeData IS NULL OR PATINDEX('%'+ Zip + '%', @ZipCodeData) > 0)
				AND GENDER IS NOT NULL;

	END -- @Dla = 1 Selection

--Debug SELECT * FROM #SelectionTable

/* Remove duplicates 
	uses derived Right to Left table comparison to 
	find duplicates in (#SelectionTable) and then removes them
	by deleting duplicates which do not have the most
	current (LastModified) date.
	Duplicates are based on the following criteria:
		- FirstName
		- LastName
		- DOB
Remove Duplicates when running for Registry or Registry and DMV
*/
IF (CAST(COALESCE(@DMV, 0) AS INT) + CAST(COALESCE(@Reg, 0) AS INT) + CAST(COALESCE(@Dla, 0) AS INT) > 0)
BEGIN

	DELETE #SelectionTable
	FROM 
	(SELECT  lt.LastName AS 'd_LastName',
		lt.FirstName AS 'd_FirstName',
		lt.DOB AS 'd_DOB',
		MAX(lt.LastModified) AS 'd_LastModified'
	FROM #SelectionTable AS lt
	WHERE Exists
		(SELECT LastName, FirstName, DOB
		FROM #SelectionTable rt
		WHERE rt.LastName = lt.LastName
	 		AND rt.FirstName = lt.FirstName
			AND rt.DOB = lt.DOB
		GROUP BY rt.LastName, rt.FirstName, rt.DOB
		HAVING Count(*) > 1
		)
	GROUP BY  lt.LastName, lt.FirstName, lt.DOB
	)dt

	WHERE 	LastName = dt.d_LastName
		AND FirstName = dt.d_FirstName
		AND DOB = dt.d_DOB
		AND LastModified <> dt.d_LastModified
END

If @ZipCodeOptions = 1 /* Top 10 Higest and Lowest Producing Zip Codes */
BEGIN	
/* Populate CountTable using temporary Zip Code table- counts*/	

	INSERT @CountTable
			SELECT 
						StateDisplayName,
						HighestLowestName AS 'HightestLowestProducing',
						st.Zipcode,
						st.SourceType,
						DonorDesignationStatus,
						Count(*) AS 'Number'
						
			FROM #SelectionTable st
			JOIN (SELECT DISTINCT ZipCode, HighestLowestName FROM @ZipCodeTable)zt ON  zt.ZipCode = st.ZipCode
			GROUP BY
						StateDisplayName,
						HighestLowestName,
						st.ZipCode,
						st.SourceType,
						DonorDesignationStatus

/* Populate CountTable with 'Total Yes' counts */
	INSERT @CountTable
			
			SELECT  
						StateDisplayName,
						HighestLowestName AS 'HightestLowestProducing',
						st.Zipcode,
						st.SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable st
			JOIN (SELECT DISTINCT ZipCode, HighestLowestName FROM @ZipCodeTable)zt ON  zt.ZipCode = st.ZipCode
			GROUP BY
						StateDisplayName,
						HighestLowestName,
						st.ZipCode,
						st.SourceType


END --@ZipCodeOptions = 1 (Top 10 Highest and Lowest Producing Zip Codes)

IF @ZipCodeOptions > 1
BEGIN

/* Populate CountTable for the following @ZipCodeOptions	
						2 = Many (or Single) Zip Code(s)
						3 = Return All Zip Codes */

	INSERT @CountTable
			
			SELECT 
						StateDisplayName,
						'' AS 'HighestLowestProducing',
						Zipcode,
						SourceType,
						DonorDesignationStatus,
						Count(*) AS 'Number'
						
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						ZipCode,
						SourceType,
						DonorDesignationStatus
			ORDER BY	
						Count(*) DESC,
						StateDisplayName,
						ZipCode,
						SourceType,
						DonorDesignationStatus
						
						
/* Populate CountTable with 'Total Yes' */
	INSERT @CountTable
			
			SELECT 
						StateDisplayName,
						'' AS 'HighestLowestProducing',
						Zipcode,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						Sum(TotalYes) AS 'Number'
			FROM #SelectionTable
			GROUP BY
						StateDisplayName,
						ZipCode,
						SourceType
			ORDER BY
						Sum(TotalYes) DESC,
						StateDisplayName,
						ZipCode,
						SourceType

END /* END Populate CountTable for the following @ZipCodeOptions	
						2 = Many (or Single) Zip Code(s)
						3 = Return All Zip Codes */




/*** Make Finial Selection  ***/


			--SELECT * FROM @CountTable
			SELECT 
						StateDisplayName,
						HighestLowestProducing,
						ZipCode,
						--SourceType,
						DonorDesignationStatus,
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry',
						SUM(CASE WHEN SourceType = 'Dla' THEN Number ELSE 0 END)AS 'DlaRegistry',
						SUM(CASE WHEN DonorDesignationStatus = 'Total Yes' THEN Number ELSE 0 END) AS 'SortTotals'

			FROM @CountTable
			GROUP BY
						StateDisplayName,
						HighestLowestProducing,
						ZipCode,
						DonorDesignationStatus

			ORDER BY
						StateDisplayName,
						HighestLowestProducing,
						ZipCode,
						DonorDesignationStatus

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_ActionableDesignationVolumeCountsEvent.sql'
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ActionableDesignationVolumeCountsEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_ActionableDesignationVolumeCountsEvent'
	drop procedure [dbo].[sps_ActionableDesignationVolumeCountsEvent]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_ActionableDesignationVolumeCountsEvent'
GO

CREATE PROCEDURE sps_ActionableDesignationVolumeCountsEvent
	@StartDateTime	SMALLDATETIME = NULL,
	@EndDateTime	SMALLDATETIME = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@SourceCode varchar(255) = NULL
AS
/******************************************************************************
**		File: sps_ActionableDesignationVolumeCountsEvent.sql
**		Name: sps_ActionableDesignationVolumeCountsEvent
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 02/29/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      02/29/2008		ccarroll				initial
**		04/24/2008		ccarroll				added SET TRANSACTION ISOLATION LEVEL 
**		01/02/2009		ccarroll				added to WHERE: remove category and sub category 0 values  
**		01/28/2014		Moonray Schepart		Integrate into Common Registry and Remove State Level Filter
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @RegistryOwnerID int = 0;

/*** NDN ***/
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM DMV_Common..RegistryOwner WHERE RegistryOwnerName = 'NDN') ;


SELECT
		@StartDateTime = ISNULL(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)


/* SET Category ID's to NULL if All option is selected.
 */
IF @EventCategoryID = 0 
BEGIN
	SET @EventCategoryID = NULL
END

IF @EventSubCategoryID = 0 
BEGIN
	SET @EventSubCategoryID = NULL
END




DECLARE @SelectionTable TABLE
	(
		SourceID				int			Null,
		SourceType				varchar(10)	Null,
		Event					varchar(255)Null,
		EventSub				varchar(255)Null,
		SourceCode				varchar(255)Null,
		DonorDesinationStatus	varchar(25)	Null,
		AgeRange				varchar(5)	Null,
		Gender					varchar(1)	Null,
		DonorTotalYes			int Null,
		DonorTotalNo			int Null
	)

	/* Add main donor detail */
	INSERT @SelectionTable 

		SELECT DISTINCT
			 Registry.RegistryID AS 'SourceID',
			'Reg' 	AS 'SourceType',
			EventCategory.EventCategoryName	AS 'Event',
			EventSubCategory.EventSubCategoryName	AS 'EventSub',
			'' AS 'SourceCode',

			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
						THEN 'New No'
						
						
					ELSE 'Unknown'
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			IsNull(Donor, 0)AS 'DonorTotalYes',
			
			CASE WHEN IsNull(Donor, 0) = 0
				THEN 1
				ELSE 0
			END AS 'DonorTotalNo'
			
		FROM DMV_Common..Registry AS Registry
		LEFT JOIN DMV_Common..RegistryADDR AS RegistryADDR ON RegistryADDR.RegistryID = Registry.RegistryID AND (RegistryADDR.AddrTypeID = 1)
		LEFT JOIN DMV_Common..EventRegistry AS EventRegistry ON Registry.RegistryID = EventRegistry.RegistryID
		LEFT JOIN DMV_Common..EventCategory AS EventCategory ON EventRegistry.EventCategoryID = EventCategory.EventCategoryID
		LEFT JOIN DMV_Common..EventSubCategory AS EventSubCategory ON EventRegistry.EventSubCategoryID = EventSubCategory.EventSubCategoryID
		WHERE Registry.LastModified BETWEEN @StartDateTime AND @EndDateTime
			AND Registry.RegistryOwnerId = @RegistryOwnerID
			AND  DonorConfirmed = 1

			AND isNull(EventRegistry.EventCategoryID, 0) = IsNull(@EventCategoryID, IsNull(EventRegistry.EventCategoryID, 0))
			AND isNull(EventRegistry.EventSubCategoryID, 0) = IsNull(@EventSubCategoryID, IsNull(EventRegistry.EventSubCategoryID, 0))
			AND isNull(EventSubCategory.EventSubCategorySourceCode, 0) = IsNull(@SourceCode, IsNull(EventSubCategory.EventSubCategorySourceCode, 0))
			


	/* Add Total detail */
	INSERT @SelectionTable 

		SELECT DISTINCT
			 Registry.RegistryID AS 'SourceID',
			'Reg' 	AS 'SourceType',
			EventCategory.EventCategoryName	AS 'Event',
			EventSubCategory.EventSubCategoryName	AS 'EventSub',
			'' AS 'SourceCode',

			/* Correlate Total Yes*/
			CASE 	WHEN (PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) -- New Yes
						OR	(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) -- Yes To Yes
						OR  (PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
						THEN 'Total Yes'
						
			  END AS 'DonorDesignationStatus',

			/* Correlate Donor AgeRange */
			CASE 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) <= 17
				THEN '0-17'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 18 AND 21
				THEN '18-21'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 22 AND 29
				THEN '22-29'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 30 AND 39
				THEN '30-39'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 40 AND 49
				THEN '40-49'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 50 AND 59
				THEN '50-59'
		
			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) BETWEEN 60 AND 69
				THEN '60-69'

			 	WHEN CAST((DATEDIFF(day, DOB, GetDate()) / 365.25) AS int) >= 70
				THEN '70+'

			  END AS 'AgeRange',

			/* Gender default*/  
			CASE	WHEN Gender = 'M'
				THEN 'M'
				WHEN Gender = 'F'
				THEN 'F'
				ELSE 'U' --Unknown
			END AS 'Gender',
			
			Null AS 'DonorTotalYes',	/* Used for total counts. DonorTotalYes and DonorTotalNo are counted*/
			Null AS 'DonorTotalNo'		/* in above selection */
			
		FROM DMV_Common..Registry AS Registry
		LEFT JOIN DMV_Common..RegistryADDR AS RegistryADDR ON RegistryADDR.RegistryID = Registry.RegistryID AND (RegistryADDR.AddrTypeID = 1)
		LEFT JOIN DMV_Common..EventRegistry AS EventRegistry ON Registry.RegistryID = EventRegistry.RegistryID
		LEFT JOIN DMV_Common..EventCategory AS EventCategory ON EventRegistry.EventCategoryID = EventCategory.EventCategoryID
		LEFT JOIN DMV_Common..EventSubCategory AS EventSubCategory ON EventRegistry.EventSubCategoryID = EventSubCategory.EventSubCategoryID
		WHERE Registry.LastModified BETWEEN @StartDateTime AND @EndDateTime
			AND Registry.RegistryOwnerId = @RegistryOwnerID
			AND  (Registry.Donor = 1  AND Registry.DonorConfirmed = 1)
			  
			AND isNull(EventRegistry.EventCategoryID, 0) = IsNull(@EventCategoryID, IsNull(EventRegistry.EventCategoryID, 0))
			AND isNull(EventRegistry.EventSubCategoryID, 0) = IsNull(@EventSubCategoryID, IsNull(EventRegistry.EventSubCategoryID, 0))
			AND isNull(EventSubCategory.EventSubCategorySourceCode, 0) = IsNull(@SourceCode, IsNull(EventSubCategory.EventSubCategorySourceCode, 0))



SELECT * FROM @SelectionTable
	/* ccarroll 01/02/2009 - exclude the following: */
	WHERE DonorDesinationStatus <> 'No To No'
	AND DonorDesinationStatus <> 'New No'
	AND DonorDesinationStatus <> 'Unknown'

ORDER BY Event, EventSub,DonorDesinationStatus

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistry_DMVLoad.sql'
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
**	Parameters:
**
**	Auth: Unknown
**	Date: 3/2003
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:		Description:
**	10/15/2007	ccarroll	Added FirstName, and LastName to select
**	01/27/2014	ccarroll	Added Distinct to remove duplicate addresses.
**							Updated sproc to use patindex
**	10/17/2016	mberenson	Return DLA records from DMV_Common with results
**	10/19/2016	mberenson	Changed source for dmv records to "State"
**	11/16/2016	mberenson	Moved DLA logic to DMV_Common.sps_CheckRegistry_DLALoad.sql
**	12/12/2016	mberenson	Return just the newest record
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
			AND (@LastName IS NULL OR DMV.LastName IS NULL OR PATINDEX(@LastName, DMV.LastName) > 0)
		/* Search (wildcards permitted) - FirstName */
			AND (@FirstName IS NULL OR DMV.FirstName IS NULL OR PATINDEX(@FirstName, DMV.FirstName) > 0)
			AND (@MiddleName IS NULL OR DMV.MiddleName IS NULL OR PATINDEX(@MiddleName, DMV.MiddleName) > 0)
			AND (@License IS NULL OR DMV.License IS NULL OR PATINDEX(@License, DMV.License) > 0)
			AND (@StreetAddress IS NULL OR DMVADDR.Addr1 IS NULL OR PATINDEX(@StreetAddress, DMVADDR.Addr1) > 0)
			AND (@City IS NULL OR DMVADDR.City IS NULL OR PATINDEX(@City, DMVADDR.City) > 0)
			AND (@State IS NULL OR DMVADDR.State IS NULL OR PATINDEX(@State, DMVADDR.State) > 0)
			AND (@Zip IS NULL OR DMVADDR.Zip IS NULL OR PATINDEX(@Zip, DMVADDR.Zip) > 0)
	ORDER BY DMV.LastModified DESC;

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistry_RegLoad.sql'
GO
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_CheckRegistry_REGLoad')
BEGIN
	PRINT 'Dropping Procedure sps_CheckRegistry_REGLoad';
	DROP PROCEDURE sps_CheckRegistry_REGLoad;
END
	PRINT 'Creating Procedure sps_CheckRegistry_REGLoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistry_REGLoad]
(
	@DOB			VARCHAR(255) = NULL,
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
**		File: sps_CheckRegistry_REGLoad.sql
**		Name: sps_CheckRegistry_REGLoad
**		Desc: Returns matching donors from the web registry based on input fields
**
**		Return values: none
** 
**		Called by: StatTrac FrmReferralDonorData.vb
**
**		Auth: ccarroll
**		Date: 02/23/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/23/2010	ccarroll	initial
**		10/15/2007	ccarroll	added FirstName, LastName to select
**		01/23/2014	ccarroll	Changed Registry location to DMV_Common	
**		10/19/2016	mberenson	Added source column
**		12/22/2016	mberenson	Limited row count to the top 1
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	DECLARE @RegistryOwnerId INT = 3; -- NDN
			-- State not used because Registry Owner represents multiple states 
			
	SELECT TOP(1)
		r.FirstName,
		r.MIDDLENAME,
		r.LastName,
		r.License,
		ra.Addr1,
		ra.city AS [City],
		ra.[State] AS [State],
		ra.zip AS [Zip],
		r.LastModified AS [SearchDate],
		r.RegistryID AS [loc],
		'Web' AS [Source]

	FROM DMV_Common.dbo.Registry r
	JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryID = ra.RegistryID
	WHERE RegistryOwnerID = @RegistryOwnerID

	AND r.DeleteFlag = 0
	AND	r.DOB = @DOB
	AND (@FirstName IS NULL OR r.FirstName IS NULL OR PATINDEX(@FirstName, r.FirstName) > 0)
	AND (@MiddleName IS NULL OR r.MiddleName IS NULL OR PATINDEX(@MiddleName, r.MiddleName) > 0)
	AND (@LastName IS NULL OR r.LastName IS NULL OR PATINDEX(@LastName, r.LastName) > 0)
	AND (@LICENSE IS NULL OR r.License IS NULL OR PATINDEX(@License, r.License) > 0)
	AND (@StreetAddress IS NULL OR ra.Addr1 IS NULL OR PATINDEX(@StreetAddress, ra.Addr1) > 0)
	AND (@City IS NULL OR ra.City IS NULL OR PATINDEX(@City, ra.City) > 0)
	AND (@State IS NULL OR ra.State IS NULL OR PATINDEX(@State, ra.State) > 0)
	AND (@Zip IS NULL OR ra.Zip IS NULL OR PATINDEX(@Zip, ra.Zip) > 0 )

	ORDER BY r.LastModified DESC;

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_CheckRegistryv2.sql'
GO
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistryv2]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	PRINT 'Dropping Procedure: sps_CheckRegistryv2';
	DROP PROCEDURE [dbo].[sps_CheckRegistryv2];
END
	PRINT 'Creating Procedure: sps_CheckRegistryv2';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistryv2]
(
	@DOB   			DATETIME    	= NULL,
	@LastName		VARCHAR(25) 	= NULL,
	@FirstName 		VARCHAR(25) 	= NULL,
	@NADD 			INT	       		= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   			VARCHAR(11) 	= NULL,
	@LICENSE 		VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 			VARCHAR(25) 	= NULL,
	@State 			VARCHAR(2) 		= NULL,
	@Zip 			VARCHAR(10) 	= NULL,
	@loc			INT				= NULL,
	@Found			VARCHAR(25)		= NULL
)
/******************************************************************************
**		File: sps_CheckRegistryv2.sql
**		Name: sps_CheckRegistryv2
**		Desc:  Returns registry data based on DOB, FirstName, & LastName
**		Paramameters
**			See above
**
**		Called by:  StatQuery.vb
**              
**		Auth: Unknown
**		Date: 01/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		10/17/2016	mberenson	Added to source control 
**		10/17/2016	mberenson	Added DLA logic
**		11/16/2016	mberenson	Moved DLA logic to DMV_Common.sps_CheckRegistryv2
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;
	PRINT @loc;

	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT;
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0;

	-- get values for registry 
	IF  @Found = 'Web'  OR isnull(@Found,'') = '' 
	BEGIN
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
			@REGRecordsReturned OUTPUT;
	END
	--PRINT @RegistryID;
	--PRINT @RegistryDonor;
	--PRINT @REGRecordsReturned;
	/*
	   Suspense Variable Note:
	   NULL returns both registry (non-suspense) and suspense records
	   1	returns registry  (non-suspense) records
	   0	returns suspense records

	*/
	PRINT @loc;
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
		'R' AS 'Organization',
		@REGRecordsReturned AS 'RecordsReturned';
		
		RETURN;
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
		'R' AS 'Organization',
		@REGRecordsReturned AS 'RecordsReturned';
		
		RETURN;
	END
	PRINT @loc;

	IF @Found = 'State' OR ISNULL(@Found,'') = '' 
	BEGIN
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
			@DMVRecordsReturned OUTPUT;
	END
	
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
		'R' AS 'Organization',
		@DMVRecordsReturned AS 'RecordsReturned';
		
		RETURN;
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
		'R' AS 'Organization',
		@DMVRecordsReturned AS 'RecordsReturned';
		
		RETURN;	
	END
	PRINT @loc;

	--PRINT @DMVDonor;
	--PRINT @RegistryDonor;
	--PRINT @OnlineDonor;

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
			'R' AS 'Organization',
			@REGRecordsReturned AS 'RecordsReturned';
				
			RETURN;

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
				AS 'RestrictionID';
			RETURN;				
		END		
		-- check if dmv is the latest date	
		ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
		-- Return DMV;
		BEGIN
			SELECT
				'DMV' AS 'Source',
				@DMVID AS 'ID',
				CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
				@DMVDate AS 'Date',
				CASE @RegistryDonor WHEN 1 THEN @RegistryID ELSE 0 END AS 'RestrictionID';
			RETURN;
		END
		-- check if all the values are not = N for No
		-- Both registry and dmv dates are equal, check that both = Y
		ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
		BEGIN
			-- if registry is not null return registry
			IF (@RegistryID IS NOT NULL)
			BEGIN
				PRINT ('Registry');
				SELECT
								
					'Registry' AS 'Source',
					@RegistryID AS 'ID',
					CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor',
					@RegistryDate AS 'Date'	,
					@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
					AS 'RestrictionID';
				RETURN;							
			END
			ELSE
			BEGIN 
				PRINT('DMV');
				SELECT
								
					'DMV' AS 'Source',
					@DMVID AS 'ID',
					CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
					@DMVDate AS 'Date',
					CASE @RegistryDonor WHEN 1 THEN @RegistryID ELSE 0 END AS 'RestrictionID';
				RETURN;
						
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
				'R' AS 'Organization',
				@REGRecordsReturned AS 'RecordsReturned';

				RETURN;
		END			
	END

GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_NV\sprocs\sps_IMPORT_All_ImportDonor.sql'
GO
 if exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_IMPORT_All_ImportDonor'
	drop procedure [dbo].[sps_IMPORT_All_ImportDonor]
END
	PRINT 'Creating Procedure: sps_IMPORT_All_ImportDonor'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[sps_IMPORT_All_ImportDonor] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonor.sql
**		Name: sps_IMPORT_All_ImportDonor
**		Desc: Loads data into temp table FROM the Import table using T-Cursor
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		NA
**
**		Auth: unknown						01/2003
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     08/26/2010	ccarroll			Added Lastmodified Date for reporting (HS: 24904)
**	   10/01/2013	Moonray Schepart	Changed lastmodified date to default to the last day 
**										of the last month instead of the current date.
**	   03/03/2014	Moonray Schepart	Modified lastmodified date to calulcate last day at midnight
**	   08/07/2014	Moonray Schepart	Inclusion of Display Name fields (CCRST196)
**     08/10/2016	Michael Maitan		Reworked sproc so it doesn't use a cursor similar to what was done for DMV_CO
*******************************************************************************/
DECLARE @ID       int; 
DECLARE @IDENTITY int;
DECLARE @IMPORTLOGID int;
DECLARE @CurrentID			int;
DECLARE @alterSequenceSQL	NVARCHAR(200);
DECLARE @maxIdDmv			int; 
DECLARE @maxIdDmvArchive	int;
DECLARE @recordUpdateCount	int;
DECLARE @LastDayOfLastMonth	datetime;

select @recordUpdateCount = 25000; --25000

SET @LastDayOfLastMonth = CONVERT(datetime, SUBSTRING(CONVERT(nvarchar(20), Dateadd(d, -DATEPART(d, getdate()), GETDATE())),1,11));

select @maxIdDmv		= COALESCE(MAX(ID),5000) FROM DMV;
select @maxIdDmvArchive	= COALESCE(MAX(ID),5000) FROM DMVArchive;

					-- modified code grab max from either dmv or dmvarchive
SELECT @CurrentID = (select Max(id) from (
				select coalesce((select max(coalesce(id, 0)) from DMV), 0) id
				union all 
				select coalesce((select max(coalesce(id, 0)) from DMVARCHIVE), 0) id
				) ud);

SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

IF OBJECT_ID('tempdb..#TmpDMVIdTable') IS NOT NULL
BEGIN
	DROP TABLE #TmpDMVIdTable;
END

CREATE TABLE #TmpDMVIdTable
(
	[IMPORTID] [int] NOT NULL,
	[ID] [int] NOT NULL
);

if not exists (select top(1) 1 from #TmpDMVIdTable)
begin
	IF EXISTS(SELECT * FROM sys.sequences WHERE name = 'CountBy1') 
	BEGIN
		DROP SEQUENCE CountBy1 ;	
	END	
		CREATE SEQUENCE dbo.CountBy1
			START WITH 1
			INCREMENT BY 1 ;

	   SET @alterSequenceSQL = 'ALTER SEQUENCE dbo.CountBy1 RESTART WITH ' + CONVERT(varchar(30),@CurrentID + 1);
	   EXECUTE sp_executesql @alterSequenceSQL;

	INSERT INTO #TmpDMVIdTable
	SELECT [ID],
			NEXT VALUE FOR dbo.CountBy1 
	FROM IMPORT;

	DROP SEQUENCE CountBy1;
end

-----------------------------------------------------------------------------------------------------------------------
WHILE EXISTS (SELECT TOP(1) 1 FROM dbo.#TmpDMVIdTable T WHERE NOT EXISTS ( SELECT 1 FROM DMVTempTable where T.ID = DMVTempTable.ID ))
BEGIN
		SET IDENTITY_INSERT DMVTempTable ON;
		INSERT DMVTempTable ( T.[ID],
					 IMPORTLOGID,
					 SSN,
					 License,
					 DOB,
					 FirstName,
					 MiddleName,
					 LastName,
					 Suffix,
					 Gender,
					 Donor,
					 RenewalDate,
					 DeceasedDate, 
					 CSORState,
					 CSORLicense,
					 LastModified,
					 CreateDate,
					 FirstName_Display,
					 MiddleName_Display,
					 LastName_Display)
		SELECT TOP(@recordUpdateCount)	T.ID,
				   @IMPORTLOGID,
				   NULL,
				   RTRIM(LICENSE),
				   CASE ISDATE(DOB)
				   WHEN 0 THEN NULL
				   ELSE CONVERT(datetime,DOB)
				   END,
				   LEFT(FIRST,20),
				   LEFT(MIDDLE,20),
				   LEFT(LAST,25),
				   SUFFIX,
				   GENDER,
				   CASE upper(DONOR)
						WHEN 'Y' THEN 1
						ELSE 0
                   END,
				   CASE ISDATE(RENEWALDATE)
						WHEN 0 THEN NULL
						ELSE CONVERT(datetime,RENEWALDATE)
				   END,
				   CASE ISDATE(DECEASEDDATE)
						WHEN 0 THEN NULL
						ELSE CONVERT(datetime,DECEASEDDATE)
				   END,
				   CSORSTATE,
				   CSORLICENSE,
				   @LastDayOfLastMonth,
				   ISNULL(CREATEDATE,GETDATE()),
				   First_Display,
				   Middle_Display,
				   Last_Display
		 FROM IMPORT I
		 INNER JOIN	#TmpDMVIdTable T ON T.IMPORTID = I.[ID]
		 WHERE NOT EXISTS ( SELECT 1 FROM DMVTempTable where t.ID = DMVTempTable.ID );
	

		SET IDENTITY_INSERT DMVTempTable OFF;
	END

	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT 
								INNER JOIN
									#TmpDMVIdTable T
								ON T.IMPORTID = IMPORT.[ID] 
								WHERE	(AADDR1 is not null 
								and		ACITY is not null 
								and		 ASTATE is not null  
								and		AZIP is not null )
								and		(AADDR1 <> '' 
								and		 ACITY <> '' 
								and		ASTATE <> '' 
								and		AZIP <> '0' )							
								AND  NOT EXISTS ( SELECT TOP(1) 1	
													FROM DMVADDRTempTable  JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
													WHERE AddrTypeID = 1 AND T.ID = DMVTempTable.ID ))

	BEGIN

		INSERT DMVADDRTempTable (DMVID,      
						ADDRTYPEID, 
						Addr1,  
						Addr2, 
						City,  
						State,  
						Zip)    
		SELECT top(@recordUpdateCount) T.ID,  
						1,          
						AADDR1, 
						NULL,  
						ACITY, 
						ASTATE, 
						AZIP
		FROM IMPORT
		INNER JOIN
			#TmpDMVIdTable T
		ON T.IMPORTID = IMPORT.[ID] 
		WHERE (AADDR1 is not null 
		and		ACITY is not null 
		and		ASTATE is not null  
		and		AZIP is not null )
		and		(AADDR1 <> '' 
		and		ACITY <> '' 
		and		ASTATE <> '' 
		and		AZIP <> '0' )							
		AND NOT EXISTS ( SELECT 1 FROM DMVADDRTempTable  JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID WHERE AddrTypeID = 1 AND T.ID = DMVTempTable.ID );
	END

	WHILE EXISTS (SELECT TOP(1) 1 FROM IMPORT
									INNER JOIN
											#TmpDMVIdTable T
										ON T.IMPORTID = IMPORT.[ID] 
									WHERE	(BADDR1 is not null 
									and		BCITY is not null 
									and		BSTATE is not null  
									and		BZIP is not null 
									and		BADDR1 <> '' 
									and		BCITY <> '' 
									and		BSTATE <> '' 
									and		BZIP <> '0' )
									AND NOT EXISTS ( SELECT TOP(1) 1 FROM DMVADDRTempTable JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
														WHERE AddrTypeID = 2 AND T.ID = DMVTempTable.ID))
	BEGIN
		INSERT DMVADDRTempTable (DMVID,      
						ADDRTYPEID, 
						Addr1,  
						Addr2, 
						City,  
						State,  
						Zip)
		SELECT top(@recordUpdateCount) T.[ID],  
						2,          
						BADDR1, 
						NULL,  
						BCITY, 
						BSTATE, 
						BZIP
		FROM IMPORT
		INNER JOIN
				#TmpDMVIdTable T
			ON T.IMPORTID = IMPORT.[ID] 
		WHERE	(BADDR1 is not null 
		and		BCITY is not null 
		and		BSTATE is not null  
		and		BZIP is not null 
		and		BADDR1 <> '' 
		and		BCITY <> '' 
		and		BSTATE <> '' 
		and		BZIP <> '0' )
		AND NOT EXISTS ( SELECT 1 FROM DMVADDRTempTable JOIN DMVTempTable ON DMVADDRTempTable.DMVID = DMVTempTable.ID 
							WHERE AddrTypeID = 2 AND T.ID = DMVTempTable.ID);
	END

GO
	--Redundant:
	--IF isnull(@Donor,'') <> ''
	--BEGIN
	--	INSERT DMVORGAN (DMVID, ORGANTYPEID)
	--	SELECT           @IDENTITY, case ltrim(rtrim(DONOR))
	--				  when 'Y' then 1                   
	--		   else 0
	--								end
	--	FROM IMPORT
	--	WHERE IMPORT.ID = @ID;   
	--END



GO
