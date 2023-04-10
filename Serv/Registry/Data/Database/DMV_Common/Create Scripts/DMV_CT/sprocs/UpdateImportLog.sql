  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateImportLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateImportLog]
	PRINT 'Dropping Procedure: UpdateImportLog'
END
	PRINT 'Creating Procedure: UpdateImportLog'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[UpdateImportLog]
/******************************************************************************
**		File: UpdateImportLog.sql
**		Name: UpdateImportLog
**		Desc:  NEOB Registry, Import for CT
**
**		Called by:  
**              
**
**		Auth: ccarroll	
**		Date: 09/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		09/04/2009	ccarroll	initial							
*******************************************************************************/
AS


DECLARE @thisRun integer

-- Get the most recent log ID
SET @thisRun = (SELECT Top 1 ImportLog.[ID]
	FROM ImportLog 
	WHERE Runstatus = 'LOADING'
	ORDER BY ImportLog.[ID] DESC);

-- Update the log table with the added count
UPDATE ImportLog
SET 
	RecordsTotal =
	(
		SELECT Count(*) AS 'RecordsTotal'
		FROM Import_Adds
	),
	
	RecordsAdded =
	(
		SELECT Count(*) AS 'RecordsAdded'
		FROM Import_Adds
		LEFT JOIN DMV ON Import_Adds.License = DMV.License
		WHERE DMV.License Is Null
	),

	RecordsSuspended = 
	(
		SELECT Count(*) AS 'RecordsSuspended'
		FROM Import_Deletes
		JOIN DMV ON Import_Deletes.License = DMV.License
	),
	
	RecordsUpdated = 
	(
		SELECT Count(*) AS 'Updated'
		FROM Import_Adds
		JOIN DMV ON Import_Adds.License = DMV.License
	)	
	
	
	WHERE ImportLog.[ID] = @thisRun
