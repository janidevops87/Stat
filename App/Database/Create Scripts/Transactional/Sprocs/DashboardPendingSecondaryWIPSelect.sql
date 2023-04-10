 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingSecondaryWIPSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingSecondaryWIPSelect';
		DROP Procedure DashboardPendingSecondaryWIPSelect;
	END
GO
PRINT 'Creating Procedure DashboardPendingSecondaryWIPSelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE  PROCEDURE [dbo].[DashboardPendingSecondaryWIPSelect]
	@LeaseOrg	int = 0,
	@timeZone	varchar(2),
	@StatEmployee int = 0

AS
/******************************************************************************
**		File: DashboardPendingSecondaryWIPSelect.sql
**		Name: DashboardPendingSecondaryWIPSelect
**		Desc: Obtains list of LogEvents with a status of pending
**
**		Called by: StatTrac Dashboard  
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		see above
**
**		Auth: ccarroll	
**		Date: 09/30/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/30/2010	ccarroll			adapted from sps_PendingSecondaryWIP
**		06/24/2011	Bret				Referral exists in Family Services after a 
					Secondary Pending is created and referral show in the Work In Process in the lower right.
					Scenario 1. Pending Event (Page or Callout Pending) is created by the organization working 
					In FS the referral will move to the left side of the screen.
					Scenario 2. If instead Statline create (Page or Callout Pending) the referral is unaffected 
					in the FS for ASP organizations.
**		10/15/2018	mberenson			Added @StatEmployee parameter & logic that makes 
**											sure users who don't have the SL:Administration-Statline
**											don't see cases where the Secondary Pending event was
**											created by someone outside of the Statline organization
**		10/24/2018	mberenson			Added logic to hide records for non-administrators when a different
**											statemployee loads the grid than the statemployee who created the 
**											secondary pending event
**		10/25/2018	mberenson			Changed logic to show records for non-administrators only when the
**											the referral's organization matches the logged in user's 
**											organization
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	--Determine whether the logged in user is in the SL:Administration-Statline role
	DECLARE @IsUserInAdminRole AS BIT = (SELECT CAST(COUNT(1) AS BIT)
											FROM dbo.StatEmployee se 
												JOIN dbo.Person p ON p.PersonID = se.PersonID
												JOIN dbo.WebPerson wp ON p.PersonID = wp.PersonID
												JOIN dbo.UserRoles ur ON ur.WebPersonID = wp.WebPersonID
												JOIN dbo.Roles r ON r.RoleID = ur.RoleID
											WHERE r.RoleName = 'SL:Administration-Statline'
											AND se.StatEmployeeID = @StatEmployee);

	--Look up the organizationid for the logged in user
	DECLARE @LoggedInUserOrganizationID AS INT = (SELECT TOP (1) p.OrganizationID
													FROM Person p
														JOIN StatEmployee se ON se.PersonID = p.PersonID
													WHERE se.StatEmployeeID = @StatEmployee);

	SELECT DISTINCT
		Call.CallID, 
		Call.CallNumber,
		DATEADD (hh, dbo.fn_TimeZoneDifference (@timeZone, FSCaseCreateDateTime), FSCaseCreateDateTime) AS FSCaseCreateDateTime, 
		Organization.OrganizationName, 
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) AS PersonName,
		PO.OrganizationID AS PersonOrganizationID,
		CASE WHEN FSCase.FSCaseOpenUserId > 0 THEN 'X' ELSE '' END AS FSCaseOpen,
		CASE WHEN FSCase.FSCaseSysEventsUserId > 0 THEN 'X' ELSE '' END AS FSCaseSystemEvent,
		CASE WHEN FSCase.FSCaseSecCompUserId > 0 THEN 'X' ELSE '' END AS FSCaseSecondaryComplete,
		CASE WHEN FSCase.FSCaseApproachUserId > 0 THEN 'X' ELSE '' END AS FSCaseApproached,
		CASE WHEN FSCase.FSCaseFinalUserId > 0 THEN 'X' ELSE '' END AS FSCaseFinal,
		DATEADD (hh, dbo.fn_TimeZoneDifference (@timeZone, FSCase.FSCaseOpenDateTime), FSCase.FSCaseOpenDateTime) AS FSCaseOpenDateTime,
		DATEADD	(hh, dbo.fn_TimeZoneDifference (@timeZone, FSCase.FSCaseSysEventsDateTime), FSCase.FSCaseSysEventsDateTime) AS FSCaseSystemEventDateTime,
		DATEADD	(hh, dbo.fn_TimeZoneDifference (@timeZone, FSCase.FSCaseSecCompDateTime), FSCase.FSCaseSecCompDateTime) AS FSCaseSecondaryCompleteDateTime,
		DATEADD	(hh, dbo.fn_TimeZoneDifference (@timeZone, FSCase.FSCaseApproachDateTime), FSCase.FSCaseApproachDateTime) AS FSCaseApproachDateTime,
		DATEADD (hh, dbo.fn_TimeZoneDifference (@timeZone, FSCase.FSCaseFinalDateTime), FSCase.FSCaseFinalDateTime) AS FSCaseFinalDateTime
	
	FROM 		Call 	
	JOIN 		FSCase ON FSCase.CallID = Call.CallID
	JOIN 		Referral ON Referral.CallID = Call.CallID
	JOIN 		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT JOIN	Person ON Person.PersonID = StatEmployee.PersonID
	LEFT JOIN	Organization PO ON PO.OrganizationID = Person.OrganizationID -- join Person that took the call to their organization 
    LEFT JOIN	WebReportGroupSourceCode
					ON WebReportGroupSourceCode.SourceCodeID >= Call.SourceCodeID 
					AND WebReportGroupSourceCode.SourceCodeID <= Call.SourceCodeID 
	JOIN		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	
	WHERE
		FSCaseOpenUserId <> 0 
	AND FSCase.FSCaseFinalUserId = 0 
			--LogEvent.LogEventTypeID NOT IN(6, 14)-- 6	Page Pending, 14	Callout Pending
			-- the following AND statement filters out pending referrals where the LO is enabled
			-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
			-- Statline will see calls where they are taking them, where the LO has switch calls to us.
			-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
			-- LO will see all referrals based on the statment. The next statment limits their access
			-- in the final app this will be OrganizationLOEnabled
	AND	PO.OrganizationLOFSEnabled = 
			CASE WHEN @LeaseOrg > 0 THEN PO.OrganizationLOFSEnabled ELSE 0 END -- Added for LO
			-- IF a LO is using the application they will only see their referrals
			-- If Statline is using the application they will see all referrals	
	AND WebReportGroup.OrgHierarchyParentID = 
			CASE WHEN @LeaseOrg > 0 THEN @LeaseOrg ELSE WebReportGroup.OrgHierarchyParentID END -- Added for LO
	AND	FSCaseId NOT IN (SELECT FSCase.FSCaseId 
							FROM LogEvent
							LEFT JOIN FSCase ON FSCase.CallID = LogEvent.CallID
							LEFT JOIN StatEmployee ON LogEvent.LastStatEmployeeID = StatEmployee.StatEmployeeID
							LEFT JOIN Person ON StatEmployee.PersonID = Person.PersonID
							AND Person.OrganizationID = @LeaseOrg							
							WHERE LogEvent.LogEventCallbackPending = -1
								AND FSCase.FSCaseOpenUserId <> 0
								AND FSCase.FSCaseFinalUserId = 0
								AND	LogEvent.LogEventTypeID IN (6, 14) --(6)Page Pending (14)Callout Pending
								AND Person.OrganizationID IS NOT NULL
						)	
	--Make sure user is in admin role or this call has a secondary pending event created by someone in the logged in user's organization
	AND	(@IsUserInAdminRole = 1 OR EXISTS (SELECT 1 
											FROM LogEvent le 
												JOIN LogEventType let ON le.LogEventTypeID = let.LogEventTypeID
												JOIN StatEmployee se ON se.StatEmployeeID = le.LastStatEmployeeID
												JOIN Person p ON p.PersonID = se.PersonID
											WHERE le.CallID = Call.CallID
											AND p.OrganizationID = @LoggedInUserOrganizationID
											AND let.LogEventTypeName = 'Secondary Pending'))
ORDER BY FSCaseCreateDateTime DESC;

GO
