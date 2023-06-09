IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_LogDetail')
	BEGIN
		PRINT 'Dropping Procedure sps_LogDetail'
		DROP  Procedure  sps_LogDetail
	END

GO

PRINT 'Creating Procedure sps_LogDetail'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Procedure sps_LogDetail
	@vCallID	int		= null,
	@vTZ		varchar(2) 	= null
AS

/******************************************************************************
**		File: sps_LogDetail.sql
**		Name: sps_LogDetail
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: MessageDetail, Import Offer
**					DetailSection2.sls   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vCallID	int
**		@vTZ		varchar(2)
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      06/28/2007		ccarroll				StatTrac 8.4 release deleted log events
*******************************************************************************/


/****** Object:  Stored Procedure dbo.sps_LogDetail    Script Date: 2/24/99 1:12:45 AM ******/
/****** Object:  Stored Procedure dbo.sps_LogDetail    Script Date: 9/11/97 7:20:13 PM ******/

SET CONCAT_NULL_YIELDS_NULL OFF

DECLARE
	@vHour		smallint,
	@vCallDateTime	smallDateTime

	IF RIGHT(@vTZ, 1) = 'S' -- get at calldatetime if the Time Zone is standard else just get a time zone difference without date
	BEGIN
		SELECT @vCallDateTime = CallDateTime FROM Call WHERE CallID = @vCallID
	END

	
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vCallDateTime

    	SELECT 
	CONVERT(char(8), DATEADD(hour, @vHour, LogEventDateTime), 1) + " " +
	CONVERT(char(5), DATEADD(hour, @vHour, LogEventDateTime), 8),
	LogEventTypeName, 
	LogEventOrg, 
	LogEventName, 
	LogEventDesc,
	SUBSTRING(PersonFirst,1,1) + SUBSTRING(PersonMI,1,1) + SUBSTRING(PersonLast,1,1),
	LogEventNumber
	FROM LogEvent 
	JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
	JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	JOIN Person ON Person.PersonID = StatEmployee.PersonID
    	WHERE LogEvent.CallID = @vCallID
	AND IsNull(LogEventDeleted, 0) <> 1 -- ccarroll 06/28/2007 - Exclude deleted log events
	ORDER BY LogEventNumber --LogEventDateTime, LogEventTypeName



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

