SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PageResponsePersonMessage1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PageResponsePersonMessage1]
GO








/****** Object:  Stored Procedure dbo.sps_PageResponsePersonMessage1    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PageResponsePersonMessage1

	@vProcOrgID		int		= null,	--  Procurement Organization
	@vStartDate	smalldatetime	= null,
	@vEndDate	smalldatetime	= null,
	@vResponseType	int		= null
AS

DECLARE

	@vHour		smallint,
	@vTZ		varchar(2)

	SELECT	@vTZ = TimeZone.TimeZoneAbbreviation
	FROM Organization 
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	WHERE 	OrganizationID = @vProcOrgID

	
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vStartDate

	
	SELECT 	Count(DISTINCT LogEvent.PersonID) AS PersonCount
	FROM 	LogEvent 
	JOIN	Call ON Call.CallID = LogEvent.CallID
	WHERE 	LogEvent.OrganizationID = @vProcOrgID
	AND	LogEventTypeID = 6
	AND	LogEventDateTime >= @vStartDate AND LogEventDateTime <= @vEndDate
	AND 	CallTypeID = @vResponseType




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

