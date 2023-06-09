SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageActivityByAlertGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageActivityByAlertGroup]
GO




CREATE PROCEDURE sps_MessageActivityByAlertGroup

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID	int		= null
AS

	SELECT	Alert.AlertID, AlertGroupName, 

			CASE
			WHEN Message.MessageTypeID = 1 THEN "Pub Ed"
			WHEN Message.MessageTypeID = 3 THEN "General"
			WHEN Message.MessageTypeID = 4 THEN "Other"
			END AS MessageTypeName,

			Call.CallID,  CallNumber, 
			--DATEADD(hour, 0, CallDateTime) AS CallDateTime,
			CallDateTime,
			Organization.OrganizationName, PersonFirst + ' ' + PersonLast AS PersonName,
			MessageCallerName, MessageCallerOrganization

	FROM		Call
	JOIN		Message ON Message.CallID = Call.CallID
	JOIN		AlertOrganization ON AlertOrganization.OrganizationID = Message.OrganizationID
	JOIN		Alert ON Alert.AlertID = AlertOrganization.AlertID 
	JOIN		AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID
	JOIN		Organization ON Organization.OrganizationID = Message.OrganizationID
	JOIN		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID
	JOIN		Person ON Person.PersonID = Message.PersonID

	WHERE 	CallDateTime >= @vStartDate
	AND 		CallDateTime <= @vEndDate
	AND		WebReportGroupID = @vReportGroupID
	AND		Call.SourceCodeID = AlertSourceCode.SourceCodeID
	AND		(Message.MessageTypeID = 1 OR Message.MessageTypeID = 3 OR Message.MessageTypeID = 4)

	ORDER BY 	AlertGroupName, Message.MessageTypeID, CallDateTime










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

