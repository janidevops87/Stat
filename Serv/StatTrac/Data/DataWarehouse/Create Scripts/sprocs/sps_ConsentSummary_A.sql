SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ConsentSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ConsentSummary_A]
GO

CREATE PROCEDURE sps_ConsentSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0

AS

IF	@vOrgID = 0

    	SELECT 	Referral_TypeCount.OrganizationID, OrganizationName, 
			Sum(Referral_TypeCount.AllTypes) AS AllTypes,
			Sum(A_PreRef_Approached_DR + A_PostRef_Approached_DR + A_PreRef_Approached_NonDR + A_PostRef_Approached_NonDR) AS A_TotalApproached,
			Sum(A_PreRef_Approached_DR + A_PostRef_Approached_DR) AS A_Approach_DR, 
			Sum(A_PreRef_Approached_NonDR + A_PostRef_Approached_NonDR) AS A_Approach_NonDR, 
			Sum(A_PreRef_Consented_DR + A_PostRef_Consented_DR + A_PreRef_Consented_NonDR + A_PostRef_Consented_NonDR) AS A_TotalConsented,
			Sum(A_PreRef_Consented_DR + A_PostRef_Consented_DR) AS A_Consent_DR, 
			Sum(A_PreRef_Consented_NonDR + A_PostRef_Consented_NonDR) AS  A_Consent_NonDR,

			Sum(O_PreRef_Approached_DR + O_PostRef_Approached_DR + O_PreRef_Approached_NonDR + O_PostRef_Approached_NonDR) AS O_TotalApproached,
			Sum(O_PreRef_Approached_DR + O_PostRef_Approached_DR) AS O_Approach_DR, 
			Sum(O_PreRef_Approached_NonDR + O_PostRef_Approached_NonDR) AS  O_Approach_NonDR, 
			Sum(O_PreRef_Consented_DR + O_PostRef_Consented_DR + O_PreRef_Consented_NonDR + O_PostRef_Consented_NonDR) AS O_TotalConsented,
			Sum(O_PreRef_Consented_DR + O_PostRef_Consented_DR) AS O_Consent_DR, 
			Sum(O_PreRef_Consented_NonDR + O_PostRef_Consented_NonDR) AS  O_Consent_NonDR,

			Sum(T_PreRef_Approached_DR + T_PostRef_Approached_DR + T_PreRef_Approached_NonDR + T_PostRef_Approached_NonDR) AS T_TotalApproached,
			Sum(T_PreRef_Approached_DR + T_PostRef_Approached_DR) AS T_Approach_DR, 
			Sum(T_PreRef_Approached_NonDR + T_PostRef_Approached_NonDR) AS  T_Approach_NonDR, 
			Sum(T_PreRef_Consented_DR + T_PostRef_Consented_DR + T_PreRef_Consented_NonDR + T_PostRef_Consented_NonDR) AS T_TotalConsented,
			Sum(T_PreRef_Consented_DR + T_PostRef_Consented_DR) AS T_Consent_DR, 
			Sum(T_PreRef_Consented_NonDR + T_PostRef_Consented_NonDR) AS  T_Consent_NonDR,

			Sum(E_PreRef_Approached_DR + E_PostRef_Approached_DR + E_PreRef_Approached_NonDR + E_PostRef_Approached_NonDR) AS E_TotalApproached,
			Sum(E_PreRef_Approached_DR + E_PostRef_Approached_DR) AS E_Approach_DR, 
			Sum(E_PreRef_Approached_NonDR + E_PostRef_Approached_NonDR) AS  E_Approach_NonDR, 
			Sum(E_PreRef_Consented_DR + E_PostRef_Consented_DR + E_PreRef_Consented_NonDR + E_PostRef_Consented_NonDR) AS E_TotalConsented,
			Sum(E_PreRef_Consented_DR + E_PostRef_Consented_DR) AS E_Consent_DR, 
			Sum(E_PreRef_Consented_NonDR + E_PostRef_Consented_NonDR) AS  E_Consent_NonDR,

			--drh 2/18/02
			Sum(O_Registry_Approached) AS O_Registry_Approached,
			Sum(O_Registry_Consented) AS O_Registry_Consented,
			Sum(T_Registry_Approached) AS T_Registry_Approached,
			Sum(T_Registry_Consented) AS T_Registry_Consented,
			Sum(E_Registry_Approached) AS E_Registry_Approached,
			Sum(E_Registry_Consented) AS E_Registry_Consented,
			Sum(A_Registry_Approached) AS A_Registry_Approached,
			Sum(A_Registry_Consented) AS A_Registry_Consented,

			Sum(RegConversionOrgan) AS O_Registry_Recovered,
			Sum(RegConversionAllTissue) AS T_Registry_Recovered,
			Sum(RegConversionEyes) AS E_Registry_Recovered,
			Sum(RegConversionAllTypes) AS A_Registry_Recovered
			
			

    	FROM 		Referral_TypeCount
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
	AND		Referral_ApproachCount.YearID = Referral_TypeCount.YearID
	AND		Referral_ApproachCount.MonthID = Referral_TypeCount.MonthID
	AND		Referral_ApproachCount.SourceCodeID = Referral_TypeCount.SourceCodeID

	--drh 2/19/02
	LEFT JOIN	Referral_ConversionReasonCount ON Referral_ConversionReasonCount.OrganizationID = Referral_TypeCount.OrganizationID 
	AND		Referral_ConversionReasonCount.YearID = Referral_TypeCount.YearID
	AND		Referral_ConversionReasonCount.MonthID = Referral_TypeCount.MonthID
	AND		Referral_ConversionReasonCount.SourceCodeID = Referral_TypeCount.SourceCodeID

	/*bjk 2/27/2002 removed and replaced with above join
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID
	--drh 2/19/02
	LEFT JOIN	Referral_ConversionReasonCount ON Referral_ConversionReasonCount.OrganizationID = Referral_TypeCount.OrganizationID 
	*/
    	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID =  Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	/* bjk 2/27/2002 removed to fix number counts
	AND		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	*/
	GROUP BY	Referral_TypeCount.OrganizationID, OrganizationName
    	ORDER BY 	OrganizationName

IF	@vOrgID > 0

    	SELECT 	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, CAST(Referral_TypeCount.YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			Referral_TypeCount.OrganizationID, OrganizationName, 
			Sum(Referral_TypeCount.AllTypes) AS AllTypes,
			Sum(A_PreRef_Approached_DR + A_PostRef_Approached_DR + A_PreRef_Approached_NonDR + A_PostRef_Approached_NonDR) AS A_TotalApproached,
			Sum(A_PreRef_Approached_DR + A_PostRef_Approached_DR) AS A_Approach_DR, 
			Sum(A_PreRef_Approached_NonDR + A_PostRef_Approached_NonDR) AS A_Approach_NonDR, 
			Sum(A_PreRef_Consented_DR + A_PostRef_Consented_DR + A_PreRef_Consented_NonDR + A_PostRef_Consented_NonDR) AS A_TotalConsented,
			Sum(A_PreRef_Consented_DR + A_PostRef_Consented_DR) AS A_Consent_DR, 
			Sum(A_PreRef_Consented_NonDR + A_PostRef_Consented_NonDR) AS  A_Consent_NonDR,

			Sum(O_PreRef_Approached_DR + O_PostRef_Approached_DR + O_PreRef_Approached_NonDR + O_PostRef_Approached_NonDR) AS O_TotalApproached,
			Sum(O_PreRef_Approached_DR + O_PostRef_Approached_DR) AS O_Approach_DR, 
			Sum(O_PreRef_Approached_NonDR + O_PostRef_Approached_NonDR) AS  O_Approach_NonDR, 
			Sum(O_PreRef_Consented_DR + O_PostRef_Consented_DR + O_PreRef_Consented_NonDR + O_PostRef_Consented_NonDR) AS O_TotalConsented,
			Sum(O_PreRef_Consented_DR + O_PostRef_Consented_DR) AS O_Consent_DR, 
			Sum(O_PreRef_Consented_NonDR + O_PostRef_Consented_NonDR) AS  O_Consent_NonDR,

			Sum(T_PreRef_Approached_DR + T_PostRef_Approached_DR + T_PreRef_Approached_NonDR + T_PostRef_Approached_NonDR) AS T_TotalApproached,
			Sum(T_PreRef_Approached_DR + T_PostRef_Approached_DR) AS T_Approach_DR, 
			Sum(T_PreRef_Approached_NonDR + T_PostRef_Approached_NonDR) AS  T_Approach_NonDR, 
			Sum(T_PreRef_Consented_DR + T_PostRef_Consented_DR + T_PreRef_Consented_NonDR + T_PostRef_Consented_NonDR) AS T_TotalConsented,
			Sum(T_PreRef_Consented_DR + T_PostRef_Consented_DR) AS T_Consent_DR, 
			Sum(T_PreRef_Consented_NonDR + T_PostRef_Consented_NonDR) AS  T_Consent_NonDR,

			Sum(E_PreRef_Approached_DR + E_PostRef_Approached_DR + E_PreRef_Approached_NonDR + E_PostRef_Approached_NonDR) AS E_TotalApproached,
			Sum(E_PreRef_Approached_DR + E_PostRef_Approached_DR) AS E_Approach_DR, 
			Sum(E_PreRef_Approached_NonDR + E_PostRef_Approached_NonDR) AS  E_Approach_NonDR, 
			Sum(E_PreRef_Consented_DR + E_PostRef_Consented_DR + E_PreRef_Consented_NonDR + E_PostRef_Consented_NonDR) AS E_TotalConsented,
			Sum(E_PreRef_Consented_DR + E_PostRef_Consented_DR) AS E_Consent_DR, 
			Sum(E_PreRef_Consented_NonDR + E_PostRef_Consented_NonDR) AS  E_Consent_NonDR,

			--drh 2/18/02
			Sum(O_Registry_Approached) AS O_Registry_Approached,
			Sum(O_Registry_Consented) AS O_Registry_Consented,
			Sum(T_Registry_Approached) AS T_Registry_Approached,
			Sum(T_Registry_Consented) AS T_Registry_Consented,
			Sum(E_Registry_Approached) AS E_Registry_Approached,
			Sum(E_Registry_Consented) AS E_Registry_Consented,
			Sum(A_Registry_Approached) AS A_Registry_Approached,
			Sum(A_Registry_Consented) AS A_Registry_Consented,

			Sum(RegConversionOrgan) AS O_Registry_Recovered,
			Sum(RegConversionAllTissue) AS T_Registry_Recovered,
			Sum(RegConversionEyes) AS E_Registry_Recovered,
			Sum(RegConversionAllTypes) AS A_Registry_Recovered

    	FROM 		Referral_TypeCount
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
	AND		Referral_ApproachCount.YearID = Referral_TypeCount.YearID
	AND		Referral_ApproachCount.MonthID = Referral_TypeCount.MonthID
	AND		Referral_ApproachCount.SourceCodeID = Referral_TypeCount.SourceCodeID

	--drh 2/19/02
	LEFT JOIN	Referral_ConversionReasonCount ON Referral_ConversionReasonCount.OrganizationID = Referral_TypeCount.OrganizationID 
	AND		Referral_ConversionReasonCount.YearID = Referral_TypeCount.YearID
	AND		Referral_ConversionReasonCount.MonthID = Referral_TypeCount.MonthID
	AND		Referral_ConversionReasonCount.SourceCodeID = Referral_TypeCount.SourceCodeID


	/*
	bjk 2/27/2002 removed and replaced with above join
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
	--drh 2/19/02
	LEFT JOIN	Referral_ConversionReasonCount ON Referral_ConversionReasonCount.OrganizationID = Referral_TypeCount.OrganizationID 
	*/
    	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID =  Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_TypeCount.MonthID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	/* bjk 2/27/2002 removed to fix number counts
	AND		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	*/
	AND		Referral_TypeCount.OrganizationID = @vOrgID

	GROUP BY	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, CAST(Referral_TypeCount.YearID AS varchar(4)) + ' ' + RTrim(MonthName), Referral_TypeCount.OrganizationID, OrganizationName
    	ORDER BY 	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, OrganizationName
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

