  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryLabelsReport]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryLabelsReport]
	PRINT 'Dropping Procedure: GetRegistryLabelsReport'
END
	PRINT 'Creating Procedure: GetRegistryLabelsReport'
GO


CREATE PROCEDURE [dbo].[GetRegistryLabelsReport]
	@StartDateTime		datetime = Null,
	@EndDateTime		datetime = Null,
	@Source				int = NULL,
	@StateSelection		varchar(100),
	@DonorStatus		int = NULL,
	@RegistryOwnerID int = Null
AS
/******************************************************************************
**		File: GetRegistryLabelsReport.sql
**		Name: GetRegistryLabelsReport
**		Desc: For release to: DMV_Common
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
**		Date: 03/10/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**		03/10/2011		ccarroll		initial
**		01/05/2015		Bret			Modify select statement to only pull state DMV data 
*******************************************************************************/

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE @StateID int
DECLARE @SourceState varchar(2)
DECLARE @StateDSN varchar(25)
DECLARE @SQLString varchar(500)




	-- Get RegistryOwnerID from State selection list if does not exist 
	SET @RegistryOwnerID = (SELECT TOP 1 RegistryOwnerID
						FROM RegistryOwnerStateConfig
						WHERE RIGHT(RegistryOwnerStateDMVDSN,2)IN (SELECT * FROM dbo.ParseVarcharValueString(@StateSelection)))
						
						
/* Source Definitions
0 - None
1 - Web Registry
2 - State Registry
3 - Pending Registrants (Web)
4 - State Registry - Info Request (DMV)
*/


DECLARE @StateTable Table
	(
		ID					int IDENTITY (1, 1) NOT NULL,
		State				varchar(25) Null,
		DSN					varchar(25) Null
	)


CREATE TABLE #TempRegistryLabelsReportTable
	(
		RegistryLabelsReportFirstName			varchar(50)	Null,
		RegistryLabelsReportMiddleName			varchar(50)	Null,
		RegistryLabelsReportLastName			varchar(50)	Null,
		RegistryLabelsReportSuffix				varchar(4)	Null,
		RegistryLabelsReportAddr1				varchar(40)	Null,
		RegistryLabelsReportAddr2				varchar(40)	Null,
		RegistryLabelsReportCity				varchar(25)	Null,
		RegistryLabelsReportState				varchar(2)	Null,
		RegistryLabelsReportZip					varchar(10)	Null,
		RegistryLabelsReportDOB					varchar(10) Null,
		RegistryLabelsReportDonor				varchar(1) Null,
		RegistryLabelsReportDatetime			varchar(50) Null,
		RegistryLabelsReportSorceCode			varchar(50) Null
	)
	
IF IsNull(@Source, 0) IN(2, 4) AND LEN(IsNull(@StateSelection, '')) > 1
/* Begin DMV Selection 
	2 - State Registry
	4 - State Registry - Info Request (DMV)
*/
BEGIN
	
/* Get DMV State DSNs*/
Insert @StateTable

	SELECT  distinct dbo.statedsnlookup.state , RegistryOwnerStateDMVDSN
		FROM RegistryOwnerStateConfig 
		join dbo.RegistryOwner on  RegistryOwnerStateConfig.RegistryOwnerID = dbo.RegistryOwner.RegistryOwnerID

		join dbo.StateDSNLookup on RegistryOwnerStateConfig.RegistryOwnerStateDMVDSN =  dbo.statedsnlookup.DSN
		where dbo.statedsnlookup.State in (SELECT * FROM dbo.ParseVarcharValueString(@StateSelection))
		AND dbo.RegistryOwner.RegistryOwnerID = @RegistryOwnerID


/* Build report for DMVs selected */
SET @StateID = 1

WHILE (Select Count(*) FROM @StateTable WHERE ID = @StateID) > 0
BEGIN

		SET @StateDSN = (Select DSN FROM @StateTable WHERE ID = @StateID)
		SET @SourceState = (Select State FROM @StateTable WHERE ID = @StateID)
		
		SET @SQLString = 'GetRegistryLabelsDMV_select ' +  
						CASE WHEN @StartDateTime Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@StartDatetime AS varchar) + CHAR(39)+', 'END +
						CASE WHEN @EndDateTime Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@EndDatetime AS varchar) + CHAR(39)+', 'END +
						CASE WHEN @Source Is Null THEN 'Null, ' ELSE CAST(@Source AS varchar) +', 'END +
						CASE WHEN @DonorStatus Is Null THEN 'Null' ELSE  CAST(@DonorStatus AS varchar)+ ';'END

		--PRINT @StateDSN + '..' + @SQLString
		--PRINT @StateID
		INSERT #TempRegistryLabelsReportTable
					EXEC (@StateDSN + '..' + @SQLString)
		

SET @StateID = (@StateID + 1)
END --Build report for DMVs selected (Loop) 

END --DMV Selection

IF IsNull(@Source, 0) IN(1, 3)
/* Begin Web Labels 
	1 - Web Registry
	3 - Pending Registrants (Web)
*/
BEGIN

--DECLARE @RegistryOwnerID Int = 0

		SET @SQLString = 'GetRegistryLabelsWeb_select ' +  
						CASE WHEN @StartDateTime Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@StartDatetime AS varchar) + CHAR(39)+', 'END +
						CASE WHEN @EndDateTime Is Null THEN 'Null, ' ELSE CHAR(39) + CAST(@EndDatetime AS varchar) + CHAR(39)+', 'END +
						CASE WHEN @Source Is Null THEN 'Null, ' ELSE  CAST(@Source AS varchar) +', 'END +
						CASE WHEN @DonorStatus Is Null THEN 'Null, ' ELSE  CAST(@DonorStatus AS varchar)+ ', 'END +
						CASE WHEN @RegistryOwnerID Is Null THEN 'Null' ELSE  CAST(@RegistryOwnerID AS varchar)+ ';'END
							
		--PRINT @SQLString
		INSERT #TempRegistryLabelsReportTable
					EXEC (@SQLString)

END


/* Finial Select 
DECLARE @MaxLimit Int
DECLARE @MaxLimitMessage varchar(200)

SET @MaxLimit = 80000
SET @MaxLimitMessage = 'This search exceeds the current limit of ' + CAST(@MaxLimit AS varchar) + ' records '

IF (SELECT Count(*) FROM #TempRegistryLabelsReportTable) <= @MaxLimit
*/
BEGIN
	SELECT 

		RegistryLabelsReportFirstName,
		RegistryLabelsReportMiddleName,
		RegistryLabelsReportLastName,
		RegistryLabelsReportSuffix,
		RegistryLabelsReportAddr1,
		RegistryLabelsReportAddr2,
		RegistryLabelsReportCity,
		RegistryLabelsReportState,
		RegistryLabelsReportZip,
		RegistryLabelsReportDOB,
		RegistryLabelsReportDonor,
		RegistryLabelsReportDatetime,
		RegistryLabelsReportSorceCode

		
	FROM #TempRegistryLabelsReportTable

END
/*
ELSE
BEGIN
	RAISERROR(@MaxLimitMessage, 11, 1)
END
*/

GO