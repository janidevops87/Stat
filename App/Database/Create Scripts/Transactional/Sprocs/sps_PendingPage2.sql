SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingPage2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingPage2]
GO




/****** Object:  Stored Procedure dbo.sps_PendingPage2    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PendingPage2 
	@LeaseOrg INT =0

AS


	SELECT distinct	LogEvent.LogEventID, 
		0, 
		Call.CallNumber,
		LogEventDateTime, 
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		LogEventDateTime,
		''AS Spacer,
		Person.OrganizationID

		-- added for LO
		--Organization.OrganizationLeaseOrganization As OrganizationLOEnabled -- added for LO


	FROM LogEvent 
	LEFT JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	JOIN Referral ON Referral.CallID = Call.CallID
--	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = CALL.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	LogEvent.LogEventTypeID = 6 
	AND	LogEvent.LogEventCallbackPending=-1 
	-- the following AND statement filters out pending referrals where the LO is enabled
	-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
	-- Statline will see calls where they are taking them, where the LO has switch calls to us.
	-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
	-- LO will see all referrals based on the statment. The next statment limits their access
	-- in the final app this will be OrganizationLOEnabled
	AND	Organization.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then Organization.OrganizationLOEnabled else 0 end -- Added for LO
 	-- Added for LO 
	-- IF a LO is using the application they will only see their referrals
	-- If Statline is using the application they will see all referrals
	
	AND WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO

UNION ALL	
	SELECT distinct	LogEvent.LogEventID, 
		0, 
		Call.CallNumber,
		LogEventDateTime, 
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		LogEventDateTime,
		'MESSAGE'AS Spacer,
		Person.OrganizationID
		-- added for LO
		--Organization.OrganizationLeaseOrganization As OrganizationLOEnabled -- added for LO


	FROM LogEvent 
	LEFT JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	
	--LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	LEFT JOIN Message ON Message.CallID = Call.CallID

	WHERE 	LogEvent.LogEventTypeID = 6 
	AND	LogEvent.LogEventCallbackPending=-1 
	-- the following AND statement filters out pending referrals where the LO is enabled
	-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
	-- Statline will see calls where they are taking them, where the LO has switch calls to us.
	-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
	-- LO will see all referrals based on the statment. The next statment limits their access
	-- in the final app this will be OrganizationLOEnabled
	AND	Organization.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then Organization.OrganizationLOEnabled else 0 end -- Added for LO
 	-- Added for LO 
	-- IF a LO is using the application they will only see their referrals
	-- If Statline is using the application they will see all referrals
	
	AND Message.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else Message.OrganizationID END -- Added for LO

	ORDER BY LogEvent.LogEventDateTime DESC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

