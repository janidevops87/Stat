if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Common_ActionableDesignationVolumeByStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_Common_ActionableDesignationVolumeByStatus'
	drop procedure [dbo].[sps_Common_ActionableDesignationVolumeByStatus]
END
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
PRINT 'Creating Procedure: sps_Common_ActionableDesignationVolumeByStatus'
GO

CREATE PROCEDURE sps_Common_ActionableDesignationVolumeByStatus
	@LastModifiedStartDateTime	SmallDateTime = NULL,
	@LastModifiedEndDateTime	SmallDateTime = NULL,
	@StateSelection	varchar(100) = NULL,
	@RegistryState			Bit = Null,
	@RegistryWeb			Bit = Null,
	@RegistryDla			BIT = NULL,
	@ReportFormat   varchar(25) = NULL /* Get Data Options: Determines the granularity returned
										 (1)Standard,
										 (2)Age,
										 (3)Gender,
										 (4)AgeGender
										*/  
AS
/******************************************************************************
**		File: sps_Common_ActionableDesignationVolumeCountsStatus.sql
**		Name: sps_Common_ActionableDesignationVolumeCountsStatus
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
**      12/12/2016		mberenson				Added DLA Registry
*******************************************************************************/
DECLARE @StateID int
DECLARE @StateDSN varchar(25)
DECLARE @StateDisplayName varchar(25)
DECLARE @SQLString varchar(500)


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


CREATE TABLE #TempReportTable
	(
		StateDisplayName				varchar(50) Null,
		DonorDesinationStatus			varchar(25)	Null,
		AgeRange						varchar(5)	Null,
		Gender							varchar(1)	Null,
		StateRegistry					int Null,
		WebRegistry						int Null,
		DlaRegistry						INT NULL
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


		SET @SQLString = 'sps_ActionableDesignationVolumeByStatus ''' +  
								CONVERT(varchar,@LastModifiedStartDateTime, 101) + ''', ''' +
								CONVERT(varchar,@LastModifiedEndDateTime, 101) + ''', ''' +
								CAST(@StateDisplayName AS varchar) + ''', ' +
								CAST(@RegistryState AS varchar) + ', ' +
								CAST(@RegistryWeb AS varchar) + ', ' +
								CAST(@RegistryDla AS varchar) + ', ''' +
								CAST(@ReportFormat AS varchar) + ''';';
		--PRINT @SQLString
		INSERT #TempReportTable
					EXEC (@StateDSN + '..' + @SQLString)

SET @StateID = (@StateID + 1)
END


/* Finial Select */
SELECT * FROM #TempReportTable

DROP TABLE #TempReportTable

GO
