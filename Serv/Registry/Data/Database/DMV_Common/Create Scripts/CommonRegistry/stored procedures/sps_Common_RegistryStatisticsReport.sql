
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Common_RegistryStatisticsReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_Common_RegistryStatisticsReport'
	drop procedure [dbo].[sps_Common_RegistryStatisticsReport]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_Common_RegistryStatisticsReport'
GO

CREATE PROCEDURE sps_Common_RegistryStatisticsReport
	@StateSelection	varchar(100) = NULL

AS
/******************************************************************************
**		File: sps_Common_RegistryStatisticsReport.sql
**		Name: sps_Common_RegistryStatisticsReport
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
**		Date: 04/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		04/14/2008		ccarroll				initial release
*******************************************************************************/
DECLARE @StateID int
DECLARE @StateDSN varchar(25)
DECLARE @StateDisplayName varchar(25)
DECLARE @SQLString varchar(500)

DECLARE @StateTable Table
	(
		ID					int IDENTITY (1, 1) NOT NULL,
		State				varchar(25) Null,
		DSN					varchar(25) Null,
		StateDisplayName	varchar(50) Null
	)


CREATE TABLE #TempReportTable
	(
		StateDisplayName		varchar(50) Null,
		RegistrySource			varchar(50) Null,
		Totals					int Null,
		TotalPercent			varchar(50) Null,
		GrandTotal				int
	)
	

/* Get State data for report*/
Insert @StateTable
		SELECT State, DSN, StateDisplayName
		FROM StateDSNLookup 
		WHERE State IN(SELECT * FROM dbo.ParseVarcharValueString(@StateSelection))


/* Build report data for each State selected */
SET @StateID = 1

WHILE (Select Count(*) FROM @StateTable WHERE ID = @StateID) > 0
BEGIN

		SET @StateDSN = (Select DSN FROM @StateTable WHERE ID = @StateID)
		SET @StateDisplayName = (Select StateDisplayName FROM @StateTable WHERE ID = @StateID)


		SET @SQLString = 'sps_RegistryStatisticsReport @StateDisplayName=' + CHAR(39)  
								+ CAST(@StateDisplayName AS varchar) + CHAR(39)
								
		--PRINT @SQLString
		INSERT #TempReportTable
					EXEC (@StateDSN + '..' + @SQLString)

SET @StateID = (@StateID + 1)
END





/* Finial Select */
DECLARE @GrandTotal Int

SET @GrandTotal = (SELECT SUM(GrandTotal) FROM #TempReportTable)

INSERT #TempReportTable (
		StateDisplayName,
		RegistrySource,
		Totals,
		TotalPercent,
		GrandTotal
) VALUES(
		'',
		'Grand Total',
		@GrandTotal,
		'',
		''
)


SELECT * FROM #TempReportTable


DROP TABLE #TempReportTable

GO
