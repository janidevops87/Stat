SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenReferralLO2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenReferralLO2]
GO

CREATE  PROCEDURE SPS_QueryOpenReferralLO2
	@pvStartDate	smalldatetime = NULL,
	@pvEndDate	smalldatetime = NULL,
	@pvLeaseOrgID	int,
	@vTZ		VARCHAR(2)

AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update. **/
/**	03/16/2010	ccarroll	Added this note for inclusion in release **/
DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

--SELECT @pvStartDate = DATEADD(hh, -@TZ, @pvStartDate)
--SELECT @pvEndDate = DATEADD(hh, -@TZ, @pvEndDate)

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		DATEADD(hh,@TZ,CallDateTime) AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		'' As Spacer, 
		'' As Spacer, 
		Person.OrganizationID 
	FROM 	Referral 
	LEFT 
	JOIN 	Call ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	-- bjk 01/06/2003 LEFT 	JOIN 	State ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT 
	JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person ON Person.PersonID = StatEmployee.PersonID 
	
	LEFT 
	JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
	LEFT 
	JOIN 	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	LEFT 
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
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

