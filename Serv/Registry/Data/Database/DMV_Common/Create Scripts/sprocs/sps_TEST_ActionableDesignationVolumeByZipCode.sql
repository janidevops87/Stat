/*
Exec sps_TEST_ActionableDesignationVolumeByZipCode '05/05/2008 00:00', '05/30/2008 23:59', 1, Null, 'Colorado', 1, 1 

	@StartDateTime			DATETIME = NULL,
	@EndDateTime			DATETIME = NULL,
	@ZipCodeOptions			Int = NULL,
	@ZipCodeData			varchar(2000) = NULL,
	@StateDisplayName		varchar(50) = NULL,
	@DMV					Bit = Null,
	@Reg					Bit = Null
*/


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_TEST_ActionableDesignationVolumeByZipCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_TEST_ActionableDesignationVolumeByZipCode'
	drop procedure [dbo].[sps_TEST_ActionableDesignationVolumeByZipCode]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_TEST_ActionableDesignationVolumeByZipCode'
GO

CREATE PROCEDURE sps_TEST_ActionableDesignationVolumeByZipCode
	@StartDateTime			DATETIME = NULL,
	@EndDateTime			DATETIME = NULL,
	@ZipCodeOptions			Int = NULL,
	@ZipCodeData			varchar(2000) = NULL,
	@StateDisplayName		varchar(50) = NULL,
	@DMV					Bit = Null,
	@Reg					Bit = Null

					/* @ZipCodeoptions Int
						1 = Top 10 Higest and Lowest Producing Zip Codes
						2 = Many (or Single) Zip Code(s)
						3 = Return All Zip Codes 
					*/
	
AS
/******************************************************************************
**		File: sps_ActionableDesignationVolumeByZipCode.sql
**		Name: sps_ActionableDesignationVolumeByZipCode
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
**		Date: 04/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      04/16/2008		ccarroll				initial
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

IF @ZipCodeOptions = 3
  BEGIN
	SET @ZipCodeData = Null
  END

DECLARE @TotalYes int
DECLARE @StateRegistryCount int
DECLARE @WebRegistryCount int
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

DECLARE @ZipCodeTable TABLE
	(
		ZipCode					varchar(10) Null,
		ZipCodeCount				int Null,
		HighestLowestName			varchar(50),
		SourceType				varchar(10)
	)




	If @DMV = 1 
	BEGIN	--Begin DMV Zip Code selection

	/* Create Top 10 ZipCode List for DMV*/
		INSERT  @ZipCodeTable --Highest Zip Codes
		SELECT TOP 10
			Zip AS 'ZipCode',
			Count(DMV.Donor) AS 'ZipCodeCount',
			'Top 10 Highest Producing Zip Codes' AS 'HighestLowestName',
			'DMV' AS 'SourceType'
			FROM DMV
			JOIN DMVADDR ON DMV.ID = DMVADDR.DMVID AND (DMVADDR.AddrTypeID = 1)
			WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified <= @EndDateTime)
				/* Only Select ActionableDesignationVolume Items */
				AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
				(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
				(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
			Group By
				Zip
			Order BY
			Count(DMV.DONOR) DESC

		INSERT  @ZipCodeTable --Lowest Zip Codes
		SELECT TOP 10
			Zip AS 'ZipCode',
			Count(DMV.Donor) AS 'ZipCodeCount',
			'Top 10 Lowest Producing Zip Codes' AS 'HighestLowestName',
			'DMV' AS 'SourceType' 

			FROM DMV
			JOIN DMVADDR ON DMV.ID = DMVADDR.DMVID AND (DMVADDR.AddrTypeID = 1)
			WHERE (DMV.LastModified >= @StartDateTime AND DMV.LastModified <= @EndDateTime)
				/* Only Select ActionableDesignationVolume Items */
				AND ((PreviousDonorState Is Null AND Donor = 1) OR -- New Yes
				(PreviousDonorState = 1 AND Donor = 1) OR	  -- Yes To Yes
				--(PreviousDonorState = 1 AND Donor = 0) OR	  -- Yes To No
				(PreviousDonorState = 0 AND Donor = 1))		  -- No To Yes
			Group By
				Zip
			Order BY
			Count(DMV.DONOR) 

	END	--End DMV Zip Code selection
	


	If @Reg = 1 
	BEGIN	--Begin Registry Zip Code selection

	/* Create Top 10 ZipCode List for Registry*/
		INSERT  @ZipCodeTable --Highest Zip Codes
			SELECT  TOP 10
				Zip AS 'ZipCode',
				Count(Registry.Donor),
				'Top 10 Highest Producing Zip Codes' AS 'HighestLowestName',
				'Reg' AS 'SourceType'
			
			FROM Registry
			JOIN RegistryADDR ON Registry.ID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified < @EndDateTime)
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorStateDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonorStateDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
					--(PreviousDonorStateDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
					(PreviousDonorStateDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes
			Group By
				Zip
			Order BY
			Count(Registry.DONOR) DESC 


		INSERT  @ZipCodeTable --Lowest Zip Codes
			SELECT  TOP 10
				Zip AS 'ZipCode',
				Count(Registry.Donor),
				'Top 10 Lowest Producing Zip Codes' AS 'HighestLowestName',
				'Reg' AS 'SourceType'
			
			FROM Registry
			JOIN RegistryADDR ON Registry.ID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified < @EndDateTime)
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorStateDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonorStateDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR				 -- Yes To Yes
					--(PreviousDonorStateDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR				 -- Yes To No
					(PreviousDonorStateDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))				 -- No To Yes
			Group By
				Zip
			Order BY
			Count(Registry.DONOR) 

	END	--End Registry Code selection



/* Limit Zip Codes to only 10 Higher and 10 Lower 
	If both DMV and Reg are selected, up to 40 zip codes could be returned in the list, Therefore, only 10 of the Highest and 
	Lowest combined (Reg and DMV) zip codes should be returned. Note, it is possible for more than 10 zip codes to be 
	returned in a group because the same zip code may be shared for DMV and Reg numbers. This, however, should be consolidated
	when the report group the results*/
	 
IF @DMV = 1 AND @Reg = 1 AND @ZipCodeOptions = 1
	BEGIN
	 -- Remove unwanted Highest zipcodes
	DELETE @ZipCodeTable WHERE ZipCode NOT in 
		(SELECT DISTINCT TOP 10 ZipCode FROM @ZipCodeTable --<ccTest>--
		 WHERE HighestLowestName = 'Top 10 Highest Producing Zip Codes'
		 GROUP BY ZipCode, HighestLowestName, ZipCodeCount --<ccTest>--
		 ORDER BY ZipCodeCount DESC)
		AND HighestLowestName = 'Top 10 Highest Producing Zip Codes'

	-- Remove unwanted Lowest zipcodes
	DELETE @ZipCodeTable WHERE ZipCode NOT in 
		(SELECT TOP 10 ZipCode FROM @ZipCodeTable
		 WHERE HighestLowestName = 'Top 10 Lowest Producing Zip Codes'
		 GROUP BY ZipCode, ZipCodeCount --<ccTest>--
		 ORDER BY ZipCodeCount)
		AND HighestLowestName = 'Top 10 Lowest Producing Zip Codes'

	/*Debug */
		SELECT * FROM @ZipCodeTable
		ORDER BY HighestLowestName, ZipCodeCount
	END

/* Convert Zipcode table to String for use with Patindex 
   also limit to top 10 combined Registry and DMV*/
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
		PRINT @ZipCodeData
		CLOSE ZipCode_Cursor
		DEALLOCATE ZipCode_Cursor

END -- @ZipCodeOptions = 1, Top 10 Higest and Lowest Producing Zip Codes 

	/* Note: The following selection is for all @ZipCodeOptions-
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
				AND PATINDEX('%'+ DMVADDR.Zip + '%', IsNull(@ZipCodeData, DMVADDR.Zip)) > 0
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
				-- Registry.ID AS 'SourceID',
				@StateDisplayName AS 'StateDisplayName',
				Zip AS 'ZipCode',
				'Reg'AS 'SourceType',
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

				/* Total Yes Count */
				CASE WHEN
					(PreviousDonorStateDonorConfirmed Is Null AND (Donor = 1 AND DonorConfirmed = 1)) OR -- New Yes
					(PreviousDonorStateDonor = 1 AND (Donor = 1 AND DonorConfirmed = 1)) OR -- Yes To Yes
					(PreviousDonorStateDonor = 0 AND (Donor = 1 AND DonorConfirmed = 1)) -- No To Yes
					THEN 1
					ELSE 0
				END AS TotalYes						
				
			FROM Registry
			JOIN RegistryADDR ON Registry.ID = RegistryADDR.RegistryID AND (RegistryADDR.AddrTypeID = 1)
			WHERE 	(Registry.LastModified >= @StartDateTime AND Registry.LastModified < @EndDateTime)
				AND PATINDEX('%'+ RegistryADDR.Zip + '%', IsNull(@ZipCodeData, RegistryADDR.Zip)) > 0
				AND DonorConfirmed = 1
				AND GENDER is Not Null  
				AND ((PreviousDonorStateDonorConfirmed Is Null AND Donor = 1 AND DonorConfirmed = 1) OR -- New Yes
					(PreviousDonorStateDonor = 1 AND Donor = 1 AND DonorConfirmed = 1) OR	 -- Yes To Yes
					(PreviousDonorStateDonor = 1 AND Donor = 0 AND DonorConfirmed = 1) OR	 -- Yes To No
					(PreviousDonorStateDonor = 0 AND Donor = 1 AND DonorConfirmed = 1))	 -- No To Yes

	END -- @Reg = 1 Selection

--Debug
 SELECT * FROM @SelectionTable

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
END

If @ZipCodeOptions = 1 /* Top 10 Higest and Lowest Producing Zip Codes */
BEGIN	
/* Populate CountTable using temporary Zip Code table- counts*/	

	INSERT @CountTable
			SELECT DISTINCT
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
						st.SourceType, --<MOVED>--
						HighestLowestName,
						st.ZipCode,
						DonorDesignationStatus

/* Populate CountTable with 'Total Yes' counts */
	INSERT @CountTable
			
			SELECT  DISTINCT
						StateDisplayName,
						HighestLowestName AS 'HightestLowestProducing',
						st.Zipcode,
						st.SourceType,
						'Total Yes' AS 'DonorDesignationStatus',
						Sum(TotalYes) AS 'Number'
			FROM @SelectionTable st
			JOIN (SELECT DISTINCT ZipCode, HighestLowestName FROM @ZipCodeTable)zt ON  zt.ZipCode = st.ZipCode
--			JOIN @ZipCodeTable zt ON  zt.ZipCode = st.ZipCode AND zt.SourceType = st.SourceType
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
			
			SELECT DISTINCT
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
			
			SELECT DISTINCT
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


SELECT * FROM @CountTable
/*
			SELECT 
						StateDisplayName,
						HighestLowestProducing,
						ZipCode,
						--SourceType,
						DonorDesignationStatus,
						SUM(CASE WHEN SourceType = 'DMV' THEN Number Else 0 END)AS 'StateRegistry', 
						SUM(CASE WHEN SourceType = 'Reg' THEN Number ELSE 0 END)AS 'WebRegistry'

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

*/
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO