SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPersonConsentSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachPersonConsentSummary_A]
GO







CREATE PROCEDURE sps_ApproachPersonConsentSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS


IF	@vOrgID = 0

    	SELECT 		--Referral_ApproachPersonConsentCount.OrganizationID, 
			Referral_ApproachPersonConsentCount.ApproachPersonID,
			PersonLast + ", " + PersonFirst As PersonName,
			--OrganizationName, 
			--Sum(TotalApproached) AS TotalApproached,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,
                         
			Sum(ConsentOrgan) AS ConsentOrgan, 
			Sum(ConsentAllTissue) AS ConsentAllTissue,
			Sum(ConsentEyes) AS ConsentEyes,
                        Sum(Referral_ApproachPersonCount.AppropriateRO)AS AppropriateRO

    	FROM 		Referral_ApproachPersonConsentCount
        JOIN            Referral_ApproachPersonCount ON Referral_ApproachPersonCount.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
                        AND Referral_ApproachPersonCount.MonthID = Referral_ApproachPersonConsentCount.MonthID
                        AND Referral_ApproachPersonCount.YearID = Referral_ApproachPersonConsentCount.YearID
                        AND Referral_ApproachPersonCount.ApproachPersonID = Referral_ApproachPersonConsentCount.ApproachPersonID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonConsentCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ApproachPersonConsentCount.ApproachPersonID, PersonLast + ", " + PersonFirst
    	ORDER BY 	PersonLast + ", " + PersonFirst

IF	@vOrgID > 0

    	SELECT 		--YearID, Referral_ApproachPersonConsentCount.MonthID AS MonthID, 
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
                        Referral_ApproachPersonConsentCount.ApproachPersonID, 
                        PersonLast + ", " + PersonFirst As PersonName,
			--Referral_ApproachPersonConsentCount.OrganizationID, 
                        --OrganizationName, 
                        --Sum(TotalApproached) AS TotalApproached,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,

			Sum(ConsentOrgan) AS ConsentOrgan, 
                        Sum(ConsentAllTissue) AS ConsentAllTissue,
			Sum(ConsentEyes) AS ConsentEyes,
                        Sum(Referral_ApproachPersonCount.AppropriateRO)AS AppropriateRO

    	FROM 		Referral_ApproachPersonConsentCount
        JOIN            Referral_ApproachPersonCount ON Referral_ApproachPersonCount.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
                        AND Referral_ApproachPersonCount.MonthID = Referral_ApproachPersonConsentCount.MonthID
                        AND Referral_ApproachPersonCount.YearID = Referral_ApproachPersonConsentCount.YearID
                        AND Referral_ApproachPersonCount.ApproachPersonID = Referral_ApproachPersonConsentCount.ApproachPersonID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonConsentCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
--	JOIN		Month ON Month.MonthID = Referral_ApproachPersonConsentCount.MonthID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ApproachPersonConsentCount.OrganizationID = @vOrgID

	GROUP BY	--YearID, Referral_ApproachPersonConsentCount.MonthID,
                        --CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			--Referral_ApproachPersonConsentCount.OrganizationID, OrganizationName, 
                        Referral_ApproachPersonConsentCount.ApproachPersonID, PersonLast + ", " + PersonFirst
    	ORDER BY 	--Referral_ApproachPersonConsentCount.MonthID, OrganizationName, 
                        PersonLast + ", " + PersonFirst










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

