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