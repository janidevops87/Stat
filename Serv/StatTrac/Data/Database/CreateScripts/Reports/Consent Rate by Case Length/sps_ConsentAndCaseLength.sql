IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ConsentAndCaseLength')
	BEGIN
		PRINT 'Dropping Procedure sps_ConsentAndCaseLength'
		DROP  Procedure  sps_ConsentAndCaseLength
	END

GO

PRINT 'Creating Procedure sps_ConsentAndCaseLength'
GO
CREATE Procedure sps_ConsentAndCaseLength
	@callDateTimeStart	DATETIME,
	@callDateTImeEnd	DATETIME,
	@sourceCodeName		VARCHAR(25)
AS

/******************************************************************************
**		File: 
**		Name: sps_ConsentAndCaseLength
**		Desc: 
**
**		Pull a list of Calls by SourceCode
**
**		Return values:
**			Call.CallID, 
**			Call.CallDateTime, 
**			SourceCode.SourceCodeName, 
**			FSCase.FSCaseFinalDateTime, 
**			SecondaryApproach.SecondaryApproached, 
**			SecondaryApproachOutcome = 2 THEN 'Yes'  
**			OR
**			SecondaryApproachOutcome = 2 THEN 'Yes' 
**			DATEDIFF(hh, Call.CallDateTime, FSCase.FSCaseFinalDateTime) 
**				'0-12' 
**				'12-15' 
**				'15+' 
** 
**		Called by:   ConsentByCaseLength.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@callDateTimeStart	DATETIME,
**		@callDateTImeEnd	DATETIME,
**		@sourceCodeName		VARCHAR(25)
**
**		Auth: Bret Knoll
**		Date: 3/14/06
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-----------------------------------	
**		3/14/06		Bret Knoll			Created Script	
**    
*******************************************************************************/

SELECT
	Call.CallID, 
	Call.CallDateTime, 
	SourceCode.SourceCodeName, 
	FSCase.FSCaseFinalDateTime, 
	SecondaryApproach.SecondaryApproached, 
    CASE 
		WHEN SecondaryApproachOutcome = 2 THEN 'Yes' 
		WHEN SecondaryApproachOutcome <> 2 THEN 'No' 
	END AS [Secondary Outcome], 
    CASE 
		WHEN DATEDIFF(hh, Call.CallDateTime, FSCase.FSCaseFinalDateTime) < 12 THEN '0-12' 
		WHEN DATEDIFF(hh, Call.CallDateTime, FSCase.FSCaseFinalDateTime) BETWEEN 12 AND 15 THEN '12-15' 
		WHEN DATEDIFF(hh, Call.CallDateTime, FSCase.FSCaseFinalDateTime) > 15 THEN '15+' 
	END AS [Case Length (hours)]
FROM
	Call 
INNER JOIN
	SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 
INNER JOIN
	FSCase ON Call.CallID = FSCase.CallId 
INNER JOIN
    SecondaryApproach ON Call.CallID = SecondaryApproach.CallId
WHERE     
	(SecondaryApproach.SecondaryApproached = 1) 
AND 
	(SourceCode.SourceCodeName = @sourceCodeName) 
AND 
	(Call.CallDateTime 
		BETWEEN 
			@callDateTimeStart 
		AND 
			@callDateTimeEnd)



GO

GRANT EXEC ON sps_ConsentAndCaseLength TO PUBLIC

GO
