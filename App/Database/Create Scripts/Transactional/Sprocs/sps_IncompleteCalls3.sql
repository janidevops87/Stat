SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IncompleteCalls3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IncompleteCalls3]
GO


CREATE PROCEDURE sps_IncompleteCalls3

	@LeaseOrg INT =0
AS


	
	SELECT 	DISTINCT
		Call.CallID, 
		Call.CallTempExclusive,
		Call.CallNumber,
		Call.CallDateTime, 
		ISNULL(SourceCodeName,'') + ' - ' + ISNULL(Organization.OrganizationName,''),
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),''), 
		''AS Spacer,-- blank to position StatEmployeeID in position 8
		''AS Spacer,
		' 'AS Spacer,
		PO.OrganizationID		
	FROM 	Call
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.CallTempSavedByID
	JOIN	Person ON Person.PersonID = StatEmployee.PersonID
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	JOIN	Referral ON Referral.CallID = Call.CallID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID


	WHERE 	Call.CallTemp = -1 
	-- 
	AND	PO.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO

	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO
	
	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

UNION ALL

	SELECT 	Distinct 
		Call.CallID, 
		Call.CallTempExclusive,
		Call.CallNumber,
		Call.CallDateTime, 
		'* Imp - ' + ISNULL(Organization.OrganizationName,''),
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),''),
		''AS Spacer,
		''AS Spacer,
		''AS Spacer,
		PO.OrganizationID
	FROM 	Call
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.CallTempSavedByID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID

	LEFT JOIN Message ON Message.CallID = Call.CallID
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID
	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID
	
	WHERE 	Call.CallTemp = -1 
	AND	MessageTypeID = 2
	--AND 	Person.OrganizationID = Isnull(@LeaseOrg,Person.OrganizationID)
	AND	PO.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO

	AND	Message.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else Message.OrganizationID END -- Added for LO
	
	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

UNION ALL

	SELECT 	Call.CallID, 
		Call.CallTempExclusive,
		Call.CallNumber,
		Call.CallDateTime, 
		'* Msg - ' + ISNULL(Organization.OrganizationName,''),
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),''),
		''AS Spacer,
		''AS Spacer,
		''AS Spacer,
		PO.OrganizationID	
	FROM 	Call
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.CallTempSavedByID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID

	LEFT JOIN Message ON Message.CallID = Call.CallID
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID
	-- added join to join Person that took the call to their organization 
	LEFT JOIN Organization PO ON PO.OrganizationID = Person.OrganizationID

	WHERE 	Call.CallTemp = -1 
	AND	MessageTypeID <> 2
--	AND Person.OrganizationID = Isnull(@LeaseOrg,Person.OrganizationID)
	AND	PO.OrganizationLOEnabled = Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO

	AND	Message.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else Message.OrganizationID END -- Added for LO

	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

	ORDER BY 
		Call.CallDateTime DESC




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

