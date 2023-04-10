PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/9/2017 8:06:56 PM-- -- --  
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_ActionableDesignationVolumeByStatus.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_ActionableDesignationVolumeByZipCode.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_DMVLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_RegLoad.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_REGv2.sql
-- C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistryv2.sql

PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_ActionableDesignationVolumeByStatus.sql'
GO
USE DMV_MA
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
**		Desc: Uses Common registry (MA)
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
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      04/04/2008		ccarroll				initial
**		10/01/2013		mschepart				added De-Duplication when searching Web or Web and DMV
**												replaced IsNull with COALESCE
**      12/12/2016		mberenson				Added DLA Registry
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
		@StartDateTime = COALESCE(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = COALESCE	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								);

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


Create Table #SelectionTable
	(
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
	
Create Table #CountTable
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
/* Add donor detail for Registry*/
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
		WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified < @EndDateTime)
			/* Only Select ActionableDesignationVolume Items */
			AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
				(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
				(PreviousDonorState = 0 AND Donor = 1));		  -- No To Yes
				
	
END


	
If @Reg = 1
BEGIN
/* Add donor detail for Registry*/
	INSERT #SelectionTable 

		SELECT DISTINCT
			-- Registry.ID AS 'SourceID',
			@StateDisplayName AS 'StateDisplayName',
			'Reg' 	AS 'SourceType',
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
				(PreviousDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
				(PreviousDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
				(PreviousDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
				THEN 1
				ELSE 0
			END AS TotalYes						
			
			
		FROM DMV_Common..Registry AS Registry
		JOIN DMV_Common..RegistryAddr AS RegistryAddr ON Registry.RegistryID = RegistryAddr.RegistryID AND (RegistryAddr.AddrTypeID =1)
		WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
			AND RegistryAddr.State = 'MA'
			AND DonorConfirmed = 1
			AND GENDER is Not Null  

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
		AND LastModified <> dt.d_LastModified;
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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_ActionableDesignationVolumeByZipCode.sql'
GO
USE DMV_MA
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
**		Desc: NEOB Registry (MA)
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
**      04/16/2008		ccarroll	initial
**		05/07/2008		ccarroll	modified way zip codes are selected for Top 10
**									@ZipCodeOptions = 1. Now combines DMV and Reg counts
**									by zip code in determining Highest - Lowest. Added SortTotals
**									field for sorting 'Total Yes' values in report.  
**		10/01/2013		mschepart	added De-Duplication when searching Web or Web and DMV
**									replaced IsNull with COALESCE
**		10/09/2013		mschepart	added function to trim zip code to 5 digits to accomodate for zip+4 zip codes 
**      12/12/2016		mberenson	Added DLA Registry
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
		@StartDateTime = COALESCE(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = COALESCE	(
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

DECLARE @SelectionTable TABLE
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

DECLARE @ZipCodeSelectTable TABLE
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
		INSERT  @ZipCodeSelectTable 
		SELECT
			Zip AS 'ZipCode',
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
			Group By Zip

	END	--End DMV Zip Code selection
	

	If @Reg = 1 
	BEGIN	--Begin Registry Zip Code selection

	/* Create Top 10 ZipCode List for Registry*/
		INSERT  @ZipCodeSelectTable --Highest Zip Codes
			SELECT
				Zip AS 'ZipCode',
				0 AS 'DMVCount',
				Count(Registry.Donor) AS 'RegCount',
				0 AS 'DlaCount'
			
			FROM DMV_Common..Registry AS Registry
			JOIN DMV_Common..RegistryADDR AS RegistryADDR ON Registry.RegistryID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
				AND RegistryAddr.State = 'MA'
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
					--(PreviousDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
					(PreviousDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes
			Group By Zip

	END	--End Registry Code selection
	

	IF @Dla = 1 
	BEGIN	--Begin Dla Zip Code selection

	/* Create Top 10 ZipCode List for Dla*/
		INSERT  @ZipCodeSelectTable --Highest Zip Codes
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
		 FROM @ZipCodeSelectTable
		 GROUP BY ZipCode
		 ORDER BY (SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount)) DESC;

	 -- Get Top 10 Lowest ZipCodes
	INSERT @ZipCodeTable
		SELECT TOP 10 
			ZipCode AS 'ZipCodes',
			SUM(DMVCount) + SUM(RegCount) + SUM(DlaCount) AS 'ZipCodeCount',
			'Top 10 Lowest Producing Zip Codes' AS 'HighestLowestName'
		 FROM @ZipCodeSelectTable
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
		INSERT @SelectionTable 
			SELECT 
				@StateDisplayName AS 'StateDisplayName',
				Zip AS 'ZipCode',
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
				AND PATINDEX('%'+ + DMV_Common.dbo.FiveDigitZipCode(DMVADDR.Zip) + '%', COALESCE(@ZipCodeData, + DMV_Common.dbo.FiveDigitZipCode(DMVADDR.Zip))) > 0
				/* Only Select ActionableDesignationVolume Items */
				AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
					(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
					(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
					(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
	END --@DMV = 1 Selection
	
	If @Reg = 1
	BEGIN

	/* Add donor detail for Registry*/
		INSERT @SelectionTable 

			SELECT 
				-- Registry.RegistryID AS 'SourceID',
				@StateDisplayName AS 'StateDisplayName',
				Zip AS 'ZipCode',
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
				AND RegistryAddr.State = 'MA'
				AND PATINDEX('%'+ + DMV_Common.dbo.FiveDigitZipCode(RegistryADDR.Zip) + '%', COALESCE(@ZipCodeData, + DMV_Common.dbo.FiveDigitZipCode(RegistryADDR.Zip))) > 0
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

--Debug SELECT * FROM @SelectionTable

/* Remove duplicates 
	uses derived Right to Left table comparison to 
	find duplicates in (@SelectionTable) and then removes them
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

	DELETE @SelectionTable
	FROM 
	(SELECT  lt.LastName AS 'd_LastName',
		lt.FirstName AS 'd_FirstName',
		lt.DOB AS 'd_DOB',
		MAX(lt.LastModified) AS 'd_LastModified'
	FROM @SelectionTable AS lt
	WHERE Exists
		(SELECT LastName, FirstName, DOB
		FROM @SelectionTable rt
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
						
			FROM @SelectionTable st
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
			FROM @SelectionTable st
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
						
			FROM @SelectionTable
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
			FROM @SelectionTable
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
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_DMVLoad.sql'
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
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			Added FirstName, and LastName to select
**	  10/17/2016	mberenson			Return DLA records from DMV_Common with results
**	  10/19/2016	mberenson			Changed source for dmv records to "State"
**	  11/16/2016	mberenson			Moved DLA logic to DMV_Common.sps_CheckRegistry_DLALoad.sql
**	  12/12/2016	mberenson			Return just the newest record
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
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_RegLoad.sql'
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
**		Date: 05/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/11/2009	ccarroll	initial
**		10/15/2007	ccarroll	added FirstName, LastName to select
**		01/24/2014	ccarroll	Changed Registry location to DMV_Common	
**		10/19/2016	mberenson	Added source column
**		12/22/2016	mberenson	Added source column (apparently not added earlier)
**		12/22/2016	mberenson	Limited row count to the top 1
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	DECLARE @RegistryOwnerId INT = 1, -- CODA
			@RegistryState NVARCHAR(10) = 'MA'; -- Web Donor State 
			
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
	AND ra.[State] = @RegistryState
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

	ORDER BY r.LastModified	DESC;

GO

GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistry_REGv2.sql'
GO

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



GO
PRINT 'C:\Statline\StatTrac\Development\CCRST234DLAIntegration\Serv\Registry\Data\Database\DMV_Common\Create Scripts\DMV_MA\sprocs\sps_CheckRegistryv2.sql'
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
**		Auth: ccarroll
**		Date: 05/11/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/11/2009	ccarroll	initial
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
