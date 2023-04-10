SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IncompleteCalls]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure sps_IncompleteCalls'
	drop procedure [dbo].[sps_IncompleteCalls]
END	
PRINT 'Creating procedure sps_IncompleteCalls'

GO
CREATE PROCEDURE sps_IncompleteCalls

	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)

AS
/******************************************************************************
**		File: sps_IncompleteCalls.sql
**		Name: sps_IncompleteCalls
**		Desc: 
**
**              
**		Return values: returns list of referrals set as inscomplete
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Tim Klug
**		Date: 09/01/1996
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**      01/22/2010 ccarroll				Removed table prefix In Order By for SQL2008
**		03/13/2010 Bret Knoll			Resaving for inclusion in releae
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @TZ int      
	EXEC spf_TZDif @vTZ, @TZ OUTPUT

	-- select incomplete referrals
	SELECT 	DISTINCT
		Call.CallID, 
		Call.CallTempExclusive,
		Call.CallNumber,
		DATEADD(hh,@TZ,Call.CallDateTime) AS 'CallDateTime', 
		ISNULL(SourceCodeName,'') + ' - ' + ISNULL(Organization.OrganizationName,''),
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),''), 
		''AS Spacer,-- blank to position StatEmployeeID in position 8
		''AS Spacer,
		''AS Spacer,
		PO.OrganizationID		
	-- BJK 08/04/06 modified FROM and JOINs goal is to obtain shared locks in same order across application
	FROM    Referral 
	JOIN 	Call ON Call.CallID = Referral.CallID 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.CallTempSavedByID
	JOIN	Person ON Person.PersonID = StatEmployee.PersonID
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT 
	JOIN 	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	-- added join to join Person that took the call to their organization 
	LEFT 
	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	/*
	LEFT 
	JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	*/

	WHERE 	Call.CallTemp = -1 
	-- 
	
	AND	PO.OrganizationLOTriageEnabled = 0 -- Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO
	/*
	AND     WebReportGroup.OrgHierarchyParentID = Case when @LeaseOrg > 0 Then @LeaseOrg Else WebReportGroup.OrgHierarchyParentID END -- Added for LO
	*/	
	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)

UNION ALL
	-- query imports
	SELECT 	Distinct 
		Call.CallID, 
		Call.CallTempExclusive,
		Call.CallNumber,
		DATEADD(hh,@TZ,Call.CallDateTime) AS 'CallDateTime', 
		-- BJK 08/04/06 combined imports and messages
		CASE MessageTypeID
			WHEN 2 THEN	'* Imp - ' 
			ELSE 		'* Msg - '
		END + ISNULL(Organization.OrganizationName,''),
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),''),
		''AS Spacer,
		''AS Spacer,
		''AS Spacer,
		PO.OrganizationID
	-- BJK 08/04/06 modified FROM and JOINs goal is to obtain shared locks in same order across application
	FROM 	Message 
	JOIN	Call ON Call.CallID = Message.CallID 

	LEFT 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.CallTempSavedByID
	LEFT 
	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID
	LEFT 
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT 
	JOIN 	Organization ON Organization.OrganizationID = Message.OrganizationID
	-- added join to join Person that took the call to their organization 
	LEFT 
	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	
	WHERE 	Call.CallTemp = -1 
	AND
		-- BJK 08/04/06 combined imports and messages
		( 
			( 
			MessageTypeID = 2
			)
		OR 
			(
			MessageTypeID <> 2
			)
		)
	
	--AND 	Person.OrganizationID = Isnull(@LeaseOrg,Person.OrganizationID)

	AND	PO.OrganizationLOTriageEnabled = 0 -- Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO
	/*
	AND	PO.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else PO.OrganizationID END -- Added for LO
	*/
	-- 	02/21/03 bjk replace with previous line 

		--AND	Message.OrganizationID = Case when @LeaseOrg > 0 Then @LeaseOrg Else Message.OrganizationID END -- Added for LO

	--7/9/01 drh Do not list Family Services Calls
	AND Call.CallID NOT IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0)
-- BJK 08/04/06 Removed third query below the second union and combined with second unioned query
	ORDER BY 
		CallDateTime DESC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

