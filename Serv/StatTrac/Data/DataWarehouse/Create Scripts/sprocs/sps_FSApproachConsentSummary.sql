SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSApproachConsentSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSApproachConsentSummary]
GO


CREATE PROCEDURE sps_FSApproachConsentSummary

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0,
	@ApproachOrganizationID int 	= null

AS

IF	@vOrgID = 0
BEGIN


	SELECT 	Referral_ApproachPersonReasonCount.OrganizationID AS 'ReferralOrganiztionID',
		_ReferralProdReport.dbo.Person.OrganizationID AS 'ApproachOrganiztionID',
		_ReferralProdReport.dbo.Organization.OrganizationName AS 'ReferralOrganizationName',
		PersonOrganization.OrganizationName AS 'ApproachOrganizationName',
		SUM(SecondaryScreening) AS 'SecondaryScreening',
		SUM(ApproachOrgan) AS 'ApproachOrgan',
		SUM(ApproachEyes) AS 'ApproachEyes',
		SUM(ApproachAllTissue) AS 'ApproachAllTissue',
		SUM(ConsentOrgan) AS 'ConsentOrgan',
		SUM(ConsentEyes) AS 'ConsentEyes',
		SUM(ConsentAllTissue) AS 'ConsentAllTissue',
		SUM(ApproachOrganFamilyUnavailable) AS 'ApproachOrganFamilyUnavailable',
		SUM(ApproachEyesFamilyUnavailable) AS 'ApproachEyesFamilyUnavailable',
		SUM(ApproachAllTissueFamilyUnavailable) AS 'ApproachAllTissueFamilyUnavailable'

	FROM 	Referral_ApproachPersonReasonCount
	JOIN 	Referral_ApproachPersonConsentCount ON Referral_ApproachPersonConsentCount.YearID = Referral_ApproachPersonReasonCount.YearID 
		AND Referral_ApproachPersonConsentCount.MonthID  = Referral_ApproachPersonReasonCount.MonthID 
		AND Referral_ApproachPersonConsentCount.OrganizationID  = Referral_ApproachPersonReasonCount.OrganizationID
		AND Referral_ApproachPersonConsentCount.ApproachPersonID  = Referral_ApproachPersonReasonCount.ApproachPersonID
	LEFT 	JOIN _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = Referral_ApproachPersonReasonCount.ApproachPersonID
	JOIN 	_ReferralProdReport.dbo.Organization PersonOrganization ON PersonOrganization.OrganizationID = _ReferralProdReport.dbo.Person.OrganizationID
	JOIN 	_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonReasonCount.OrganizationID
	JOIN 	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE	 --_ReferralProdReport.dbo.Person.OrganizationID = ISNULL(@ApproachOrganizationID,_ReferralProdReport.dbo.Person.OrganizationID)	AND  	
	WebReportGroupID = @vReportGroupID	
	AND	CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND	CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	GROUP BY	Referral_ApproachPersonReasonCount.OrganizationID, 
			_ReferralProdReport.dbo.Organization.OrganizationName, 	
			_ReferralProdReport.dbo.Person.OrganizationID, 
			PersonOrganization.OrganizationName
END
ELSE
BEGIN
	SELECT 	Referral_ApproachPersonReasonCount.OrganizationID,
		_ReferralProdReport.dbo.Person.OrganizationID,
		PersonOrganization.OrganizationName,
		_ReferralProdReport.dbo.Organization.OrganizationName,
		SUM(SecondaryScreening) AS 'SecondaryScreening',
		SUM(ApproachOrgan) AS 'ApproachOrgan',
		SUM(ApproachEyes) AS 'ApproachEyes',
		SUM(ApproachAllTissue) AS 'ApproachAllTissue',
		SUM(ConsentOrgan) AS 'ConsentOrgan',
		SUM(ConsentEyes) AS 'ConsentEyes',
		SUM(ConsentAllTissue) AS 'ConsentAllTissue',
		SUM(ApproachOrganFamilyUnavailable) AS 'ApproachOrganFamilyUnavailable',
		SUM(ApproachEyesFamilyUnavailable) AS 'ApproachEyesFamilyUnavailable',
		SUM(ApproachAllTissueFamilyUnavailable) AS 'ApproachAllTissueFamilyUnavailable'

	FROM 	Referral_ApproachPersonReasonCount
	JOIN 	Referral_ApproachPersonConsentCount ON Referral_ApproachPersonConsentCount.YearID = Referral_ApproachPersonReasonCount.YearID 
		AND Referral_ApproachPersonConsentCount.MonthID  = Referral_ApproachPersonReasonCount.MonthID 
		AND Referral_ApproachPersonConsentCount.OrganizationID  = Referral_ApproachPersonReasonCount.OrganizationID
		AND Referral_ApproachPersonConsentCount.ApproachPersonID  = Referral_ApproachPersonReasonCount.ApproachPersonID
	LEFT 	JOIN _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = Referral_ApproachPersonReasonCount.ApproachPersonID
	JOIN 	_ReferralProdReport.dbo.Organization PersonOrganization ON PersonOrganization.OrganizationID = _ReferralProdReport.dbo.Person.OrganizationID
	JOIN 	_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonReasonCount.OrganizationID
	JOIN 	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE	 --_ReferralProdReport.dbo.Person.OrganizationID = @ApproachOrganizationID	AND  	
	WebReportGroupID = @vReportGroupID	
	AND	CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND	CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND	Referral_ApproachPersonReasonCount.OrganizationID = @vOrgID
	GROUP BY	Referral_ApproachPersonReasonCount.OrganizationID, 
			_ReferralProdReport.dbo.Organization.OrganizationName, 	
			_ReferralProdReport.dbo.Person.OrganizationID, 
			PersonOrganization.OrganizationName

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

