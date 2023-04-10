 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingSecondaryActivitySelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingSecondaryActivitySelect';
		DROP Procedure DashboardPendingSecondaryActivitySelect;
	END
GO
PRINT 'Creating Procedure DashboardPendingSecondaryActivitySelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER OFF;
GO

CREATE  PROCEDURE [dbo].[DashboardPendingSecondaryActivitySelect]
	@LeaseOrg int = 0, 
	@timeZone varchar(2),
	@StatEmployee int = 0
AS
/******************************************************************************
**		File: DashboardPendingSecondaryActivitySelect.sql
**		Name: DashboardPendingSecondaryActivitySelect
**		Desc: returns pending secondary activity for dashboard
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		see above
**
**		Auth: ccarroll
**		09/30/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/30/2010	ccarroll			adapted from sps_PendingSecondaryActivity
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

	IF(@LeaseOrg=194 )
	BEGIN
		SET @LeaseOrg = NULL
	END
	SELECT 	DISTINCT
		Call.CallID, 
		--0, 
		Call.CallNumber,
		CASE WHEN LogEvent.LogEventTypeID = 6 -- Page Pending
				THEN DATEADD(hh, dbo.fn_TimeZoneDifference(@timeZone, LogEventDateTime), LogEventDateTime) 
				ELSE DATEADD(hh, dbo.fn_TimeZoneDifference(@timeZone, LogEventCalloutDateTime), LogEventCalloutDateTime)
		END 'LogEventCalloutDateTime',
		sc.SourceCodeName AS 'SourceCodeName', 
		LogEvent.LogEventName,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) AS LogEventPerson,
		DATEADD(hh, dbo.fn_TimeZoneDifference(@timeZone, LogEventDateTime), LogEventDateTime) AS 'LogEventDateTime',
		PO.OrganizationID AS PersonOrganizationID,
		LogEvent.LogEventTypeID,
		CASE WHEN FSCase.FSCaseOpenUserId > 0 THEN 'X' ELSE '' END AS FSCaseOpen,
		CASE WHEN FSCase.FSCaseSysEventsUserId > 0 THEN 'X' ELSE '' END AS FSCaseSystemEvent,
		CASE WHEN FSCase.FSCaseSecCompUserId > 0 THEN 'X' ELSE '' END AS FSCaseSecondaryComplete,
		CASE WHEN FSCase.FSCaseApproachUserId > 0 THEN 'X' ELSE '' END AS FSCaseApproached,
		CASE WHEN FSCase.FSCaseFinalUserId > 0 THEN 'X' ELSE '' END AS FSCaseFinal,
		LogEvent.LogEventOrg AS LogEventOrganization

	FROM 		Call
	JOIN		LogEvent ON LogEvent.CallID = Call.CallID	
	JOIN 		FSCase ON FSCase.CallID = LogEvent.CallID
	JOIN 		Referral ON Referral.CallID = Call.CallID
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN 	SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID 
	LEFT JOIN 	Person ON Person.PersonID = StatEmployee.PersonID -- to join Person that took the call to their organization 
	LEFT JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 		FSCase.FSCaseOpenUserId <> 0 
	AND 		FSCase.FSCaseFinalUserId = 0 
	AND			LogEvent.LogEventCallbackPending = -1
	AND			( 
					LogEvent.LogEventTypeID = 6 -- 6	Page Pending,
					or
					LogEvent.LogEventTypeID = 14 --  14	Callout Pending
				)
				-- the following AND statement filters out pending referrals where the LO is enabled
				-- If Statline is the current user and @LeaseOrg is 0 only LO Disabled calls or calls where the the OrganizationLeaseEnabled is 0 .
				-- Statline will see calls where they are taking them, where the LO has switch calls to us.
				-- Statline will not see calls where the LO is taking them, where the LO has calls to their call center
				-- LO will see all referrals based on the statment. The next statment limits their access
				-- in the final app this will be OrganizationLOEnabled
	AND			(

				 @LeaseOrg > 0 and PO.OrganizationLOFSEnabled = PO.OrganizationLOFSEnabled
				or 
				PO.OrganizationLOFSEnabled =  0
				-- PO.OrganizationLOFSEnabled =  CASE WHEN @LeaseOrg > 0 THEN PO.OrganizationLOFSEnabled ELSE 0 END -- Added for LO
				-- IF a LO is using the application they will only see their referrals
				-- If Statline is using the application they will see all referrals
				)
	--AND 		WebReportGroup.OrgHierarchyParentID = 
				--CASE WHEN @LeaseOrg > 0 THEN @LeaseOrg ELSE WebReportGroup.OrgHierarchyParentID END -- Added for LO
	AND (  
			@LeaseOrg is null or person.organizationid = @LeaseOrg
		)		
	--Make sure user is in admin role or this call has a secondary pending event created by someone in the logged in user's organization
	AND			(@IsUserInAdminRole = 1 OR EXISTS (SELECT 1 
													FROM LogEvent le 
														JOIN LogEventType let ON le.LogEventTypeID = let.LogEventTypeID
														JOIN StatEmployee se ON se.StatEmployeeID = le.LastStatEmployeeID
														JOIN Person p ON p.PersonID = se.PersonID
													WHERE le.CallID = Call.CallID
													AND p.OrganizationID = @LoggedInUserOrganizationID
													AND let.LogEventTypeName = 'Secondary Pending'))
	ORDER BY 
		LogEventTypeID DESC,
		LogEventCalloutDateTime;

GO


