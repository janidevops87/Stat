USE DMV_RI
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
**		Desc: Uses Common registry (RI)
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
				(PreviousDonorState = 0 AND Donor = 1))	;	  -- No To Yes
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
			AND RegistryAddr.State = 'RI'
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