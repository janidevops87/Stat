if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSConversionRateMatrix]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSConversionRateMatrix]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_FSConversionRateMatrix

	@StartDateTime		DATETIME	= NULL ,
	@EndDateTime		DATETIME  	= NULL ,
	@EmployeeID			INT			= NULL ,
	@SourceCodeID		INT			= NULL ,
	@PersonOrgID		INT			= NULL ,
	@ReportGroupOrgID	INT			= NULL 
AS

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Total Referrals Count', 
		SUM( TotalAppropriateCount ) AS 'Appropriate Count', 
		SUM( TotalFamilyApproachCount ) AS 'Approach Count ', 
		SUM( TotalWrittenConsentCount ) AS 'Written Consent Count', 
		SUM( TotalRecoveredCount ) AS 'Recovered Count' , 
		'Total' AS Type

		
	FROM 	Referral_FSConversionRateCount rfcr
	JOIN	
		_ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfcr.StatEmployeeID
	LEFT 
	JOIN
		 _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID 
	LEFT 
	JOIN
		_ReferralProdReport.dbo.Organization po ON po.OrganizationID = p.OrganizationID
	 
	JOIN 	
		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfcr.SourceCodeID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupSourceCode wrpsc ON wrpsc.SourceCodeID = sc.SourceCodeID

   	JOIN 	
		_ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = rfcr.OrganizationID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = ro.OrganizationID

	WHERE	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @StartDateTime
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @EndDateTime

	AND   rfcr.StatemployeeID = ISNULL(@EmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@SourceCodeID , rfcr.SourceCodeID)
	AND 	
		p.OrganizationID = ISNULL(@PersonOrgID, po.OrganizationID)
	
AND			wrpsc.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	AND		
		wrgo.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	GROUP BY	
		po.OrganizationName,
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName,
		YearID , 
		MonthID 
		-- DayID , 
		--HourID  
UNION ALL

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Referrals Count', 
		SUM(BoneAppropriateCount ) AS 'AppropriateCount' , 
		SUM(BoneFamilyApproachCount ) AS 'Family Approach Count' , 
		SUM(BoneWrittenConsentCount ) AS 'Written Consent Count' , 
		SUM(BoneRecoveredCount ) AS 'Recovered Count' , 
		'Bone' AS Type
	FROM 	Referral_FSConversionRateCount rfcr
	JOIN	
		_ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfcr.StatEmployeeID
	LEFT 
	JOIN
		 _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID 
	LEFT 
	JOIN
		_ReferralProdReport.dbo.Organization po ON po.OrganizationID = p.OrganizationID
	 
	JOIN 	
		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfcr.SourceCodeID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupSourceCode wrpsc ON wrpsc.SourceCodeID = sc.SourceCodeID

   	JOIN 	
		_ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = rfcr.OrganizationID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = ro.OrganizationID

	WHERE	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @StartDateTime
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @EndDateTime

	AND   rfcr.StatemployeeID = ISNULL(@EmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@SourceCodeID , rfcr.SourceCodeID)
	AND 	
		p.OrganizationID = ISNULL(@PersonOrgID, po.OrganizationID)
	
AND			wrpsc.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	AND		
		wrgo.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	GROUP BY	
		po.OrganizationName,
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName,
		YearID , 
		MonthID 
		-- DayID , 
		--HourID  
UNION ALL

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Total Referrals Count', 
		
		SUM(SkinAppropriateCount ) AS 'Appropriate Count' , 
		SUM(SkinFamilyApproachCount ) AS 'Family Approach Count' , 
		SUM(SkinWrittenConsentCount ) AS 'Written Consent Count' , 
		SUM(SkinRecoveredCount ) AS 'Recovered Count' , 
		'Skin' AS Type
	FROM 	Referral_FSConversionRateCount rfcr
	JOIN	
		_ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfcr.StatEmployeeID
	LEFT 
	JOIN
		 _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID 
	LEFT 
	JOIN
		_ReferralProdReport.dbo.Organization po ON po.OrganizationID = p.OrganizationID
	 
	JOIN 	
		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfcr.SourceCodeID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupSourceCode wrpsc ON wrpsc.SourceCodeID = sc.SourceCodeID

   	JOIN 	
		_ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = rfcr.OrganizationID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = ro.OrganizationID

	WHERE	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @StartDateTime
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @EndDateTime

	AND   rfcr.StatemployeeID = ISNULL(@EmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@SourceCodeID , rfcr.SourceCodeID)
	AND 	
		p.OrganizationID = ISNULL(@PersonOrgID, po.OrganizationID)
	
AND			wrpsc.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	AND		
		wrgo.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	GROUP BY	
		po.OrganizationName,
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName,
		YearID , 
		MonthID 
		-- DayID , 
		--HourID  

UNION ALL

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Total Referrals Count', 
		
		SUM(HeartValvesAppropriateCount ) AS 'Appropriate Count' , 
		SUM(HeartValvesFamilyApproachCount ) AS 'Family Approach Count' , 
		SUM(HeartValvesWrittenConsentCount ) AS 'Written Consent Count' , 
		SUM(HeartValvesRecoveredCount ) AS 'Recovered Count' , 
		'Hear Valves' AS Type
	FROM 	Referral_FSConversionRateCount rfcr
	JOIN	
		_ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfcr.StatEmployeeID
	LEFT 
	JOIN
		 _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID 
	LEFT 
	JOIN
		_ReferralProdReport.dbo.Organization po ON po.OrganizationID = p.OrganizationID
	 
	JOIN 	
		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfcr.SourceCodeID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupSourceCode wrpsc ON wrpsc.SourceCodeID = sc.SourceCodeID

   	JOIN 	
		_ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = rfcr.OrganizationID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = ro.OrganizationID

	WHERE	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @StartDateTime
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @EndDateTime

	AND   rfcr.StatemployeeID = ISNULL(@EmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@SourceCodeID , rfcr.SourceCodeID)
	AND 	
		p.OrganizationID = ISNULL(@PersonOrgID, po.OrganizationID)
	
AND			wrpsc.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	AND		
		wrgo.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	GROUP BY	
		po.OrganizationName,
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName,
		YearID , 
		MonthID 
		-- DayID , 
		--HourID  		
		
UNION ALL

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Total Referrals Count', 
		
		SUM(EyesAppropriateCount ) AS 'Appropriate Count' , 
		SUM(EyesFamilyApproachCount ) AS 'Family ApproachCount' , 
		SUM(EyesWrittenConsentCount ) AS 'Written ConsentCount' , 
		SUM(EyesRecoveredCount ) AS 'Recovered Count',  
		'Eyes' AS Type
	FROM 	Referral_FSConversionRateCount rfcr
	JOIN	
		_ReferralProdReport.dbo.StatEmployee se ON se.StatEmployeeID = rfcr.StatEmployeeID
	LEFT 
	JOIN
		 _ReferralProdReport.dbo.Person p ON p.PersonID = se.PersonID 
	LEFT 
	JOIN
		_ReferralProdReport.dbo.Organization po ON po.OrganizationID = p.OrganizationID
	 
	JOIN 	
		_ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = rfcr.SourceCodeID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupSourceCode wrpsc ON wrpsc.SourceCodeID = sc.SourceCodeID

   	JOIN 	
		_ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = rfcr.OrganizationID

	JOIN	
		_ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = ro.OrganizationID

	WHERE	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @StartDateTime
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @EndDateTime

	AND   rfcr.StatemployeeID = ISNULL(@EmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@SourceCodeID , rfcr.SourceCodeID)
	AND 	
		p.OrganizationID = ISNULL(@PersonOrgID, po.OrganizationID)
	
AND			wrpsc.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	AND		
		wrgo.WebReportGroupID = ISNULL(@ReportGroupOrgID , wrgo.WebReportGroupID)
	GROUP BY	
		po.OrganizationName,
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName,
		YearID , 
		MonthID 
		-- DayID , 
		--HourID  


	ORDER BY
		YearID , 
		MonthID , 
		po.OrganizationName	
		--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName
		-- DayID , 
		--HourID  

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

