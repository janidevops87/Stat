SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ImportActivityByAlertGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ImportActivityByAlertGroup]
GO



CREATE PROCEDURE sps_ImportActivityByAlertGroup

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID	int		= null
AS

	SELECT	Alert.AlertID, AlertGroupName, 
			Call.CallID,  CallNumber,
			--DATEADD(hour, 0, CallDateTime) AS CallDateTime, -- removed by Bret Knoll 3/31/00
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
	AND		Message.MessageTypeID =2

	ORDER BY 	AlertGroupName, Message.MessageTypeID, CallDateTime











GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

