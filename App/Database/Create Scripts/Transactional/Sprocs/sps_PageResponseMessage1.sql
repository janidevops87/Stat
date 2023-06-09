SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PageResponseMessage1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PageResponseMessage1]
GO








/****** Object:  Stored Procedure dbo.sps_PageResponseMessage1    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PageResponseMessage1
	@vProcOrgID	int		= null, -- Procurement OrganizationID
	@vStartDate	smalldatetime	= null,
	@vEndDate	smalldatetime	= null,
	@vResponseType	int		= null
AS
DECLARE
	@vHour	smallint,
	@vTZ		varchar(2)

	SELECT	@vTZ = TimeZone.TimeZoneAbbreviation
	FROM Organization 
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID

	WHERE 	OrganizationID = @vProcOrgID
	
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vStartDate
	
    	
		SELECT 	LogEvent.CallID, 
		LogEventTypeID AS TypeID, 
		CONVERT(char(8), DATEADD(hour, @vHour, LogEventDateTime), 1) + " " +
		CONVERT(char(5), DATEADD(hour, @vHour, LogEventDateTime), 8) AS DateTime,
		PersonFirst + ' ' + PersonLast AS Person

		FROM 	LogEvent
		JOIN	Person ON Person.PersonID = LogEvent.PersonID
		JOIN	Call ON Call.CallID = LogEvent.CallID
		WHERE 	LogEvent.OrganizationID = @vProcOrgID
		AND	(LogEventTypeID = 6
		OR	LogEventTypeID = 9
		OR	LogEventTypeID = 12)
		AND	LogEventDateTime >= @vStartDate AND LogEventDateTime <= @vEndDate
		AND	CallTypeID = @vResponseType	
		ORDER BY PersonFirst + ' ' + PersonLast, LogEvent.CallID, LogEventDateTime




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

