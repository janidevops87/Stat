 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingSecondaryAlertSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingSecondaryAlertSelect';
		DROP Procedure DashboardPendingSecondaryAlertSelect;
	END
GO
PRINT 'Creating Procedure DashboardPendingSecondaryAlertSelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER OFF;
GO
CREATE PROCEDURE [dbo].[DashboardPendingSecondaryAlertSelect]
	@LeaseOrg	int =0,
	@timeZone	varchar(2),
	@StatEmployee int = 0

AS
/******************************************************************************
**		File: DashboardPendingSecondaryAlertSelect.sql
**		Name: DashboardPendingSecondaryAlertSelect
**		Desc: returns pending secondary alert
** 
**		Called by:   StatTrac Dashboard
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@LeaseOrg	INT =0,
**		@TimeZone	VARCHAR(2),
**		@StatEmployee	int = 0
**
**		Auth: ccarroll	
**		Date: 09/30/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/30/2010	ccarroll			adapted from sps_PendarySecondaryAlert
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
		sc.SourceCodeName,
		PO.OrganizationID AS PersonOrganizationID,
		Organization.OrganizationID,
		Call.SourceCodeID
	
	FROM		Call
	JOIN 		FSCase ON FSCase.CallID = Call.CallID
	JOIN 		Referral ON Referral.CallID = Call.CallID
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN	SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT JOIN	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT JOIN	Person ON Person.PersonID = StatEmployee.PersonID --to join Person that took the call to their organization 
	LEFT JOIN	Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 		WebReportGroup PC ON PC.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	
	WHERE		FSCaseOpenUserId = 0 
	AND 		FSCase.FSCaseFinalUserId = 0 
	AND			PO.OrganizationLOFSEnabled = 
					CASE WHEN @LeaseOrg > 0 THEN PO.OrganizationLOFSEnabled ELSE 0 END -- Added for LO
	AND			PC.OrgHierarchyParentID =
					CASE WHEN @LeaseOrg > 0 THEN @LeaseOrg ELSE PC.OrgHierarchyParentID END -- Added for LO
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
		FSCaseCreateDateTime;


GO


