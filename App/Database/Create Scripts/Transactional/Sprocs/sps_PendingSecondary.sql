SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingSecondary]
GO



CREATE PROCEDURE sps_PendingSecondary 
	@LeaseOrg INT =0
AS
/******************************************************************************
**		File: sps_PendingSecondary.sql
**		Name: sps_PendingSecondary
**		Desc: Obtains list of Pending Secondaries
**
**              
**		Return values: 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@LeaseOrg INT =0,
**
**		Auth: Dave Hoffmann
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT 	DISTINCT
		Call.CallID, 
		0, 
		Call.CallNumber,
		LogEventDateTime, 
		Organization.OrganizationName, 
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		LogEventDateTime,
		''AS Spacer,
		''AS Spacer,
		PO.OrganizationID

	FROM 	LogEvent 
	LEFT JOIN Call ON Call.CallID = LogEvent.CallID
	JOIN Referral ON Referral.CallID = Call.CallID
	JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	LogEvent.LogEventTypeID = 15
	AND	LogEvent.LogEventCallbackPending=-1 
 	-- add to where for LO
 	AND	PO.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO
	
	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO

	ORDER BY 
		LogEvent.LogEventDateTime DESC




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

