SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingPage5v]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingPage5v]
GO


CREATE PROCEDURE sps_PendingPage5v
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)

AS

/*
	05/07/02 bjk: sps_PendingPage5 was created because LO were not seeing PageResponses from their Messages.

*/

DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT

--- select @TZ -- debug


	SELECT DISTINCT	LogEvent.LogEventID, 
		0, 
		Call.CallNumber,
		DATEADD(hh, @TZ, LogEventDateTime) AS 'LogEventDateTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(hh, @TZ, LogEventDateTime) AS 'LogEventDateTime',
		''AS Spacer,
		Person.OrganizationID,
		--10/11/01 drh Added so we can see if it's a fax pending
		LogEvent.LogEventTypeID

		-- added for LO
		--Organization.OrganizationLeaseOrganization As OrganizationLOEnabled -- added for LO


	FROM LogEvent 
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	JOIN Referral  ON Referral.CallID = Call.CallID
--	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = CALL.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	LogEvent.LogEventTypeID IN(6, 18, 21) 
	-- Added LogEventTypeId of 21 (Email) for ver. 7.7.2, 12/16/04 - SAP
	AND	LogEvent.LogEventCallbackPending=-1 
	-- the following AND statement filters out pending referrals where the LO is enabled
	-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
	-- Statline will see calls where they are taking them, where the LO has switch calls to us.
	-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
	-- LO will see all referrals based on the statment. The next statment limits their access
	-- in the final app this will be OrganizationLOEnabled
	AND	Organization.OrganizationLOTriageEnabled = Case when @LeaseOrg > 0 Then Organization.OrganizationLOTriageEnabled else 0 end -- Added for LO
 	-- Added for LO 
	-- IF a LO is using the application they will only see their referrals
	-- If Statline is using the application they will see all referrals
	
	AND WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO

	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

UNION ALL	

	SELECT DISTINCT	LogEvent.LogEventID, 
		0, 
		Call.CallNumber,
		DATEADD(hh, @TZ, LogEventDateTime) AS 'LogEventDateTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(hh,@TZ,LogEventDateTime) AS 'LogEventDateTime',
		'MESSAGE'AS Spacer,
		Person.OrganizationID,
		--10/11/01 drh Added so we can see if it's a fax pending
		LogEvent.LogEventTypeID

		-- added for LO
		--Organization.OrganizationLeaseOrganization As OrganizationLOEnabled -- added for LO


	FROM LogEvent 
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	JOIN Message  ON Message.CallID = Call.CallID -- 05/07/02 bjk version 5 changed LEFT JOIN to JOIN to limit to calls of type message.
	LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID --05/07/02 bjk version 5  added join

	WHERE 	LogEvent.LogEventTypeID IN(6, 18, 21) 
	-- Added LogEventTypeId of 21 (Email) for ver. 7.7.2, 12/16/04 - SAP
	AND	LogEvent.LogEventCallbackPending=-1 
	-- the following AND statement filters out pending referrals where the LO is enabled
	-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
	-- Statline will see calls where they are taking them, where the LO has switch calls to us.
	-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
	-- LO will see all referrals based on the statment. The next statment limits their access
	-- in the final app this will be OrganizationLOEnabled
	AND	Organization.OrganizationLOTriageEnabled = Case when @LeaseOrg > 0 Then Organization.OrganizationLOTriageEnabled else 0 end -- Added for LO
 	-- Added for LO 
	-- IF a LO is using the application they will only see their referrals
	-- If Statline is using the application they will see all referrals
	AND SourceCodeOrganization.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else SourceCodeOrganization.OrganizationID END -- 05/07/02 bjk version 5 added to allow LO to look at PageResponses from multiple Orgs. 
--	AND Message.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else Message.OrganizationID END -- 05/07 bjk version 5  removed

	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

	ORDER BY LogEvent.LogEventDateTime DESC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

