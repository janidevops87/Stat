SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_CallCounts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_CallCounts]
GO


CREATE PROCEDURE sps_COD_CallCounts
	@vOrgID	int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null
AS

SET NOCOUNT ON
/********************************************************************************/
/*	Create Temporary tables 					*/
/********************************************************************************/

CREATE TABLE #BrochureCount(OrganizationID int,
				SourceCodeID int,
				BrochureCount int)


CREATE TABLE #CODCallCount (OrganizationID int,
				OrganizationName varchar(100),
				SourceCodeID int,
				SourceCodeName varchar(10),
				CallCount int,
				BrochureYes int,
				BrochureNo int)
    

/********************************************************************************/
/*	Populate With Call Count Information			*/
/********************************************************************************/

	INSERT INTO #CODCallCount (OrganizationID, OrganizationName, SourceCodeID, SourceCodeName, CallCount)
	SELECT  a.OrganizationID as OrganizationID, o.OrganizationName, b.SourceCodeID as SourceCodeID, s.SourceCodeName as SourceCodeName, Count(*) As CallCount
	FROM 	CODCaller a
	JOIN Call b ON b.CallID = a.CallID
	JOIN Organization o ON o.OrganizationID = a.OrganizationID
	JOIN SourceCode s ON s.SourceCodeID = b.SourceCodeID
	WHERE CallDateTime >= @vStartDate 
	AND CallDateTime <= @vEndDate
	GROUP BY a.OrganizationID, o.OrganizationName, b.SourceCodeID, s.SourceCodeName

/********************************************************************************/
/*	Update with Brochure Fulfillment Information		*/
/********************************************************************************/
	
	--Get the counts of those that have received or are to receive brochures	
	INSERT INTO #BrochureCount
	SELECT OrganizationID, b.SourceCodeID, Count(*)
	FROM CODCaller a
	JOIN Call b ON b.CallID = a.CallID
	WHERE a.CODCallerLabelStatus > 0
	AND b.CallDateTime >= @vStartDate 
	AND b.CallDateTime <= @vEndDate
	GROUP BY a.OrganizationID, b.SourceCodeID

	UPDATE #CODCallCount
	SET BrochureYes = b.BrochureCount
	FROM #BrochureCount b
	JOIN #CODCallCount a ON a.OrganizationID = b.OrganizationID 
	AND a.SourceCodeID = b.SourceCodeID



	--Get the counts of those who did and will not receive brochures
	--First, clear out the #BrochureCount table to reuse it
	DELETE FROM #BrochureCount
	
	INSERT INTO #BrochureCount
	SELECT OrganizationID, b.SourceCodeID, Count(*)
	FROM CODCaller a
	JOIN Call b ON b.CallID = a.CallID
	WHERE a.CODCallerLabelStatus = 0
	AND b.CallDateTime >= @vStartDate 
	AND b.CallDateTime <= @vEndDate
	GROUP BY a.OrganizationID, b.SourceCodeID

	UPDATE #CODCallCount
	SET BrochureNo = b.BrochureCount
	FROM #BrochureCount b
	JOIN #CODCallCount a ON a.OrganizationID = b.OrganizationID 
	AND a.SourceCodeID = b.SourceCodeID


/********************************************************************************/
/*	Replace nulls in counts with zeros			*/
/********************************************************************************/

	UPDATE #CODCallCount
	SET BrochureYes = '0'
	WHERE BrochureYes IS NULL

	UPDATE #CODCallCount
	SET BrochureNo = '0'
	WHERE BrochureNo IS NULL


/********************************************************************************/
/*	Output counts						*/
/********************************************************************************/

	SELECT * 
	FROM #CODCallCount
	ORDER BY SourceCodeID 
		
/********************************************************************************/
/*	Delete Temp tables					*/
/********************************************************************************/

	DROP TABLE #CODCallCount
	DROP TABLE #BrochureCount



















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

