IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventList')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventList';
		DROP  Procedure  GetLogEventList;
	END

GO

PRINT 'Creating Procedure GetLogEventList';
GO
CREATE Procedure GetLogEventList
	@CallID INT,
	@TimeZone VARCHAR(2),
	@ViewLogEventDeleted BIT = NULL,
	@SortColumn NVARCHAR(100) = NULL,
	@AscDesc NVARCHAR(5) = NULL
AS

/******************************************************************************
**		File: 
**		Name: GetLogEventList
**		Desc: Obtains the list of LogEvents
**
**              
**		Return values:
** 
**		Called by:   
**		 StatTrac.ModStatQuery.QueryOpenLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret 
**		Date: Knoll
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/11/07		Bret Knoll			8.4.3.9 LogEvent Number
*******************************************************************************/
WITH PagingRecordSet AS 
(
SELECT 
	ROW_NUMBER() OVER (ORDER BY
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'Date           Time' THEN LogEventDateTime END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'Date           Time' THEN LogEventID END asc, 
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'Event Type' THEN LogEventTypeName END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'From/To' THEN LogEventName END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'Organization' THEN LogEventOrg END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'Description' THEN LogEventDesc END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = 'By' THEN PersonFirst + ' ' + PersonLast END asc,
		CASE WHEN @AscDesc = 'ASC' AND @SortColumn = '#' THEN LogEventNumber END asc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'Date           Time' THEN LogEventDateTime END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'Date           Time' THEN LogEventID END desc, 
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'Event Type' THEN LogEventTypeName END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'From/To' THEN LogEventName END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'Organization' THEN LogEventOrg END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'Description' THEN LogEventDesc END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = 'By' THEN PersonFirst + ' ' + PersonLast END desc,
		CASE WHEN @AscDesc = 'DESC' AND @SortColumn = '#' THEN LogEventNumber END desc
	,LogEventNumber desc) AS RowNum,
	LogEventID, 	
	DATEADD(
				hh, 
				dbo.fn_TimeZoneDifference(
											@TimeZone, 
											LogEventDateTime
										), 
				LogEventDateTime
			) AS LogEventDateTime, 
	LogEventTypeName,                        
	LogEventName, 
	LogEventOrg,
	PersonFirst + ' ' + PersonLast as Person,
	LogEventDesc,
	LogEventNumber,
	Code,	
	EventColor,
	LogEventCallBackPending
FROM 
	LogEvent 
LEFT JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN 
	StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN 
	Person ON Person.PersonID = StatEmployee.PersonID 
WHERE 
	LogEvent.CallID = @CallID 
AND										--  0 = not deleted
										--  1 = deleted
	ISNULL(LogEvent.LogEventDeleted, 0) = CASE
									WHEN ISNULL(@ViewLogEventDeleted , 0) = 1 THEN
										-- show all events deleted and not 
										LogEvent.LogEventDeleted
									ELSE
										-- otherwise only show
										0 -- DEFAULT NOT DELETED
								END	
)

SELECT 
	LogEventID, 	
	 LogEventDateTime, 
	LogEventTypeName,                        
	LogEventName, 
	LogEventOrg,
	Person,
	LogEventDesc,
	LogEventNumber,
	Code,	
	EventColor,
	LogEventCallBackPending
FROM PagingRecordSet tbl
Order by RowNum;

GO

GRANT EXEC ON GetLogEventList TO PUBLIC;

GO
