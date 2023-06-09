SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MessageCountSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MessageCountSummary_A]
GO



CREATE PROCEDURE sps_MessageCountSummary_A
	@vOrgID			int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null
	

AS

    	SELECT 		Referral_MessageCountSummary.OrganizationID,
    			_ReferralProdReport.dbo.Organization.OrganizationName,
    			SUM(TotalMessages) AS 'TotalMessages',
    			SUM(TotalImports) AS 'TotalImports'
    			
    	
    	FROM 		Referral_MessageCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_MessageCountSummary.OrganizationID
	--JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID

	
   	WHERE 		Referral_MessageCountSummary.OrganizationID = @vOrgID	
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MessageCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MessageCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	
	GROUP BY 	Referral_MessageCountSummary.OrganizationID, _ReferralProdReport.dbo.Organization.OrganizationName
	













GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

