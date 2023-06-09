SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryAlert1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingSecondaryAlert1]
GO







CREATE PROCEDURE sps_PendingSecondaryAlert1
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)

AS

DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT

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
		PO.OrganizationID
	
	FROM 	FSCase
	LEFT 
	JOIN 	Call ON FSCase.CallID = Call.CallID
	JOIN 	Referral ON Referral.CallID = Call.CallID
	JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT 
	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT 
	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT 
	JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	WHERE 	FSCaseOpenUserId = 0 
	AND 	FSCase.FSCaseFinalUserId = 0 
	-- add to where for LO
	AND	PO.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO
	
	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO

	ORDER BY FSCaseCreateDateTime DESC








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

