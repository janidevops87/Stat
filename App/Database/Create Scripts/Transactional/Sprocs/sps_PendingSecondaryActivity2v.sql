SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryActivity2v]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingSecondaryActivity2v]
GO





CREATE    PROCEDURE sps_PendingSecondaryActivity2v
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* 
	ccarroll 11/16/2006 - Added Join to display SourceCode Name
	Used by Secondary Activity grid in frmOpenAll 
*/

DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT

	SELECT 	DISTINCT
		Call.CallID, 
		0, 
		Call.CallNumber,
		DATEADD(hh,@TZ,LogEventDateTime) AS 'LogEventDateTime',
		sc.SourceCodeName AS 'Source', 
		LogEvent.LogEventName,
		--Organization.OrganizationName, 	--7/18/01 drh List Paged Person (LogEventName) instead of Org for Page Pendings
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(hh,@TZ,LogEventDateTime) AS 'LogEventDateTime',
		''AS Spacer,
		PO.OrganizationID,
		LogEvent.LogEventTypeID,
		''AS Spacer,
		Case when FSCase.FSCaseOpenUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSysEventsUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSecCompUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseApproachUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseFinalUserId > 0 Then 'X' Else '' END,
		LogEvent.LogEventOrg

	FROM 	LogEvent 
	LEFT JOIN Call ON Call.CallID = LogEvent.CallID
	RIGHT JOIN FSCase ON FSCase.CallID = LogEvent.CallID
	JOIN Referral ON Referral.CallID = Call.CallID
	JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID		--7/23/01 drh Changed from Call.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	LogEvent.LogEventTypeID = 6
	AND	LogEvent.LogEventCallbackPending=-1
	AND FSCase.FSCaseOpenUserId <> 0
	AND FSCase.FSCaseFinalUserId = 0 
 	-- add to where for LO
 	AND	PO.OrganizationLOFSEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOFSEnabled else 0 end -- Added for LO
	
	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO
	--7/23/01 drh Only list items if the FS Case has been marked OPEN
	AND FSCaseOpenUserId <> 0

union all
	SELECT 	DISTINCT

		Call.CallID, 
		0, 
		Call.CallNumber,
		DATEADD(hh,@TZ,LogEventCalloutDateTime) AS 'LogEventCalloutDateTime', 
		sc.SourceCodeName AS 'Source', 
		LogEvent.LogEventName + " -- " + Organization.OrganizationName,
		--Organization.OrganizationName, 	--7/18/01 drh List Paged Person (LogEventName) instead of Org for Page Pendings
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(hh,@TZ,LogEventDateTime) AS 'LogEventDateTime',
		''AS Spacer,
		PO.OrganizationID,
		LogEvent.LogEventTypeID,
		''AS Spacer,
		Case when FSCase.FSCaseOpenUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSysEventsUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSecCompUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseApproachUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseFinalUserId > 0 Then 'X' Else '' END,
		LogEvent.LogEventOrg

	FROM 	LogEvent 
	LEFT JOIN Call ON Call.CallID = LogEvent.CallID
	RIGHT JOIN FSCase ON FSCase.CallID = LogEvent.CallID
	JOIN Referral ON Referral.CallID = Call.CallID
	JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID		--7/23/01 drh Changed from Call.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID

	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	LogEvent.LogEventTypeID = 14
	AND	LogEvent.LogEventCallbackPending=-1
	AND FSCase.FSCaseOpenUserId <> 0 
	AND FSCase.FSCaseFinalUserId = 0 
 	-- add to where for LO
 	AND	PO.OrganizationLOFSEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOFSEnabled else 0 end -- Added for LO
	
	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO
	--7/23/01 drh Only list items if the FS Case has been marked OPEN
	AND FSCaseOpenUserId <> 0


	ORDER BY 
		LogEvent.LogEventTypeID DESC, LogEvent.LogEventDateTime




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

