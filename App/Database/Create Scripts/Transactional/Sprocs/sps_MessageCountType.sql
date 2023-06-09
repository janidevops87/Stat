SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageCountType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageCountType]
GO





CREATE PROCEDURE sps_MessageCountType
	
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= null

AS

	Declare @TZ varchar(2) ,
		@TZD int
	
	--GET TimeZone and Time Zone Difference
	SELECT @TZ = TimeZone.TimeZoneAbbreviation
	FROM Organization 
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	where  OrganizationID = @vOrgID

	Exec spf_TZDif @TZ, @TZD OUTPUT, @vStartDate
	

	SELECT 	Message.MessageTypeID, MessageTypeName, Count(MessageID) AS MessageTypeCount

	FROM 		Message
	JOIN		Call ON Call.CallID = Message.CallID
	JOIN		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID
	JOIN            	Organization ON Organization.OrganizationID = Message.OrganizationID

	WHERE 	 Message.OrganizationID = @vOrgID

	 AND             	DATEADD(hour, @TZD, CallDateTime) 
					BETWEEN @vStartDate
					AND @vEndDate

	AND		Message.MessageTypeID <>2

--	AND		CallDateTime >= @vStartDate 
--	AND 		CallDateTime <= @vEndDate

--	AND		(Message.MessageTypeID = 1 OR Message.MessageTypeID = 3 OR Message.MessageTypeID = 4)

	GROUP BY	Message.MessageTypeID, MessageTypeName

	ORDER BY	Message.MessageTypeID








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

