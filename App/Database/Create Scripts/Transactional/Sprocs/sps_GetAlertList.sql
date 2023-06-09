SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetAlertList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetAlertList]
GO



CREATE PROCEDURE sps_GetAlertList

@SC		varchar(20)	=null,
@AlertType	int		=null

AS
-- ccarroll 5/16/2006 Changes for RTF2HTML (Alerts) StatTrac 8.0 Web Reports
-- Alert field datatype is now ntext and requires following to work: 
-- Cast ntext as varchar for len measurement  

DECLARE	@SCStart	int
DECLARE	@SCLast	int
DECLARE	@AlertStart	int
DECLARE	@AlertLast	int


--Source Code Data
If @SC = 'All Source Codes'
	BEGIN 
		SELECT @SCStart = 0
		SELECT @SCLast = MAX(SourceCodeID)
		FROM SourceCode
	END	
--Gather Alert Type Data
If @AlertType <> 0
	BEGIN
		SELECT @AlertStart = @AlertType
		SELECT @AlertLast = @AlertType
	END
ELSE
	BEGIN
		SELECT @AlertStart = @AlertType
		SELECT @AlertLast = MAX(AlertTypeID)
		FROM Alert
	END

--If a Source Code is selected.
IF @SC <> 'All Source Codes'
BEGIN
	SELECT 	SourceCode.SourceCodeName,
		Alert.AlertGroupName,
	CASE 
		WHEN Alert.AlertMessage1 IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertMessage1 AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertMessage1
	END AS AlertMessage1,
	CASE 
		WHEN Alert.AlertMessage2 IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertMessage2 AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertMessage2
	END AS AlertMessage2,
	CASE 
		WHEN Alert.AlertScheduleMessage IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertScheduleMessage AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertScheduleMessage
	END AS AlertScheduleMessage
	FROM 	Alert
	JOIN 	AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN	SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID
	WHERE 	SourceCodeName = @SC AND (Alert.AlertTypeID BETWEEN @AlertStart AND @AlertLast) 
	ORDER BY AlertGroupName ASC
END 
ELSE 
BEGIN
	SELECT 	Alert.AlertGroupName,
	CASE 
		WHEN Alert.AlertMessage1 IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertMessage1 AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertMessage1
	END AS AlertMessage1,
	CASE 
		WHEN Alert.AlertMessage2 IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertMessage2 AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertMessage2
	END AS AlertMessage2,
	CASE 
		WHEN Alert.AlertScheduleMessage IS NULL THEN ' &nbsp '
		WHEN len(CAST(Alert.AlertScheduleMessage AS varchar)) < 5 THEN ' &nbsp '
		ELSE Alert.AlertScheduleMessage
	END AS AlertScheduleMessage
	FROM 	Alert
	JOIN 	AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN	SourceCode ON SourceCode.SourceCodeID = AlertSourceCode.SourceCodeID
	WHERE 	(Alert.AlertTypeID BETWEEN @AlertStart AND @AlertLast) AND (SourceCode.SourceCodeID BETWEEN @SCStart AND @SCLast)
	ORDER BY AlertGroupName ASC
END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

