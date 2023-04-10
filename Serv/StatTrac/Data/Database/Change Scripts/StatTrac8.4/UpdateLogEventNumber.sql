/******************************************************************************
**		File: UpdateLogEventNumber.sql
**		Desc: loops through everyday staring with the given date, working back in time until there are no records to update. Sets the LogEventNumber in the Logevent table.
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		7/10/097	Bret Knoll			8.4.3.8
*******************************************************************************/
print 'updating logevent'
SET NOCOUNT ON
declare
	@loopCount int,
	@loopMax   int,
	@currentDate datetime,
	@currentCallID int

if EXISTS(SELECT * FROM tempdb..SYSOBJECTS WHERE NAME like '#logEventRenumber%' )
BEGIN
	drop table #logEventRenumber 
END
CREATE TABLE #logEventRenumber 
			( 
				LogEventNumber int identity(1,1),
				CallID int,
				LogEventID int, 
				LogEventTypeID int
			)

select @currentDate = max(logeventdatetime) from logevent
if EXISTS(SELECT * FROM tempdb..SYSOBJECTS WHERE NAME like '#tableCallID%' )
BEGIN
	drop table #tableCallID 
END
create table #tableCallID 
	(
		id int identity(1,1),
		CallID int
	)

INSERT #tableCallID (CallID)
	SELECT 
	DISTINCT top 32000
		CallID 
	FROM 
		LogEvent 
	
	WHERE
		logeventnumber is null
	and 
		LogEvent.CallID is not null

WHILE (SELECT COUNT(*) from #tableCallID) > 0 
BEGIN
	
	select * from #tableCallID

	SELECT 
		@loopCount = 1
	SELECT 
		@loopMax = MAX(id) 
	FROM 
		#tableCallID

	print getdate()
	print @loopMax
	WHILE @loopCount <= @loopMax 
	BEGIN

		SELECT
			@currentCallID = CallID
		FROM	
			#tableCallID
		WHERE
			id = @loopCount

		/*
		select 
			* 
		from 
			logevent 
		where 
			callid = @currentCallID
		*/
				
		
		insert #logEventRenumber (callid, LogEventID, LogEventTypeID)
		select  callid, 
			LogEventID,
			LogEventTypeID 
		from 
			logevent 
		where 
			callid = @currentCallID
			
		order by LogEventDateTime
		
		
		
		update logevent
		set 
			logevent.LogEventNumber = lt.LogEventNumber,
			logevent.LogEventDeleted = 0,
			logevent.AuditLogTypeID = 1,
			logevent.LastStatEmployeeID = StatEmployeeID
		from #logEventRenumber lt, logevent
		where logevent.CallID = lt.CallID
		and logevent.logeventID = lt.logeventID
		
		
		/*
		select 
			*
		from 
			logevent 
		where 
			callid = @currentCallID
				
		*/
		SELECT 
			@loopCount = @loopCount  + 1
		

		TRUNCATE TABLE #logEventRenumber
		
		
	END
	select
		@currentDate = DATEADD(d, -1, @currentDate)


	truncate table #tableCallID 
	
	
	INSERT #tableCallID (CallID)
	SELECT 
	DISTINCT top 32000
		CallID 
	FROM 
		LogEvent 
	
	WHERE
		logeventnumber is null
	and 
		LogEvent.CallID is not null


	select * from #tableCallID
	SELECT 
		@loopCount = 1
	SELECT 
		@loopMax = MAX(id) 
	FROM 
		#tableCallID

	waitfor delay '00:00:05'
END		

DROP TABLE #logEventRenumber
	
/*	
select * from logevent 
join call on call.callid = logevent.callid
where --calldatetime between '6/14/07' and '6/15/07'
--and 
isnull(LogEventNumber, 0) = 0 
order by logevent.callid, Logeventnumber
*/

-- select * from logeventtype