SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPersonSummary_A_Prod]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachPersonSummary_A_Prod]
GO

CREATE PROCEDURE sps_ApproachPersonSummary_A_Prod

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

IF	@vOrgID = 0

    	SELECT 		Referral_ApproachPersonCount.OrganizationID, 
			ApproachPersonID,
			PersonLast + ", " + PersonFirst As PersonName,
			OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_ApproachPersonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachPersonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonCount.OrganizationID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ApproachPersonCount.OrganizationID, OrganizationName, ApproachPersonID, PersonLast + ", " + PersonFirst
    	ORDER BY 	OrganizationName, PersonLast + ", " + PersonFirst

IF	@vOrgID > 0

    	SELECT 		YearID, Referral_ApproachPersonCount.MonthID AS MonthID, 
			ApproachPersonID, PersonLast + ", " + PersonFirst As PersonName,
			CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			Referral_ApproachPersonCount.OrganizationID, OrganizationName, Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_ApproachPersonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachPersonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonCount.OrganizationID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ApproachPersonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ApproachPersonCount.OrganizationID = @vOrgID

	GROUP BY	YearID, Referral_ApproachPersonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_ApproachPersonCount.OrganizationID, OrganizationName, ApproachPersonID, PersonLast + ", " + PersonFirst
    	ORDER BY 	YearID, Referral_ApproachPersonCount.MonthID, OrganizationName, PersonLast + ", " + PersonFirst










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

