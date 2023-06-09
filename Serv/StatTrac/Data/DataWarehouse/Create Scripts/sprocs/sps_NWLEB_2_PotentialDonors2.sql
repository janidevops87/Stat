SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_NWLEB_2_PotentialDonors2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_NWLEB_2_PotentialDonors2]
GO


CREATE PROCEDURE sps_NWLEB_2_PotentialDonors2

	@vReportGroupID	int	= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int	= 0,
      	@vBreakOnOrg 		int	= 0,
	@vOrgType	varchar(1)	= null

AS

/********************************************************************************************************************************************************
***** Date: 1/16/04                                                          
***** mds: This stored procedure was created by copying the sps_ApproachReasonSummary_A stored proc and eliminating  
***** non-eye information to create a report very similar to Reason Summary.
********************************************************************************************************************************************************/

IF	@vOrgID = 0
	BEGIN
	      IF @vBreakOnOrg <> 0 -- Individually break down totals by org
    		SELECT 		
			Sum(ApproachEyes) AS ApproachEyes,
			Sum(ApproachEyesNotApproached) AS ApproachEyesNotApproached,
			Sum(ApproachEyesUnknown) AS ApproachEyesUnknown,
			Sum(ApproachEyesFamilyUnavailable) AS ApproachEyesFamilyUnavail,
			Sum(ApproachEyesCoronerRuleout) AS ApproachEyesCoronerRuleout,
			Sum(ApproachEyesArrest) AS ApproachEyesArrest,
			Sum(ApproachEyesMedRO) AS ApproachEyesMedRO,
			Sum(ApproachEyesTimeLogistics) AS ApproachEyesTimeLogistics,
			Sum(ApproachEyesNeverBrainDead) AS ApproachEyesNeverBrainDead,
			Sum(ApproachEyesHighRisk) AS ApproachEyesHighRisk,
			Sum(ApproachEyesUnapproachable) AS ApproachEyesUnapproachable,
			Sum(AppropriateRO) AS AppropriateRO,
			Sum(ApproachEyesSecondaryRO) AS ApproachEyesSecondaryRO,
			Sum(ApproachTissue) AS ApproachTissue,
			Sum(ApproachTissueNotApproached) AS ApproachTissueNotApproached,
			Sum(ApproachTissueUnknown) AS ApproachTissueUnknown,
			Sum(ApproachTissueFamilyUnavailable) AS ApproachTissueFamilyUnavail,
			Sum(ApproachTissueCoronerRuleout) AS ApproachTissueCoronerRuleout,
			Sum(ApproachTissueArrest) AS ApproachTissueArrest,
			Sum(ApproachTissueMedRO) AS ApproachTissueMedRO,
			Sum(ApproachTissueTimeLogistics) AS ApproachTissueTimeLogistics,
			Sum(ApproachTissueNeverBrainDead) AS ApproachTissueNeverBrainDead,
			Sum(ApproachTissueHighRisk) AS ApproachTissueHighRisk,
			Sum(ApproachTissueUnapproachable) AS ApproachTissueUnapproachable,
			Sum(ApproachTissueSecondaryRO) AS ApproachTissueSecondaryRO,
			Sum(ApproachOrgan) AS ApproachOrgan,
			Sum(ApproachOrganNotApproached) AS ApproachOrganNotApproached,
			Sum(ApproachOrganUnknown) AS ApproachOrganUnknown,
			Sum(ApproachOrganFamilyUnavailable) AS ApproachOrganFamilyUnavail,
			Sum(ApproachOrganCoronerRuleout) AS ApproachOrganCoronerRuleout,
			Sum(ApproachOrganArrest) AS ApproachOrganArrest,
			Sum(ApproachOrganMedRO) AS ApproachOrganMedRO,
			Sum(ApproachOrganTimeLogistics) AS ApproachOrganTimeLogistics,
			Sum(ApproachOrganNeverBrainDead) AS ApproachOrganNeverBrainDead,
			Sum(ApproachOrganHighRisk) AS ApproachOrganHighRisk,
			Sum(ApproachOrganUnapproachable) AS ApproachOrganUnapproachable,
			Sum(ApproachOrganSecondaryRO) AS ApproachOrganSecondaryRO,
			 _ReferralProdReport.dbo.Organization.OrganizationID,
			 _ReferralProdReport.dbo.Organization.OrganizationName,
			_ReferralProdReport.dbo.fn_IncompleteReferralCount(@vReportGroupID, @vStartDate, @vEndDate,  _ReferralProdReport.dbo.Organization.OrganizationID, @vOrgType) AS PendingCount

    		FROM Referral_ApproachReasonCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachReasonCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    			JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachReasonCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
		GROUP BY _ReferralProdReport.dbo.Organization.OrganizationID, _ReferralProdReport.dbo.Organization.OrganizationName
		ORDER BY _ReferralProdReport.dbo.Organization.OrganizationName


      	      ELSE IF @vBreakOnOrg = 0 -- Get total for all orgs, not broken down individually
    		SELECT 		
			Sum(ApproachEyes) AS ApproachEyes,
			Sum(ApproachEyesNotApproached) AS ApproachEyesNotApproached,
			Sum(ApproachEyesUnknown) AS ApproachEyesUnknown,
			Sum(ApproachEyesFamilyUnavailable) AS ApproachEyesFamilyUnavail,
			Sum(ApproachEyesCoronerRuleout) AS ApproachEyesCoronerRuleout,
			Sum(ApproachEyesArrest) AS ApproachEyesArrest,
			Sum(ApproachEyesMedRO) AS ApproachEyesMedRO,
			Sum(ApproachEyesTimeLogistics) AS ApproachEyesTimeLogistics,
			Sum(ApproachEyesNeverBrainDead) AS ApproachEyesNeverBrainDead,
			Sum(ApproachEyesHighRisk) AS ApproachEyesHighRisk,
			Sum(ApproachEyesUnapproachable) AS ApproachEyesUnapproachable,
			Sum(AppropriateRO) AS AppropriateRO,
			Sum(ApproachEyesSecondaryRO) AS ApproachEyesSecondaryRO,
			Sum(ApproachTissue) AS ApproachTissue,
			Sum(ApproachTissueNotApproached) AS ApproachTissueNotApproached,
			Sum(ApproachTissueUnknown) AS ApproachTissueUnknown,
			Sum(ApproachTissueFamilyUnavailable) AS ApproachTissueFamilyUnavail,
			Sum(ApproachTissueCoronerRuleout) AS ApproachTissueCoronerRuleout,
			Sum(ApproachTissueArrest) AS ApproachTissueArrest,
			Sum(ApproachTissueMedRO) AS ApproachTissueMedRO,
			Sum(ApproachTissueTimeLogistics) AS ApproachTissueTimeLogistics,
			Sum(ApproachTissueNeverBrainDead) AS ApproachTissueNeverBrainDead,
			Sum(ApproachTissueHighRisk) AS ApproachTissueHighRisk,
			Sum(ApproachTissueUnapproachable) AS ApproachTissueUnapproachable,
			Sum(ApproachTissueSecondaryRO) AS ApproachTissueSecondaryRO,
			Sum(ApproachOrgan) AS ApproachOrgan,
			Sum(ApproachOrganNotApproached) AS ApproachOrganNotApproached,
			Sum(ApproachOrganUnknown) AS ApproachOrganUnknown,
			Sum(ApproachOrganFamilyUnavailable) AS ApproachOrganFamilyUnavail,
			Sum(ApproachOrganCoronerRuleout) AS ApproachOrganCoronerRuleout,
			Sum(ApproachOrganArrest) AS ApproachOrganArrest,
			Sum(ApproachOrganMedRO) AS ApproachOrganMedRO,
			Sum(ApproachOrganTimeLogistics) AS ApproachOrganTimeLogistics,
			Sum(ApproachOrganNeverBrainDead) AS ApproachOrganNeverBrainDead,
			Sum(ApproachOrganHighRisk) AS ApproachOrganHighRisk,
			Sum(ApproachOrganUnapproachable) AS ApproachOrganUnapproachable,
			Sum(ApproachOrganSecondaryRO) AS ApproachOrganSecondaryRO,
			_ReferralProdReport.dbo.fn_IncompleteReferralCount(@vReportGroupID, @vStartDate, @vEndDate,  0, @vOrgType) AS PendingCount

    		FROM Referral_ApproachReasonCount
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachReasonCount.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    			JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachReasonCount.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
		WHERE _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND _ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	END

IF	@vOrgID > 0

    	SELECT 	
			Sum(ApproachEyes) AS ApproachEyes,
			Sum(ApproachEyesNotApproached) AS ApproachEyesNotApproached,
			Sum(ApproachEyesUnknown) AS ApproachEyesUnknown,
			Sum(ApproachEyesFamilyUnavailable) AS ApproachEyesFamilyUnavail,
			Sum(ApproachEyesCoronerRuleout) AS ApproachEyesCoronerRuleout,
			Sum(ApproachEyesArrest) AS ApproachEyesArrest,
			Sum(ApproachEyesMedRO) AS ApproachEyesMedRO,
			Sum(ApproachEyesTimeLogistics) AS ApproachEyesTimeLogistics,
			Sum(ApproachEyesNeverBrainDead) AS ApproachEyesNeverBrainDead,
			Sum(ApproachEyesHighRisk) AS ApproachEyesHighRisk,
			Sum(ApproachEyesUnapproachable) AS ApproachEyesUnapproachable,
			Sum(AppropriateRO) AS AppropriateRO,
			Sum(ApproachEyesSecondaryRO) AS ApproachEyesSecondaryRO,
			Sum(ApproachTissue) AS ApproachTissue,
			Sum(ApproachTissueNotApproached) AS ApproachTissueNotApproached,
			Sum(ApproachTissueUnknown) AS ApproachTissueUnknown,
			Sum(ApproachTissueFamilyUnavailable) AS ApproachTissueFamilyUnavail,
			Sum(ApproachTissueCoronerRuleout) AS ApproachTissueCoronerRuleout,
			Sum(ApproachTissueArrest) AS ApproachTissueArrest,
			Sum(ApproachTissueMedRO) AS ApproachTissueMedRO,
			Sum(ApproachTissueTimeLogistics) AS ApproachTissueTimeLogistics,
			Sum(ApproachTissueNeverBrainDead) AS ApproachTissueNeverBrainDead,
			Sum(ApproachTissueHighRisk) AS ApproachTissueHighRisk,
			Sum(ApproachTissueUnapproachable) AS ApproachTissueUnapproachable,
			Sum(ApproachTissueSecondaryRO) AS ApproachTissueSecondaryRO,
			Sum(ApproachOrgan) AS ApproachOrgan,
			Sum(ApproachOrganNotApproached) AS ApproachOrganNotApproached,
			Sum(ApproachOrganUnknown) AS ApproachOrganUnknown,
			Sum(ApproachOrganFamilyUnavailable) AS ApproachOrganFamilyUnavail,
			Sum(ApproachOrganCoronerRuleout) AS ApproachOrganCoronerRuleout,
			Sum(ApproachOrganArrest) AS ApproachOrganArrest,
			Sum(ApproachOrganMedRO) AS ApproachOrganMedRO,
			Sum(ApproachOrganTimeLogistics) AS ApproachOrganTimeLogistics,
			Sum(ApproachOrganNeverBrainDead) AS ApproachOrganNeverBrainDead,
			Sum(ApproachOrganHighRisk) AS ApproachOrganHighRisk,
			Sum(ApproachOrganUnapproachable) AS ApproachOrganUnapproachable,
			Sum(ApproachOrganSecondaryRO) AS ApproachOrganSecondaryRO,
			_ReferralProdReport.dbo.fn_IncompleteReferralCount(@vReportGroupID, @vStartDate, @vEndDate,  @vOrgID, @vOrgType) AS PendingCount

    	FROM 		Referral_ApproachReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ApproachReasonCount.MonthID

	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ApproachReasonCount.OrganizationID = @vOrgID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

