if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Common_ActionableDesignationVolumeByZipCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_Common_ActionableDesignationVolumeByZipCode'
	drop procedure [dbo].[sps_Common_ActionableDesignationVolumeByZipCode]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_Common_ActionableDesignationVolumeByZipCode'
GO

CREATE PROCEDURE sps_Common_ActionableDesignationVolumeByZipCode
	@LastModifiedStartDateTime	DateTime = NULL,
	@LastModifiedEndDateTime	DateTime = NULL,
	@ZipCodeOptions	 Int = NULL,
	@ZipCodeData varchar(2000) = NULL,
	@StateSelection	varchar(100) = NULL,
	@RegistryState			Bit = Null,
	@RegistryWeb			Bit = Null,
	@RegistryDla			BIT = NULL

AS
/******************************************************************************
**		File: sps_Common_ActionableDesignationVolumeCountsZipCode.sql
**		Name: sps_Common_ActionableDesignationVolumeCountsZipCode
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
**		04/16/2008		ccarroll				initial release
**		05/12/2008		ccarroll				Added 'SortTotals' field to #TempZipCodeReportTable
**      12/12/2016		mberenson				Added DLA Registry
*******************************************************************************/
DECLARE @StateID int
DECLARE @StateDSN varchar(25)
DECLARE @StateDisplayName varchar(25)
DECLARE @SQLString varchar(2000)


/* Convert Null value to string value */
If @ZipCodeData Is Null
	BEGIN
		SET @ZipCodeData = 'NULL'
	END
ELSE
	BEGIN
		SET @ZipCodeData = Char(39) + @ZipCodeData + Char(39)
	END

SELECT
		@LastModifiedStartDateTime = ISNULL(
								@LastModifiedStartDateTime, 
								CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@LastModifiedEndDateTime = ISNULL	(
								@LastModifiedEndDateTime, 
								CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
								)


DECLARE @StateTable Table
	(
		ID					int IDENTITY (1, 1) NOT NULL,
		State				varchar(25) Null,
		DSN					varchar(25) Null,
		StateDisplayName	varchar(50) Null
	)


CREATE TABLE #TempZipCodeReportTable
	(
		StateDisplayName				varchar(50) Null,
		HighestLowestProducing			varchar(50) Null,
		Zipcode							varchar(10) NuLL,		
		DonorDesinationStatus			varchar(25)	Null,
		StateRegistry					int Null,
		WebRegistry						int Null,
		DlaRegistry						INT NULL,
		SortTotals						int Null
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


		SET @SQLString = 'sps_ActionableDesignationVolumeByZipCode ''' +  
								CONVERT(varchar,@LastModifiedStartDateTime, 0) + ''', ''' +
								CONVERT(varchar,@LastModifiedEndDateTime, 0) + ''', ' +
								CAST(@ZipCodeOptions AS varchar) + ', ' +
								CAST(@ZipCodeData AS varchar(2000)) + ', ''' +
								CAST(@StateDisplayName AS varchar) + ''', ' +
								CAST(@RegistryState AS varchar) + ', ' +
								CAST(@RegistryWeb AS varchar) + ', ' +
								CAST(@RegistryDla AS VARCHAR) + ';';
		--PRINT @ZipCodeData
		--PRINT @SQLString
		INSERT #TempZipCodeReportTable
					EXEC (@StateDSN + '..' + @SQLString)

SET @StateID = (@StateID + 1)
END


/* Finial Select */
SELECT * FROM #TempZipCodeReportTable;

DROP TABLE #TempZipCodeReportTable;

GO
