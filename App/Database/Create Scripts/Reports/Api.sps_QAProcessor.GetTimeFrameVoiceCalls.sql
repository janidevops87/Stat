IF OBJECT_ID('[Api].[sps_QAProcessor.GetTimeFrameVoiceCalls]', 'P') IS NOT NULL
	DROP PROCEDURE [Api].[sps_QAProcessor.GetTimeFrameVoiceCalls];
GO

CREATE PROCEDURE [Api].[sps_QAProcessor.GetTimeFrameVoiceCalls]
	@CallID int,
	@DefaultTimeFrameInSeconds int
AS

 /******************************************************************************
 ** File: Api.sps_QAProcessor.GetTimeFrameVoiceCalls.sql 
 ** Name: sps_QAProcessor.GetTimeFrameVoiceCalls
 ** Desc: For a given call returns call start and call end date/time.
 ** Auth: Andrey Savin
 ** Date: 7/14/2021
 ** Called By: StatTrac API
 *******************************************************************************/

SET NOCOUNT ON;

DECLARE 
	@IncomingCall int = 2, 
	@OutgoingCall int = 3,
	@PagePending int = 6,
	@EmailPending int = 21,
	@EmailSent int = 51;

SELECT 
	CallStart,
	-- 1. When CallEnd is not NULL AND CallEnd > CallStart: use CallEnd.
	-- 2. Otherwise: use CallStart with some added margin.
	-- In some rare cases it may happen that Incoming Call event comes later than
	-- other events, so it's possible that CallEnd < CallStart (1).
	IIF(CallEnd > CallStart, CallEnd, DATEADD(s, @DefaultTimeFrameInSeconds, CallStart)) AS CallEnd
FROM (
	SELECT
		MIN(CASE WHEN le.LogEventTypeID = @IncomingCall THEN LogEventDateTime END) AS CallStart,
		MIN(CASE WHEN le.LogEventTypeID <> @IncomingCall THEN LogEventDateTime END) AS CallEnd
	FROM Call c
	JOIN LogEvent le ON c.CallID = le.CallID
	WHERE 
		c.CallID = @CallID AND 
		le.LogEventTypeID IN (@IncomingCall, @OutgoingCall, @PagePending, @EmailPending, @EmailSent)
	GROUP BY c.CallID
) AS x
WHERE CallStart IS NOT NULL; -- Guard against cases when there is no Incoming Call event (not sure if that's possible)


GO