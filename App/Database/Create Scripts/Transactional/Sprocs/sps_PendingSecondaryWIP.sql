SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryWIP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure sps_PendingSecondaryWIP'
	drop procedure [dbo].[sps_PendingSecondaryWIP]
END
PRINT 'create procedure sps_PendingSecondaryWIP'
GO

CREATE  PROCEDURE sps_PendingSecondaryWIP
	@LeaseOrg	INT = 0,
	@timeZone	VARCHAR(2)

AS
/******************************************************************************
**		File: sps_PendingSecondaryWIP.sql
**		Name: sps_PendingSecondaryWIP
**		Desc: Obtains list of LogEvents with a status of pending
**
**              
**		Return values: returns pending secondary 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vTZ	VARCHAR(2)
**
**		Auth: Dave Hoffmann
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/05/05	Bret Knoll			reorganizing query. The previous version of this query	
**										was joining on my tables than necessary. I am removing 	
**										the join on Call, Referral, Organization, StatEmployee, 
**										Person and Organization as Person Organization or PO
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**		01/25/2010  ccarroll			Ambiguous column name 'FSCaseCreateDateTime'
**										changed Order By to ordinal
**		03/01/2010  Bret Knoll			Modified based on Performance Tune recommendation.
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- Now that you have the FSCallIds to exclude, perform the main query.  1/28/05 - SAP
	SELECT DISTINCT
		Call.CallID, 
		0, 
		Call.CallNumber,
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCaseCreateDateTime
					),
				FSCaseCreateDateTime
			) AS 'FSCaseCreateDateTime', 
		Organization.OrganizationName, 
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCaseCreateDateTime
					),
				FSCaseCreateDateTime
			) AS 'FSCaseCreateDateTime',
		'' AS Spacer,		
		'' AS Spacer,
		PO.OrganizationID,
		Case when FSCase.FSCaseOpenUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSysEventsUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseSecCompUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseApproachUserId > 0 Then 'X' Else '' END,
		Case when FSCase.FSCaseFinalUserId > 0 Then 'X' Else '' END,
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCase.FSCaseOpenDateTime
					),
				FSCase.FSCaseOpenDateTime
			) AS 'FSCaseOpenDateTime',
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCase.FSCaseSysEventsDateTime
					),
				FSCase.FSCaseSysEventsDateTime
			) AS 'FSCaseSysEventsDateTime',
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCase.FSCaseSecCompDateTime
					),
				FSCase.FSCaseSecCompDateTime
			) AS 'FSCaseSecCompDateTime',
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCase.FSCaseApproachDateTime
					),
				FSCase.FSCaseApproachDateTime
			) AS 'FSCaseApproachDateTime',
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCase.FSCaseFinalDateTime
					),
				FSCase.FSCaseFinalDateTime
			) AS 'FSCaseFinalDateTime'
	
	FROM 	
		Call 	
	JOIN 	
		FSCase ON FSCase.CallID = Call.CallID
	JOIN 	
		Referral ON Referral.CallID = Call.CallID
	JOIN 	
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	--JOIN		LogEvent ON LogEvent.CallID = Call.CallID
	LEFT	 
	JOIN 	
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT 
	JOIN 	
		Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT	 
	JOIN 	
		Organization PO ON PO.OrganizationID = Person.OrganizationID
    LEFT JOIN WebReportGroupSourceCode 
         ON WebReportGroupSourceCode.SourceCodeID >= Call.SourceCodeID 
            AND WebReportGroupSourceCode.SourceCodeID <= Call.SourceCodeID 
	JOIN 
		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	
	WHERE
		FSCaseOpenUserId <> 0 
	AND 	
		FSCase.FSCaseFinalUserId = 0 
	 --AND	PO.OrganizationLOFSEnabled <> -1 
	
			--LogEvent.LogEventTypeID NOT IN(6, 14)-- 6	Page Pending, 14	Callout Pending
	-- the following AND statement filters out pending referrals where the LO is enabled
	-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
	-- Statline will see calls where they are taking them, where the LO has switch calls to us.
	-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
	-- LO will see all referrals based on the statment. The next statment limits their access
	-- in the final app this will be OrganizationLOEnabled
	
	AND
			
		PO.OrganizationLOFSEnabled = 
			Case 
				when 
					@LeaseOrg > 0 
				Then 
					PO.OrganizationLOFSEnabled 
				else 
					0 
			end -- Added for LO
 	-- Added for LO 
	-- IF a LO is using the application they will only see their referrals
	-- If Statline is using the application they will see all referrals	
	AND 
		WebReportGroup.OrgHierarchyParentID = 
			Case 
				when 
					@LeaseOrg > 0 
				Then 
					@LeaseOrg 
				Else 
					WebReportGroup.OrgHierarchyParentID 
	
			END -- Added for LO
	AND	
		FSCaseId NOT IN (		
				SELECT 
					FSCase.FSCaseId
				FROM 	LogEvent 
				
				LEFT  
				JOIN 	FSCase ON FSCase.CallID = LogEvent.CallID

				WHERE 
				LogEvent.LogEventCallbackPending=-1
				AND FSCase.FSCaseOpenUserId <> 0  
				AND FSCase.FSCaseFinalUserId = 0 
				AND
				(
				-- LogEventType Page Pending
				LogEvent.LogEventTypeID = 6
					or
				-- LogEvent Type Callout Pending
   				LogEvent.LogEventTypeID = 14
   		))

	ORDER BY 4 DESC; --FSCaseCreateDateTime



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

