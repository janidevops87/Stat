if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSConversionRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSConversionRate]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_FSConversionRate

	@vStartDate	DATETIME	= NULL ,
	@vEndDate	DATETIME  	= NULL ,
	@vEmployeeID	INT		= NULL ,
	@vSourceCodeID	INT		= NULL ,
	@PersonOrgID	INT		= NULL ,
	@ReportGroupOrgID INT	= NULL 
AS

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 
		SUM( TotalReferralsCount ) AS 'Total Referrals Count', 
		SUM( TotalAppropriateCount ) AS 'Total Appropriate Count', 
		SUM( TotalFamilyApproachCount ) AS 'Total Approach Count ', 
		SUM( TotalWrittenConsentCount ) AS 'Total Written Consent Count', 
		SUM( TotalRecoveredCount ) AS 'Total Recovered Count' , 
		SUM(BoneAppropriateCount ) AS 'Bone AppropriateCount' , 
		SUM(BoneFamilyApproachCount ) AS 'Bone Family Approach Count' , 
		SUM(BoneWrittenConsentCount ) AS 'Bone Written Consent Count' , 
		SUM(BoneRecoveredCount ) AS 'Bone Recovered Count' , 
		SUM(SkinAppropriateCount ) AS 'Skin Appropriate Count' , 
		SUM(SkinFamilyApproachCount ) AS 'Skin Family Approach Count' , 
		SUM(SkinWrittenConsentCount ) AS 'Skin Written Consent Count' , 
		SUM(SkinRecoveredCount ) AS 'Skin Recovered Count' , 
		SUM(HeartValvesAppropriateCount ) AS 'Heart Valves Appropriate Count' , 
		SUM(HeartValvesFamilyApproachCount ) AS 'Heart Valves Family Approach Count' , 
		SUM(HeartValvesWrittenConsentCount ) AS 'Heart Valves Written Consent Count' , 
		SUM(HeartValvesRecoveredCount ) AS 'Heart Valves Recovered Count' , 
		SUM(EyesAppropriateCount ) AS 'Eyes Appropriate Count' , 
		SUM(EyesFamilyApproachCount ) AS 'Eyes Family ApproachCount' , 
		SUM(EyesWrittenConsentCount ) AS 'Eyes Written ConsentCount' , 
		SUM(EyesRecoveredCount ) AS 'Eyes Recovered Count'  

		
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
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND	
		CAST(  CAST(rfcr.MonthID AS varchar(2)) + '/1/' + CAST(rfcr.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	AND   rfcr.StatemployeeID = ISNULL(@vEmployeeID , rfcr.StatemployeeID)
	AND	
		rfcr.SourceCodeID = ISNULL(@vSourceCodeID , rfcr.SourceCodeID)
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

