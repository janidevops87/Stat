SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageActivity]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageActivity]
GO






CREATE PROCEDURE sps_MessageActivity

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0,
	@vTZ			varchar(2)	= 'MT',
	@vOrderBy		smallint		= 0

AS

DECLARE


	@vHour		smallint

	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vStartDate
	


IF 	@vOrderBy = 0

	SELECT	Message.MessageTypeID, MessageTypeName,
			Call.CallID,  CallNumber,
			DATEADD(hour, @vHour, CallDateTime) AS CallDateTime,
			Organization.OrganizationName, PersonFirst + ' ' + PersonLast AS PersonName,
			MessageCallerName, MessageCallerOrganization

	FROM		Call
	JOIN		Message ON Message.CallID = Call.CallID
	JOIN		Organization ON Organization.OrganizationID = Message.OrganizationID
	JOIN		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID
	JOIN		Person ON Person.PersonID = Message.PersonID

	WHERE	DATEADD(hour, @vHour, CallDateTime) BETWEEN @vStartDate AND @vEndDate

	AND		Message.OrganizationID = @vOrgID
	AND		Message.MessageTypeID <> 2 --(Message.MessageTypeID = 1 OR Message.MessageTypeID = 3 OR Message.MessageTypeID = 4)

	ORDER BY 	Message.MessageTypeID, PersonLast, CallDateTime

ELSE

	SELECT	Message.MessageTypeID, MessageTypeName,
			Call.CallID,  CallNumber,
			DATEADD(hour, 0, CallDateTime) AS CallDateTime,
			Organization.OrganizationName, PersonFirst + ' ' + PersonLast AS PersonName,
			MessageCallerName, MessageCallerOrganization

	FROM		Call
	JOIN		Message ON Message.CallID = Call.CallID
	JOIN		Organization ON Organization.OrganizationID = Message.OrganizationID
	JOIN		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID
	JOIN		Person ON Person.PersonID = Message.PersonID

	WHERE 	DATEADD(hour, @vHour , CallDateTime) BETWEEN @vStartDate AND @vEndDate

	AND		Message.OrganizationID = @vOrgID
	AND		Message.MessageTypeID <> 2


	ORDER BY 	Message.MessageTypeID, CallDateTime















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

