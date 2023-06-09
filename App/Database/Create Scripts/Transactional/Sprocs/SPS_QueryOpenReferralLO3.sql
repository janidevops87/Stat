SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenReferralLO3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenReferralLO3]
GO




CREATE  PROCEDURE SPS_QueryOpenReferralLO3
	@pvStartDate	smalldatetime = NULL,
	@pvEndDate	smalldatetime = NULL,
	@pvLeaseOrgID	int,
	@vTZ		VARCHAR(2),
	@vReturnLimit 		Int = 0

AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update. **/
/**	03/16/2010	ccarroll	Added this note for inclusion in release **/
DECLARE @TZ int   

EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

IF @vReturnLimit > 0
     BEGIN
	SET ROWCOUNT @vReturnLimit 

	-- Limit the date range to 10 days, since only 200 are coming back anyway
	IF DateDiff(d, @pvStartDate, @pvEndDate) > 10
	    BEGIN
		SET @pvStartDate = DateAdd(d, -10, @pvEndDate)
	    END
     END
	--The following select needs to have the same columns as SPS_QueryOpenReferral2 so
	--the array reference of the returned select statement would be correct in modcontrol.setlistviewrows
	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		DATEADD(hh,@TZ,CallDateTime) AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,  -- Added 5/23/05 - SAP
		Person.OrganizationID, 
		Person.OrganizationID, 
		Person.OrganizationID 
	FROM 	Referral (NOLOCK)
	LEFT 
	JOIN 	Call (NOLOCK) ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization (NOLOCK) ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	-- bjk 01/06/2003 LEFT 	JOIN 	State ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType (NOLOCK) ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT 
	JOIN	ReferralType PrevReferralType (NOLOCK) ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT
	JOIN 	SourceCode (NOLOCK) ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee (NOLOCK) ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person (NOLOCK) ON Person.PersonID = StatEmployee.PersonID 
	
	LEFT 
	JOIN 	WebReportGroupOrg (NOLOCK) ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
	LEFT 
	JOIN 	WebReportGroupSourceCode (NOLOCK) ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	LEFT 
	JOIN 	WebReportGroup (NOLOCK) ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
	AND 	WebReportGroupOrg.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID

	
	/* 	02/25/03 bjk: combined all four joins
	
	LEFT 
	JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT 
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
	*/
	/* 02/21/02 bjk: removed and added previous two joins
	LEFT 
	JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
        LEFT 
        JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID 
	*/
	
	
	WHERE	CallDateTime >= @pvStartDate
	AND 	CallDateTime <= @pvEndDate
	AND 	WebReportGroup.OrgHierarchyParentID = @pvLeaseOrgID
	ORDER 
	BY 	CallDateTime DESC;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

