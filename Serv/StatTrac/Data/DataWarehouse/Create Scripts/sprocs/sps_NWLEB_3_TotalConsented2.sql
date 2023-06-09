SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_NWLEB_3_TotalConsented2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_NWLEB_3_TotalConsented2]
GO


CREATE PROCEDURE sps_NWLEB_3_TotalConsented2

	@vReportGroupID	int	= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int	= 0,
	@vBreakOnOrg		int	= 0

AS

IF @vOrgID = 0
     BEGIN
	IF @vBreakOnOrg <> 0 -- Individually break down totals by org

    		SELECT 		
			Sum(ConsentEyes) AS ConsentEyes,
			Sum(ConsentTissue) AS ConsentTissue,
			Sum(ConsentOrgan) AS ConsentOrgan,
			_ReferralProdReport.dbo.Organization.OrganizationID,
			_ReferralProdReport.dbo.Organization.OrganizationName

    		FROM Referral_ConsentReasonCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
		    	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
		GROUP BY _ReferralProdReport.dbo.Organization.OrganizationID, _ReferralProdReport.dbo.Organization.OrganizationName
		ORDER BY _ReferralProdReport.dbo.Organization.OrganizationName


	ELSE IF @vBreakOnOrg = 0 -- Get total for all orgs, not broken down individually

    		SELECT 		
			Sum(ConsentEyes) AS ConsentEyes,
			Sum(ConsentTissue) AS ConsentTissue,
			Sum(ConsentOrgan) AS ConsentOrgan

    		FROM Referral_ConsentReasonCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
		    	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

     END

IF	@vOrgID > 0

    	SELECT 
			Sum(ConsentEyes) AS ConsentEyes,
			Sum(ConsentTissue) AS ConsentTissue,
			Sum(ConsentOrgan) AS ConsentOrgan

    	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ConsentReasonCount.MonthID

	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ConsentReasonCount.OrganizationID = @vOrgID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

