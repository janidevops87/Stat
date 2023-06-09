SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPersonSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachPersonSummary]
GO

CREATE PROCEDURE sps_ApproachPersonSummary

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

--If org id is 0 then get referral summary for all organizations in the report group for the
--given time period.
IF	@vOrgID = 0

    BEGIN
    	SELECT 		Referral_ApproachPersonCount.OrganizationID, 
			ApproachPersonID,
			Ltrim(PersonLast) + ", " + PersonFirst As PersonName,
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

	GROUP BY	Referral_ApproachPersonCount.OrganizationID, OrganizationName, ApproachPersonID, Ltrim(PersonLast) + ", " + PersonFirst
    	ORDER BY 	OrganizationName, Ltrim(PersonLast) + ", " + PersonFirst
       
    END

--If org id is greater then 0 get referral summary for specific organization in 
--the report group.
--Redesigned to return 2 record sets(RS). 1st RS is totals per month and 2nd is totals 
--for the selected time period per person. Temp table #Sort was created to handle 
--ApproachPersonID values -1 and 0 which are both Unapproached Referrals.

IF	@vOrgID > 0
    BEGIN   

	if exists (select * from sysobjects where id = object_id('TempDB..#Sort') 
	and sysstat & 0xf = 3)
	DROP TABLE #Sort
	

	--Create sort table for per person summary for a given time period.
	CREATE TABLE #Sort
        (
          PersonLast varchar(50),
          PersonFirst varchar(50),
          ApproachPersonID int,
	  AllTypes int,
          AppropriateOrgan int,
          AppropriateAllTissue int,
	  AppropriateEyes int,
	  AppropriateRO int
         )
		
    	SELECT 		YearID, Referral_ApproachPersonCount.MonthID AS MonthID, 
			ApproachPersonID, Ltrim(PersonLast) + ", " + PersonFirst As PersonName,
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
			Referral_ApproachPersonCount.OrganizationID, OrganizationName, ApproachPersonID, Ltrim(PersonLast) + ", " + PersonFirst
    	ORDER BY 	YearID, Referral_ApproachPersonCount.MonthID, OrganizationName, Ltrim(PersonLast) + ", " + PersonFirst
	
	INSERT #Sort
	SELECT 		
			Case 
			   When PersonLast is null and ApproachPersonID <= 0 then 'ZZZUnapproached Referrals'
			   Else PersonLast 
			END AS 'PersonLast', 
			PersonFirst,
			Case 
			   When ApproachPersonID = -1 then 0
			   When ApproachPersonID = 0 then 0
			   Else ApproachPersonID 
			END AS 'ApproachPersonID',
			Sum(AllTypes) AS AllTypes,
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
	
	
	GROUP BY	PersonLast, PersonFirst, ApproachPersonID, Referral_ApproachPersonCount.OrganizationID
    	ORDER BY 	PersonLast, PersonFirst


	SELECT 		Ltrim(PersonLast), 
			PersonFirst, 
			ApproachPersonID,
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO from #Sort
	GROUP BY 	ApproachPersonID, Ltrim(PersonLast), PersonFirst
	ORDER BY 	Ltrim(PersonLast), PersonFirst

	--Drop temp sort table 
	DROP TABLE #Sort

   END
   

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

