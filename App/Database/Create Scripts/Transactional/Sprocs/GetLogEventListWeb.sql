IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventListWeb')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventListWeb'
		DROP  Procedure  GetLogEventListWeb
	END

GO

PRINT 'Creating Procedure GetLogEventListWeb'
GO 

CREATE Procedure GetLogEventListWeb
	@CallID INT,
	@TimeZone VARCHAR(2)
	
AS

/******************************************************************************
**		File: GetLogEventListWeb.sql
**		Name: GetLogEventListWeb
**		Desc: Obtains the list of LogEvents
**
**              
**		Return values:
** 
**		Called by:   
**		EventLogUpdate
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 8/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		8/08		jth				web edition
*******************************************************************************/

SELECT 
		
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
	substring(PersonFirst,1,1) +  substring(PersonLast,1,1) PersonInit,
	LogEventDesc,
	LogEventNumber
	
FROM 
	LogEvent 
JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN 
	StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN 
	Person ON Person.PersonID = StatEmployee.PersonID 
WHERE 
	LogEvent.CallID = @CallID 
/*
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
*/
ORDER BY 
	
	LogEventNumber ASC;
GO
