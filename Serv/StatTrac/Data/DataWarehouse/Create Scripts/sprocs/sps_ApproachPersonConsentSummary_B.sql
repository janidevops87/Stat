SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachPersonConsentSummary_B]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachPersonConsentSummary_B]
GO




CREATE PROCEDURE sps_ApproachPersonConsentSummary_B

	@vReportGroupID	int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0,
	@vBreakOnOrgID	int		= 0

AS


IF	@vOrgID = 0  AND @vBreakOnOrgID = 0

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
			Sum(Referral_ApproachPersonCount.AppropriateRO)AS AppropriateRO,
			0 as 'OrganizationID'
			--Referral_ApproachPersonCount.OrganizationID

    	FROM 		Referral_ApproachPersonConsentCount
        JOIN            Referral_ApproachPersonCount ON Referral_ApproachPersonCount.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
		AND Referral_ApproachPersonCount.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
                        AND Referral_ApproachPersonCount.MonthID = Referral_ApproachPersonConsentCount.MonthID
                        AND Referral_ApproachPersonCount.YearID = Referral_ApproachPersonConsentCount.YearID
                        AND Referral_ApproachPersonCount.ApproachPersonID = Referral_ApproachPersonConsentCount.ApproachPersonID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonConsentCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
	
	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ApproachPersonConsentCount.ApproachPersonID, PersonLast + ", " + PersonFirst--, Referral_ApproachPersonCount.OrganizationID
	ORDER BY 	PersonLast + ", " + PersonFirst

IF	@vOrgID > 0  AND @vBreakOnOrgID = 0

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
			Sum(Referral_ApproachPersonCount.AppropriateRO)AS AppropriateRO,
			Referral_ApproachPersonCount.OrganizationID
    	FROM 		Referral_ApproachPersonConsentCount
        JOIN            Referral_ApproachPersonCount ON Referral_ApproachPersonCount.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
		AND Referral_ApproachPersonCount.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
                        AND Referral_ApproachPersonCount.MonthID = Referral_ApproachPersonConsentCount.MonthID
                        AND Referral_ApproachPersonCount.YearID = Referral_ApproachPersonConsentCount.YearID
                        AND Referral_ApproachPersonCount.ApproachPersonID = Referral_ApproachPersonConsentCount.ApproachPersonID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
	LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonConsentCount.ApproachPersonID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
--	JOIN		Month ON Month.MonthID = Referral_ApproachPersonConsentCount.MonthID

   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ApproachPersonConsentCount.OrganizationID = @vOrgID

	GROUP BY	--YearID, Referral_ApproachPersonConsentCount.MonthID,
                        --CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			--Referral_ApproachPersonConsentCount.OrganizationID, OrganizationName, 
                        Referral_ApproachPersonConsentCount.ApproachPersonID, PersonLast + ", " + PersonFirst, Referral_ApproachPersonCount.OrganizationID
    	ORDER BY 	--Referral_ApproachPersonConsentCount.MonthID, OrganizationName, 
                        PersonLast + ", " + PersonFirst


--DEO 5/22/2003
IF	@vBreakOnOrgID = 1
BEGIN
	--Create the temp table
	CREATE TABLE #_Temp_ApproachPersonConsentSummary
	(
	[ApproachPersonID] [int] NOT NULL ,
	[PersonName] [varchar] (500),
	[OrganizationID] [int] NOT NULL ,
	[OrganizationName] [varchar] (80) NOT NULL,
	[AppropriateOrgan] [int] NULL DEFAULT (0),
	[AppropriateAllTissue] [int] NULL DEFAULT (0),
	[AppropriateEyes] [int] NULL DEFAULT (0),
	[ConsentOrgan] [int] NULL DEFAULT (0),
	[ConsentAllTissue] [int] NULL DEFAULT (0),
	[ConsentEyes] [int] NULL DEFAULT (0),
	[AppropriateRO] [int] NULL DEFAULT (0)
	)

	--Clean temp tables
	DELETE #_Temp_ApproachPersonConsentSummary

-- START to Loop through Distinct Organizations
	DECLARE Organization_cursor CURSOR FOR 
	SELECT 	_ReferralProdReport.dbo.Organization.OrganizationID
	FROM 		_ReferralProdReport.dbo.Organization
	LEFT JOIN	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	WHERE 	WebReportGroupID = @vReportGroupID	
	ORDER BY 	OrganizationName

	OPEN Organization_cursor
	FETCH NEXT FROM Organization_cursor INTO @vOrgID
	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO #_Temp_ApproachPersonConsentSummary
    			SELECT Referral_ApproachPersonConsentCount.ApproachPersonID, 
				PersonLast + ", " + PersonFirst As PersonName,
				Referral_ApproachPersonConsentCount.OrganizationID, 
                        			OrganizationName, 
				Sum(AppropriateOrgan) AS AppropriateOrgan, 
				Sum(AppropriateAllTissue) AS AppropriateAllTissue,
				Sum(AppropriateEyes) AS AppropriateEyes,
				Sum(ConsentOrgan) AS ConsentOrgan, 
                        			Sum(ConsentAllTissue) AS ConsentAllTissue,
				Sum(ConsentEyes) AS ConsentEyes,
                        			Sum(Referral_ApproachPersonCount.AppropriateRO)AS AppropriateRO
		    	FROM		Referral_ApproachPersonConsentCount
		        	JOIN            	Referral_ApproachPersonCount ON Referral_ApproachPersonCount.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
			AND Referral_ApproachPersonCount.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
		             	AND 		Referral_ApproachPersonCount.MonthID = Referral_ApproachPersonConsentCount.MonthID
		             	AND 		Referral_ApproachPersonCount.YearID = Referral_ApproachPersonConsentCount.YearID
		             	AND 		Referral_ApproachPersonCount.ApproachPersonID = Referral_ApproachPersonConsentCount.ApproachPersonID
		    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachPersonConsentCount.OrganizationID
			JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachPersonConsentCount.SourceCodeID
			LEFT JOIN	_ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID =  Referral_ApproachPersonConsentCount.ApproachPersonID
			JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
			JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
		   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
			AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
			AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
			AND		CAST(  CAST(Referral_ApproachPersonConsentCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_ApproachPersonConsentCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
			AND		Referral_ApproachPersonConsentCount.OrganizationID = @vOrgID

			GROUP BY	Referral_ApproachPersonConsentCount.ApproachPersonID, PersonLast + ", " + PersonFirst, Referral_ApproachPersonConsentCount.OrganizationID, OrganizationName
		    	ORDER BY 	PersonLast + ", " + PersonFirst

	FETCH NEXT FROM Organization_cursor INTO @vOrgID
	END
	CLOSE Organization_cursor
	DEALLOCATE Organization_cursor
-- END Loop through Distinct Organizations

	--Select the final list
    	SELECT 	ApproachPersonID, 
			PersonName,
			OrganizationID, 
			OrganizationName, 
			AppropriateOrgan, 
			AppropriateAllTissue,
			AppropriateEyes,
			ConsentOrgan, 
			ConsentAllTissue,
			ConsentEyes,
			AppropriateRO
	FROM 		#_Temp_ApproachPersonConsentSummary
	ORDER BY	OrganizationName

	DROP TABLE #_Temp_ApproachPersonConsentSummary
END

 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

