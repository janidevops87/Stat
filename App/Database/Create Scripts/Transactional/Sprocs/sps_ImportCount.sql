SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ImportCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ImportCount]
GO


CREATE PROCEDURE sps_ImportCount
	
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID			int		= null,
	@vTZ   			varchar(2) 

AS

	Declare @vHour  smallint
 
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vStartDate

	SELECT 	Message.MessageTypeID, MessageTypeName, Count(MessageID) AS MessageTypeCount

	FROM 		Message
	JOIN		Call ON Call.CallID = Message.CallID
	JOIN		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID

	WHERE 	OrganizationID = @vOrgID
	AND   DATEADD(hour, @vHour, CallDateTime)  >= @vStartDate
 	AND   DATEADD(hour, @vHour, CallDateTime) <= @vEndDate
	--AND		CallDateTime >= @vStartDate 
	--AND 		CallDateTime <= @vEndDate
	AND		Message.MessageTypeID = 2

	GROUP BY	Message.MessageTypeID, MessageTypeName




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

