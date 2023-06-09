SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryActivity]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure sps_PendingSecondaryActivity'
	drop procedure [dbo].[sps_PendingSecondaryActivity]
END	
	PRINT 'Creating procedure sps_PendingSecondaryActivity'
GO

CREATE  PROCEDURE sps_PendingSecondaryActivity
	@LeaseOrg int=0, 
	@timeZone	varchar(2)
AS
/******************************************************************************
**		File: sps_PendingSecondaryActivity.sql
**		Name: sps_PendingSecondaryActivity
**		Desc: 
**
**              
**		Return values: returns pending secondary activity
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@LeaseOrg	INT =0,
**		@vTZ		VARCHAR(2)
**
**		Auth: Dave Hoffmann
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/16/2006	ccarroll			Added Join to display SourceCode Name
**										Used by Secondary Activity grid in frmOpenAll
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**		12/08/2009	ccarroll			Removed table alias in ORDER BY for SQL Server 2008 update.
**		03/13/2010 Bret Knoll			Resaving for inclusion in releae
**		03/16/2010	ccarroll			Added this note for inclusion in release
**		06/02/2010 ccarroll				Removed 6 DESC, from OrderBy and replaced with LogEventTypeID
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT 	DISTINCT
		Call.CallID, 
		0, 
		Call.CallNumber,
		CASE 
			WHEN 
				LogEvent.LogEventTypeID = 6 -- 6	Page Pending
			THEN
				DATEADD(
						hh,
						dbo.fn_TimeZoneDifference(
										@timeZone, 
										LogEventDateTime
												),
						LogEventDateTime) 
			ELSE
				DATEADD(
						hh,
						dbo.fn_TimeZoneDifference(
										@timeZone, 
										LogEventCalloutDateTime
												),
						LogEventCalloutDateTime)
		END 'LogEventDateTime',	
		sc.SourceCodeName AS 'Source', 
		LogEvent.LogEventName,
		--Organization.OrganizationName, 	--7/18/01 drh List Paged Person (LogEventName) instead of Org for Page Pendings
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		DATEADD(
				hh,
				dbo.fn_TimeZoneDifference(
											@timeZone, 
											LogEventDateTime
										), 
				LogEventDateTime) AS 'LogEventDateTime',
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

	FROM 	Call
	JOIN
			LogEvent ON LogEvent.CallID = Call.CallID	
	JOIN 
		FSCase ON FSCase.CallID = LogEvent.CallID
	JOIN 
		Referral ON Referral.CallID = Call.CallID
	JOIN 
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN 
		SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT JOIN 
		StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID		--7/23/01 drh Changed from Call.StatEmployeeID
	LEFT JOIN 
		Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT JOIN 
		Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN 
		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 
		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	
		FSCase.FSCaseOpenUserId <> 0 
	AND 
		FSCase.FSCaseFinalUserId = 0 
	AND	
		LogEvent.LogEventCallbackPending = -1
	AND
		LogEvent.LogEventTypeID IN (6, 14) -- 6	Page Pending, 14	Callout Pending
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

	ORDER BY 
		LogEventTypeID DESC, 
		4 --LogEventDateTime



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

