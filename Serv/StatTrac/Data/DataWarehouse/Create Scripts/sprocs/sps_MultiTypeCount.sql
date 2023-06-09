SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_MultiTypeCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_MultiTypeCount]
GO




CREATE PROCEDURE sps_MultiTypeCount

	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int 		= 0,
	@vOrgID			int		= 0

AS

IF	@vOrgID = 0

    	SELECT 		MonthID,
			YearID, 
			SUM(Total) AS 'Total Referrals',
			SUM(OTE) AS 'OTE',
			SUM(OT) AS 'OT',
			SUM(OE) AS 'OE',
			SUM(O) AS 'O',
			SUM(Tissue) AS 'Tissue',
			SUM(TE) AS 'TE',
			SUM(Eye) AS 'Eye',
			SUM(AgeRO) AS 'AgeRO',
			SUM(MedRO) AS 'MedRO',
			SUM(RO) AS 'RO'
    	FROM 		Referral_MultiTypeCount
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_MultiTypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_MultiTypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MultiTypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MultiTypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MultiTypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND 		SourceCodeID = @vSourceCodeID
	Group By	YearID, MonthID
	Order By	YearID, MonthID

IF	@vOrgID > 0

    	SELECT 		Referral_MultiTypeCount.MonthID,
			Referral_MultiTypeCount.YearID, 
			SUM(Total) AS 'Total Referrals',
			SUM(OTE) AS 'OTE',
			SUM(OT) AS 'OT',
			SUM(OE) AS 'OE',
			SUM(O) AS 'O',
			SUM(Tissue) AS 'Tissue',
			SUM(TE) AS 'TE',
			SUM(Eye) AS 'Eye',
			SUM(AgeRO) AS 'AgeRO',
			SUM(MedRO) AS 'MedRO',
			SUM(RO) AS 'RO'
    	FROM 		Referral_MultiTypeCount
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_MultiTypeCount.OrganizationID 
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_MultiTypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_MultiTypeCount.MonthID
	JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_MultiTypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MultiTypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_MultiTypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_MultiTypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_MultiTypeCount.OrganizationID = @vOrgID
	AND 		_ReferralProdReport.dbo.SourceCode.SourceCodeID = @vSourceCodeID
	Group By	Referral_MultiTypeCount.YearID, Referral_MultiTypeCount.MonthID
	Order By	Referral_MultiTypeCount.YearID, Referral_MultiTypeCount.MonthID














GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

