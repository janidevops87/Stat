SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallerPersonSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallerPersonSummary_A]
GO





CREATE PROCEDURE sps_CallerPersonSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0

AS

IF	@vOrgID = 0

    	SELECT 	Referral_CallerPersonCount.OrganizationID, OrganizationName, 
			Referral_CallerPersonCount.CallerPersonID, PersonLast + ', ' + PersonFirst AS PersonName,
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_CallerPersonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_CallerPersonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallerPersonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_CallerPersonCount.CallerPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_CallerPersonCount.OrganizationID, OrganizationName, CallerPersonID,  PersonLast + ', ' + PersonFirst
    	ORDER BY 	OrganizationName, PersonLast + ', ' + PersonFirst

IF	@vOrgID > 0

    	SELECT 	YearID, Referral_CallerPersonCount.MonthID  AS MonthID, 
			CallerPersonID, PersonLast + ', ' + PersonFirst AS PersonName,
			CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			Referral_CallerPersonCount.OrganizationID, OrganizationName, Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO

    	FROM 		Referral_CallerPersonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_CallerPersonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallerPersonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_CallerPersonCount.CallerPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_CallerPersonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_CallerPersonCount.OrganizationID = @vOrgID

	GROUP BY	YearID, Referral_CallerPersonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_CallerPersonCount.OrganizationID, OrganizationName, CallerPersonID,  PersonLast + ', ' + PersonFirst
    	ORDER BY 	YearID, Referral_CallerPersonCount.MonthID, OrganizationName, PersonLast + ', ' + PersonFirst













GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

