IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventList')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventList'
		DROP  Procedure  GetLogEventList
	END

GO

PRINT 'Creating Procedure GetLogEventList'
GO
CREATE Procedure GetLogEventList
	@CallID INT,
	@TimeZone VARCHAR(2),
	@ViewLogEventDeleted BIT = NULL
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

SELECT 
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
	PersonFirst + ' ' + PersonLast,
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
									WHEN
										-- if @ViewLogEventDeleted  = 1
										ISNULL(@ViewLogEventDeleted , 0) = 1																THEN
										-- show all events deleted and not 
										LogEvent.LogEventDeleted
									ELSE
										-- otherwise only show
										0 -- DEFAULT NOT DELETED
								END		
ORDER BY 
	-- LogEventNumber ASC, -- sequence based on Date and time not LogEventNumber
	LogEventDateTime ASC,
	LogEventNumber ASC;

GO

GRANT EXEC ON GetLogEventList TO PUBLIC

GO
