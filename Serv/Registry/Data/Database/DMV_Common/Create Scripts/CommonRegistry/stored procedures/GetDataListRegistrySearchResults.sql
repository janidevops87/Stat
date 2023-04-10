 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetDataListRegistrySearchResults]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetDataListRegistrySearchResults]
	PRINT 'Dropping Procedure: GetDataListRegistrySearchResults'
END
	PRINT 'Creating Procedure: GetDataListRegistrySearchResults'
GO

CREATE PROCEDURE [dbo].[GetDataListRegistrySearchResults]
	@FirstName varchar(40) = NULL,
	@MiddleName varchar(40) = NULL,
	@LastName varchar(40) = NULL,
	@City varchar(40) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(40) = NULL,
	@License  nvarchar(20) = NULL,		 /* May also be State ID */
	@WebRegistryID int = NULL,
	@DOB	datetime = NULL,

	@DisplayWebDonors			Bit = NULL,
	@DisplayDMVDonors			Bit = NULL,
	@DisplayWebPendingSignature	Bit = NULL, /* Web Registry */
	@DisplayDMVDonorsYesOnly	Bit = NULL, /* DMV Registry */
	@DisplayNoDonors			Bit = Null,  

	@StateSelection	varchar(100) = NULL,
	@RegistryOwnerID int = NULL /* Used for Registry Search */

AS
/******************************************************************************
**		File: GetDataListRegistrySearchResults.sql
**		Name: GetDataListRegistrySearchResults
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
**		Auth: Chris Carroll	
**		Date: 02/26/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**		02/26/2008		Chris Carroll		initial release
**		05/12/2010		Chris Carroll		Added @RegistryOwnerID to search
**		01/11/2011		Chris Carroll		Bug Fix for wi-9231, HS-25889 (RegistrySearchResultSourceState)
**		02/09/2011		Chris Carroll		Added RegistryOwnerID for State selection of DMV searches
**		07/19/2013		Chris Carroll		Added @DisplayNoDonor, @License changed sort order
**		02/26/2014		Chris Carroll		Fixed DMV Display No Donor issue
**		05/23/2014		Moonray Schepart	Enabled Registry checks for Gift Of Life Michigan in DMV Database (Not DMV_Common!)
**		08/14/2014		Moonray Schepart	Increased license to 20 characters (CCRST196)
**		08/15/2014		Moonray Schepart	Strip Special Characters from name before submitting search (CCRST196)
**		08/27/2015		Ed Hawkes			Drop temp table on exit 
**		01/14/2016		Andriy Mazur    	Refactor Zip filter to use widechar.
*******************************************************************************/
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @StateID int,
		@SourceState varchar(2),
		@StateDSN varchar(25),
		@DMVSqlString varchar(500),
		@WebSqlString varchar(500),
		@RegistryOwnerName nvarchar(50);

/* 	If  @DisplayNoDonors is false then @DisplayDMVDonorsYesOnly is true */
IF COALESCE(@DisplayNoDonors, 0) = 0
BEGIN
	SET @DisplayDMVDonorsYesOnly = 1;
END 


/* Allows passing either "*", -1, '01/01/1900' or null as a wildcard */
IF	IsNull(@State,'*') = '*' BEGIN SELECT  @State = NULL END;
IF	IsNull(@License,'*') = '*' BEGIN SELECT  @License = NULL END;
IF	IsNull(@WebRegistryID, -1) = -1 BEGIN SELECT  @WebRegistryID = NULL END;
IF	IsNull(@DOB, '01/01/1900') = '01/01/1900' BEGIN SELECT  @DOB = NULL END;

/* Strip Wildcards for patindex use
	if wildcard(*) is omitted, searches will return
	exact match only.
*/

IF @FirstName = '*'
BEGIN SET @FirstName = Null END ELSE
BEGIN SET @FirstName = REPLACE(dbo.FormatNameForStatTracSearch(@FirstName), '*', '') END;

IF @MiddleName = '*'
BEGIN SET @MiddleName = Null END ELSE
BEGIN SET @MiddleName = REPLACE(dbo.FormatNameForStatTracSearch(@MiddleName), '*', '') END;

IF @LastName = '*'
BEGIN SET @LastName = Null END ELSE
BEGIN SET @LastName = REPLACE(dbo.FormatNameForStatTracSearch(@LastName), '*', '') END;

IF @City = '*'
BEGIN SET @City = Null END ELSE
BEGIN SET @City = REPLACE(@City, '*', '') END;

IF @Zip = '*'
BEGIN SET @Zip = Null END ELSE
BEGIN SET @Zip = REPLACE(@Zip, '*', '') END;

IF @License = '*'
BEGIN SET @License = Null END ELSE
BEGIN SET @License = REPLACE(@License, '*', '') END;

SELECT @RegistryOwnerName = RegistryOwnerName FROM RegistryOwner WHERE RegistryOwnerID = @RegistryOwnerID;

DECLARE @StateTable Table
	(
		ID					int IDENTITY (1, 1) NOT NULL,
		State				varchar(25) Null,
		DSN					varchar(25) Null
	);


IF OBJECT_ID('tempdb..#TempRegistrySearchResultsTable') IS NOT NULL
DROP TABLE #TempRegistrySearchResultsTable;

CREATE TABLE #TempRegistrySearchResultsTable
	(
		RegistrySearchResultSourceName			varchar(50) Null,
		RegistrySearchResultSourceState			varchar(20) Null,
		RegistrySearchResultSourceID			varchar(20) NULL,
		RegistrySearchResultFirstName			varchar(40)	Null,
		RegistrySearchResultMiddleName			varchar(40)	Null,
		RegistrySearchResultLastName			varchar(50)	Null,
		RegistrySearchResultVerificationForm	varchar(50) Null,
		RegistrySearchResultDOB					varchar(10) Null,
		RegistrySearchResultSID					varchar(20) Null,
		RegistrySearchResultAddress				varchar(40)	Null,
		RegistrySearchResultCity				varchar(25)	Null,
		RegistrySearchResultState				varchar(2)	Null,
		RegistrySearchResultZip					varchar(10)	Null,
		RegistrySearchResultDonorDate			varchar(50) Null,
		RegistrySearchResultDonorActivityDate	datetime Null,
		RegistrySearchResultDonorStatus			varchar(50) Null,
		RegistrySearchResultDonorConfirmed		varchar(1) Null
	);

	
/* Get State data for report*/
IF LEN(IsNull(@StateSelection, '')) > 1
BEGIN
	IF @RegistryOwnerName = 'MIOP' AND IsNull(@DisplayDMVDonors, 0) = 1 
	BEGIN	 
		INSERT @StateTable 
			SELECT 'MI', 'DMV_MI_SOS' FROM (SELECT * FROM dbo.ParseVarcharValueString(@StateSelection) WHERE StringValue = 'MI SOS') a;
		INSERT @StateTable 
			SELECT 'MI', 'DMV_MI' FROM (SELECT * FROM dbo.ParseVarcharValueString(@StateSelection) WHERE StringValue = 'MI Legacy') a;
	END
	ELSE
	BEGIN
		INSERT @StateTable
			SELECT RegistryOwnerStateAbbrv, RegistryOwnerStateDMVDSN
			FROM RegistryOwnerStateConfig 
			WHERE RegistryOwnerStateAbbrv IN(SELECT * FROM dbo.ParseVarcharValueString(@StateSelection))
				AND RegistryOwnerID = IsNull(@RegistryOwnerID, RegistryOwnerID)
	END
END


SET @DMVSqlString = 'GetDMVRegistrySearchResults_Select ' +  
				CASE WHEN @FirstName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@FirstName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @MiddleName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@MiddleName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @LastName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@LastName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @City Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@City AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @State Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@State AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @Zip Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@Zip AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @License Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@License AS varchar)  + CHAR(39)+', 'END +
				CASE WHEN @DOB Is Null THEN 'Null, ' ELSE CHAR(39) + CONVERT(varchar,@DOB, 101)  + CHAR(39)+', 'END +
				CASE WHEN @DisplayDMVDonorsYesOnly Is Null THEN 'Null' ELSE  CAST(@DisplayDMVDonorsYesOnly AS varchar)+ ';'END;

SET @WebSqlString = 'GetWebRegistrySearchResults_Select ' +  
				CASE WHEN @FirstName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@FirstName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @MiddleName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@MiddleName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @LastName Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@LastName AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @City Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@City AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @State Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@State AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @Zip Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@Zip AS varchar) + CHAR(39)+', 'END +
				CASE WHEN @WebRegistryID Is Null THEN 'Null, ' ELSE  CAST(@WebRegistryID AS varchar) + ', ' END +
				CASE WHEN @DOB Is Null THEN 'Null, ' ELSE CHAR(39) + CONVERT(varchar,@DOB, 101)  + CHAR(39)+', 'END +
				CASE WHEN @DisplayWebPendingSignature Is Null THEN 'Null, ' ELSE CAST(@DisplayWebPendingSignature AS varchar) + ', 'END +
				CASE WHEN @RegistryOwnerID Is Null THEN 'Null, ' ELSE CAST(@RegistryOwnerID AS varchar) + ','END +
				CASE WHEN @DisplayNoDonors Is Null THEN 'Null, ' ELSE CAST(@DisplayNoDonors AS varchar) + ','END +
				CASE WHEN @License Is Null THEN 'Null' ELSE CHAR(39) + CAST(@License AS nvarchar) + CHAR(39)+ ';'END;

/* Perform Web Search First since there is no Branch Number  */
IF IsNull(@DisplayWebDonors, 0) = 1
BEGIN											 		
		-- PRINT @WebSqlString;
		
		INSERT #TempRegistrySearchResultsTable
		EXEC (@WebSqlString);		
END

 
/* Alter Temp Table to Accomodate MIOP Branch Number */
IF @RegistryOwnerName = 'MIOP' AND IsNull(@DisplayDMVDonors, 0) = 1 
BEGIN	 
	ALTER TABLE #TempRegistrySearchResultsTable 
		ADD RegistrySearchResultBranchNumber nvarchar(50) null;		
END

IF IsNull(@DisplayDMVDonors, 0) = 1 AND LEN(IsNull(@StateSelection, '')) > 1 AND @WebRegistryID IS NULL
BEGIN
	
	/* Build report data for DMVs selected */
	SET @StateID = 1

	WHILE (Select Count(*) FROM @StateTable WHERE ID = @StateID) > 0
	BEGIN

			SET @StateDSN = (Select DSN FROM @StateTable WHERE ID = @StateID)
			SET @SourceState = (Select State FROM @StateTable WHERE ID = @StateID)	

			-- PRINT @StateDSN + '..' + @DMVSqlString
			INSERT #TempRegistrySearchResultsTable
						EXEC (@StateDSN + '..' + @DMVSqlString)

			--Update DMV Source With state where found
			UPDATE #TempRegistrySearchResultsTable 
				SET RegistrySearchResultSourceState = 
					CASE 
						WHEN @RegistryOwnerName = 'MIOP' THEN CASE WHEN @StateDSN = 'DMV_MI_SOS' THEN 'MI SOS' ELSE 'MI Legacy' END
						ELSE @SourceState 
					END
			WHERE RegistrySearchResultSourceState IS Null

	SET @StateID = (@StateID + 1)
	END --DMV State Loop 

END --DMV General Search



/* Finial Select */
DECLARE @MaxLimit Int,
		@MaxLimitMessage varchar(200);

SET @MaxLimit = 200;
SET @MaxLimitMessage = 'This search exceeds the current limit of ' + CAST(@MaxLimit AS varchar) + ' records ';

IF (SELECT Count(*) FROM #TempRegistrySearchResultsTable) <= @MaxLimit
BEGIN
	/* Alter Temp Table to Accomodate MIOP Branch Number If Branch Number Column Does Not Exists */
	IF NOT EXISTS (SELECT * FROM TempDB.INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'RegistrySearchResultBranchNumber' AND TABLE_NAME LIKE '#TempRegistrySearchResultsTable%')
		BEGIN					 				
			ALTER TABLE #TempRegistrySearchResultsTable 
				ADD RegistrySearchResultBranchNumber nvarchar(50) null;		
		END	

	SELECT 
		RegistrySearchResultSourceName,
		RegistrySearchResultSourceState,
		RegistrySearchResultSourceID,
		RegistrySearchResultFirstName,
		RegistrySearchResultMiddleName,
		RegistrySearchResultLastName,
		RegistrySearchResultVerificationForm,
		RegistrySearchResultDOB,
		RegistrySearchResultSID,
		RegistrySearchResultAddress,
		RegistrySearchResultCity,
		RegistrySearchResultState,
		RegistrySearchResultZip,
		RegistrySearchResultDonorDate,
		CASE WHEN PATINDEX('Y', RegistrySearchResultDonorStatus) > 0
			 THEN 'Yes on Registry'
			 Else 'Not on Registry'
		END AS [RegistrySearchResultDonorStatus],
		RegistrySearchResultDonorConfirmed		,
		RegistrySearchResultBranchNumber
		
	FROM #TempRegistrySearchResultsTable
	ORDER BY 
	RegistrySearchResultSourceName DESC,
	RegistrySearchResultLastName,
	RegistrySearchResultFirstName,
	RegistrySearchResultDonorActivityDate DESC,
	RegistrySearchResultZip

END
ELSE
BEGIN
	RAISERROR(@MaxLimitMessage, 11, 1)
END

IF OBJECT_ID('tempdb..#TempRegistrySearchResultsTable') IS NOT NULL
DROP TABLE #TempRegistrySearchResultsTable; 
GO



