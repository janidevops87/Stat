SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralLogEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
		PRINT 'Dropping Procedure sps_ReferralLogEvent'
		drop procedure [dbo].[sps_ReferralLogEvent]
END

GO

PRINT 'Creating Procedure sps_ReferralLogEvent'
GO


CREATE PROCEDURE sps_ReferralLogEvent

     @CallID             int          = null,
     @vTZ                 varchar(2)   = null



AS
/******************************************************************************
**		File: sps_ReferralLogEvent.sql
**		Name: sps_ReferralLogEvent
**		Desc: 
**
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
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      09/26/2007		ccarroll				StatTrac 8.4 release deleted log events
*******************************************************************************/

     DECLARE 	@TZ 			int,
		@vCallDateTime	smallDateTime

	IF RIGHT(@vTZ, 1) = 'S' -- get at calldatetime if the Time Zone is standard else just get a time zone difference without date
	BEGIN
		SELECT @vCallDateTime = CallDateTime FROM Call WHERE CallID = @CallID
	END

	
	EXEC spf_TZDif @vTZ, @TZ OUTPUT, @vCallDateTime

/*


*/
     SELECT    convert(char(8),DATEADD(hour, @TZ, LogEventDateTime ),1)  + ' ' + 
               convert(char(5),DATEADD(hour, @TZ, LogEventDateTime ),8) as LogEventDateTime, 
               LogEventTypeName, 
               LogEventOrg , 
               LogEventName,LogEventDesc, 
               --left(StatEmployeeFirstName,1) + Case(StatEmployeeMi+ Left(StatEmployeeLastName,1) 
               left(PersonFirst,1) + Case  When PersonMI IS NULL THEN '' ELSE PersonMI END + Left(PersonLast,1),
	   	       LogEventNumber	 

     FROM      LOGEVENT
     --JOIN     Call ON call.CallID = Logevent.CallID
     LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID
     LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
     JOIN Person ON Person.PersonID = StatEmployee.PersonID
     WHERE     CALLID = @CallID
	  	       AND IsNull(LogEventDeleted, 0) <> 1	-- ccarroll 09/26/2007 - Exclude deleted log events

     ORDER BY  LogEventNumber 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

