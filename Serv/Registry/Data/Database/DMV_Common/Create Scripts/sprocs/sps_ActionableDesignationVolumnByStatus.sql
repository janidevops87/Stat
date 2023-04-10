  
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
**		Date: 04/02/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      04/04/2008		ccarroll				initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT
		@StartDateTime = ISNULL(
								@StartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@EndDateTime = ISNULL	(
								@EndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)

DECLARE @TotalYes int
DECLARE @StateRegistryCount int
DECLARE @WebRegistryCount int 


DECLARE @SelectionTable TABLE
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
	)
	
DECLARE @CountTable TABLE
	(
		StateDisplayName		varchar(50) Null,
		SourceType				varchar(10) Null,
		DonorDesignationStatus	varchar(25)	Null,
		AgeRange				varchar(5)	Null,
		Gender					varchar(1)	Null,
		Number					int Null
	)

If @DMV = 1
BEGIN
/* Add donor detail for Registry*/
	INSERT @SelectionTable 

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
				(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
				
	
END


	
If @Reg = 1
BEGIN
/* Add donor detail for Registry*/
	INSERT @SelectionTable 

		SELECT DISTINCT
			-- Registry.ID AS 'SourceID',
			@StateDisplayName AS 'StateDisplayName',
			'Reg' 	AS 'SourceType',
			Firstname AS 'Firstname',
			LastName AS 'LastName',
			DOB AS 'DOB',
			Registry.LastModified AS 'LastModified', 

			/* Correlate donor histoy*/
			CASE 	WHEN PreviousDonorStateDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1) -- New Yes
						THEN 'New Yes'
					WHEN PreviousDonorStateDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1) -- Yes To Yes
						THEN 'Yes To Yes'
					WHEN PreviousDonorStateDonor = 1 AND (Donor = 0 AND DonorConfirmed = 1) -- Yes To No
						THEN 'Yes To No'
					WHEN PreviousDonorStateDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1) -- No To Yes
						THEN 'No To Yes'
					WHEN PreviousDonorStateDonor = 0 AND (Donor = 0 AND DonorConfirmed = 1) -- No To No
						THEN 'No To No'
					WHEN PreviousDonorStateDonorConfirmed Is Null AND (Donor = 0 AND DonorConfirmed = 1) -- New No
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
				(PreviousDonorStateDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
				(PreviousDonorStateDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
				(PreviousDonorStateDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
				THEN 1
				ELSE 0
			END AS TotalYes						
			
			
		FROM Registry 
		WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified <= @EndDateTime)
			AND DonorConfirmed = 1
			AND GENDER is Not Null  

			AND ((PreviousDonorStateDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
				(PreviousDonorStateDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
				(PreviousDonorStateDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
				(PreviousDonorStateDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes

				
			
END


	--Debug SELECT * FROM @SelectionTable

/* Remove duplicates 
	uses dervied Right to Left table comparision to 
	find duplicates in (@SelectionTable) and then removes them
	by deleting duplicates which do not have the most
	current (LastModified) date.
	Duplicates are based on the following criteria:
		- FirstName
		- LastName
		- DOB
*/
If IsNull(@DMV, 0) = 1 AND IsNull(@Reg, 0) = 1
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
END --Remove duplicates

IF @ReportFormat = 'Standard'
BEGIN
	INSERT @CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						'' AS 'Gender',
						Count(*) AS 'Number'
						
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus
						
						
/* Add Total Yes Counts for Standard */
	INSERT @CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						'' AS 'AgeRange',
						'' AS 'Gender',
						Sum(TotalYes) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType
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
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry'

			FROM @CountTable
			GROUP BY
						StateDisplayName,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus


END


IF @ReportFormat = 'Age'
BEGIN
	INSERT @CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						'' AS 'Gender',
						Count(*) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						AgeRange
						
						
						
/* Add Total Yes Counts for Age*/
	INSERT @CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						AgeRange,
						'' AS 'Gender',
						Sum(TotalYes) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						AgeRange
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
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry'

			FROM @CountTable
			GROUP BY
						StateDisplayName,
						AgeRange,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange



END


IF @ReportFormat = 'Gender'
BEGIN
	INSERT @CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						'' AS 'AgeRange',
						Gender,
						Count(*) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						Gender
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						Gender


/* Add Total Yes Counts for Gender*/
	INSERT @CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						'' AS 'AgeRange',
						Gender,
						Sum(TotalYes) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						Gender
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
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry'

			FROM @CountTable
			GROUP BY
						StateDisplayName,
						Gender,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						Gender




END

IF @ReportFormat = 'AgeGender'
BEGIN
	INSERT @CountTable

			SELECT
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						Gender,
						Count(*) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						DonorDesignationStatus,
						AgeRange,
						Gender
--			ORDER BY
--						StateDisplayName,
--						SourceType,
--						DonorDesignationStatus,
--						AgeRange,
--						Gender


/* Add Total Yes Counts for Age and Gender*/
	INSERT @CountTable
			
			SELECT
						StateDisplayName,
						SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						AgeRange,
						Gender,
						Sum(TotalYes) AS 'Number'
			FROM @SelectionTable
			GROUP BY
						StateDisplayName,
						SourceType,
						AgeRange,
						Gender
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
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry'

			FROM @CountTable
			GROUP BY
						StateDisplayName,
						AgeRange,
						Gender,
						DonorDesignationStatus
			ORDER BY
						StateDisplayName,
						DonorDesignationStatus,
						AgeRange,
						Gender



END

--SELECT * FROM @CountTable

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO