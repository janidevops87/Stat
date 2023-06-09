SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_ReferralNumber]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_ReferralNumber]
GO


Create Procedure [dbo].[FSBCase_ReferralNumber]
As
Begin
	/*
		FSBCase_ReferralNumber returns callnumbers pending the start of a secondary.
		
	*/
	
	SELECT DISTINCT
		
			--Call.CallID	, 
		    Call.CallNumber as 'ReferralNumber'
			
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
	JOIN 	WebReportGroup PC ON PC.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	

	WHERE 	FSCaseOpenUserId = 0 
	AND 	FSCase.FSCaseFinalUserId = 0 
	-- add to where for LO
	AND	PO.OrganizationLOFSEnabled = Case when 0 > 0 Then PO.OrganizationLOFSEnabled else 0 end -- Added for LO
	
	AND     PC.OrgHierarchyParentID = Case when 0 > 0 Then 0 Else PC.OrgHierarchyParentID END -- Added for LO

	ORDER BY 1 DESC
End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

