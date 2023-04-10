 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardIncompletesSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardIncompletesSelect'
		DROP Procedure DashboardIncompletesSelect
	END
GO
PRINT 'Creating Procedure DashboardIncompletesSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardIncompletesSelect.sql
**	Name: DashboardIncompletesSelect
**	Desc: List incomplete referrals
**	Auth: jth
**	Date: Sept. 2010
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
	09/10			jth						initial
**	09/13/2012		Chris Carroll			Fixed Message Type CASE statement HS:33160
*******************************************************************************/

CREATE PROCEDURE DashboardIncompletesSelect
	-- Add the parameters for the stored procedure here
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2)
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
    
    DECLARE @TZ int,
			@expirationminutes int,
			@overexpirationminutes int,
			@StatlineOrganizationId INT = 194;
	--select these once for the org...timer for incomplete window and expire and overexpire
SELECT TOP 1 @expirationminutes = [expirationminutes]  FROM OrganizationDashBoardTimer where DashBoardWindowId=1 and DashBoardTimerTypeID = 1 and OrganizationID = @LeaseOrg; 
SELECT TOP 1 @overexpirationminutes = [expirationminutes] FROM OrganizationDashBoardTimer  where DashBoardWindowId=1 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg;

EXEC spf_TZDif @vTZ, @TZ OUTPUT

IF (object_id('tempdb..#sourceCodeList') is not null)
BEGIN
	DROP TABLE #sourceCodeList;
END


SELECT
	WebReportGroupSourceCode.SourceCodeID
INTO #sourceCodeList
FROM
	WebReportGroup
INNER JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
WHERE
	WebReportGroup.OrgHierarchyParentID = @LeaseOrg;


	-- select incomplete referrals
	SELECT 	DISTINCT
		Call.CallID, 
		Call.CallTempExclusive,
		DATEADD(hh,@TZ,CallIncompleteDate.LastModified) AS 'CallDateTime', 
		ISNULL(SourceCodeName,'') + ' - ' + ISNULL(Organization.OrganizationName,'') Organization,
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),'') SavedBy, 
		person.OrganizationID,
		Referral.ReferralDonorName,
		CASE 
			WHEN (CAll.calltypeid = 1) then (Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID))
			WHEN (CAll.calltypeid = 6) THEN 'OAS'  
		END as CallType,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		CallIncompleteDate.LastModified
	FROM    Referral 
	JOIN 	Call ON Call.CallID = Referral.CallID 
	JOIN	CallIncompleteDate ON CallIncompleteDate.CallID = Referral.CallID  
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = CallIncompleteDate.StatEmployeeID
	JOIN	Person ON Person.PersonID = StatEmployee.PersonID
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	JOIN	#sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID
	LEFT 	JOIN 	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT 	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	
	WHERE 	Call.CallTemp = -1 
	AND	(
			(@LeaseOrg = @StatlineOrganizationId AND PO.OrganizationLOTriageEnabled = 0)
			OR (@LeaseOrg <> @StatlineOrganizationId AND person.OrganizationID = @leaseorg)
		)
	
UNION ALL
	-- query imports
	SELECT 	Distinct 
		Call.CallID, 
		Call.CallTempExclusive,
		DATEADD(hh,@TZ,CallIncompleteDate.LastModified) AS 'CallDateTime', 
		ISNULL(SourceCodeName,'') + ' - ' + ISNULL(Organization.OrganizationName,'') Organization,
		ISNULL(PersonFirst,'') + ' ' + ISNULL(SUBSTRING(PersonLast,1,1),'') SavedBy,
		person.OrganizationID,
		''AS Spacer,
		CASE 
			WHEN (Message.messagetypeid = 2) THEN 'I' --Import
			ELSE 'M' -- Message
		END as CallType,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
	  CallIncompleteDate.LastModified
	
	FROM 	Message 
	JOIN	Call ON Call.CallID = Message.CallID 
	JOIN	CallIncompleteDate ON CallIncompleteDate.CallID = Message.CallID 
	JOIN	#sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID

	LEFT 	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = CallIncompleteDate.StatEmployeeID
	LEFT 	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID
	LEFT 	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	LEFT 	JOIN 	Organization ON Organization.OrganizationID = Message.OrganizationID
	LEFT 	JOIN 	Organization PO ON PO.OrganizationID = Person.OrganizationID
	
	WHERE 	Call.CallTemp = -1 
	AND	(
		(@LeaseOrg = @StatlineOrganizationId AND PO.OrganizationLOTriageEnabled = 0)-- Case when @LeaseOrg > 0 Then PO.OrganizationLOEnabled else 0 end -- Added for LO
		OR (@LeaseOrg <> @StatlineOrganizationId AND person.OrganizationID = @leaseorg)
		)
	ORDER BY 
		CallDateTime; 

IF (object_id('tempdb..#sourceCodeList') is not null)
BEGIN
	DROP TABLE #sourceCodeList;
END

