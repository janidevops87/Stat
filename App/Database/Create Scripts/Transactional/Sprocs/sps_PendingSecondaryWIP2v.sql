SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryWIP2v]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingSecondaryWIP2v]
GO



CREATE  PROCEDURE sps_PendingSecondaryWIP2v
	--@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)

AS

SET NOCOUNT ON 

DECLARE @TZ int      

DECLARE @FStbl Table (tempFSCaseId int)

EXEC spf_TZDif @vTZ, @TZ OUTPUT

-- To eliminate large "NOT IN (Subselect)", Get the FSCaseIds to exclude and put them into a 
-- table variable, then use it in the subselect.  1/28/05 - SAP
INSERT INTO @FStbl (tempFSCaseId)
	SELECT DISTINCT
		FSCase.FSCaseId
	FROM 	LogEvent 
	/* bjk 07/05/05 reorganizing query. The previous version of this query was joining on my tables than necessary.
	   I am removing the join on Call, Referral, Organization, StatEmployee, Person and Organization as Person Organization or PO
	*/
	LEFT  
	JOIN 	FSCase ON FSCase.CallID = LogEvent.CallID

	WHERE 
	
	(
	-- LogEventType Page Pending
	(LogEvent.LogEventTypeID = 6
	AND LogEvent.LogEventCallbackPending=-1
	AND FSCase.FSCaseOpenUserId <> 0  
	AND FSCase.FSCaseFinalUserId = 0 
	
	)
   	or
   	(
	-- LogEvent Type Callout Pending
   	LogEvent.LogEventTypeID = 14
	AND LogEvent.LogEventCallbackPending=-1
	AND FSCase.FSCaseOpenUserId <> 0  
	AND FSCase.FSCaseFinalUserId = 0 

   	))
	;
	
	-- Now that you have the FSCallIds to exclude, perform the main query.  1/28/05 - SAP
	SELECT DISTINCT
		Call.CallID, 
		0, 
		Call.CallNumber,
		DATEADD(hh,@TZ,FSCaseCreateDateTime) AS 'FSCaseCreateDateTime', 
		Organization.OrganizationName, 
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(hh,@TZ,FSCaseCreateDateTime) AS 'FSCaseCreateDateTime',
		'' AS Spacer,
		'' AS Spacer,
		PO.OrganizationID,
		Case when FSCase.FSCaseOpenUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSysEventsUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSecCompUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseApproachUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseFinalUserId > 0 Then 'X' Else '' END,
		DATEADD(hh,@TZ,FSCase.FSCaseOpenDateTime) AS 'FSCaseOpenDateTime',
		DATEADD(hh,@TZ,FSCase.FSCaseSysEventsDateTime) AS 'FSCaseSysEventsDateTime',
		DATEADD(hh,@TZ,FSCase.FSCaseSecCompDateTime) AS 'FSCaseSecCompDateTime',
		DATEADD(hh,@TZ,FSCase.FSCaseApproachDateTime) AS 'FSCaseApproachDateTime',
		DATEADD(hh,@TZ,FSCase.FSCaseFinalDateTime) AS 'FSCaseFinalDateTime'
	
	FROM 	FSCase
	JOIN 	Call ON FSCase.CallID = Call.CallID
	JOIN 	Referral ON Referral.CallID = Call.CallID
	JOIN 	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT	 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT 
	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT	 
	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID

	WHERE 	FSCaseOpenUserId <> 0 
	AND 	FSCase.FSCaseFinalUserId = 0 
	AND	PO.OrganizationLOFSEnabled <> -1 --Case when @LeaseOrg > 0 Then PO.OrganizationLOFSEnabled else 0 end -- Added for LO
	/*AND 	FSCaseId NOT IN
		(SELECT tempFSCaseId FROM @FStbl)*/
	AND	FSCaseId NOT IN (SELECT tempFSCaseId FROM @FStbl WHERE FSCaseId = tempFSCaseId)
	ORDER BY FSCaseCreateDateTime DESC;



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

