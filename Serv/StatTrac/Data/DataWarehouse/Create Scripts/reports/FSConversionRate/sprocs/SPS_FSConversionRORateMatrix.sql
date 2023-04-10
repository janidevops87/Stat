if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSConversionRORateMatrix]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSConversionRORateMatrix]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_FSConversionRORateMatrix

	@StartDateTime		DATETIME	= NULL ,
	@EndDateTime		DATETIME  	= NULL ,
	@EmployeeID			INT			= NULL ,
	@SourceCodeID		INT			= NULL ,
	@PersonOrgID		INT			= NULL ,
	@ReportGroupOrgID	INT			= NULL 
AS
	-- test exec sps_FSConversionRORateMatrix '1/1/07', '1/2/07', null, null, null, 614

	SELECT 	--se.StatemployeeFirstName + ' ' + se.StatemployeeLastName AS 'Statline Employee' ,
		po.OrganizationName,
		YearID , 
		MonthID , 		
		SUM( BoneCnrROCount ) AS 'Bone', 
		SUM( SkinCnrROCount ) AS 'Skin',
		SUM( HeartCnrROCount ) AS 'Heart' , 
		SUM( EyesCnrROCount ) AS 'Eyes' , 				
		'Coroner RO' AS Type
		
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
		SUM( BoneNBDCount ) AS 'Bone', 
		SUM( SkinNBDCount ) AS 'Skin', 
		SUM( HeartNBDCount ) AS 'Heart', 
		SUM( EyesNBDCount ) AS 'Eyes', 
		'Never Brain Dead' AS Type
		
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
		SUM( BoneMROCount ) AS 'Bone', 
		SUM( SkinMROCount ) AS 'Skin', 
		SUM( HeartMROCount ) AS 'Heart', 
		SUM( EyesMROCount ) AS 'Eyes', 		
		'Medical RO' AS Type
		
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
		SUM( BoneHighRiskCount ) AS 'Bone', 
		SUM( SkinHighRiskCount ) AS 'Skin', 
		SUM( HeartHighRiskCount ) AS 'Heart', 
		SUM( EyesHighRiskCount ) AS 'Eyes', 		
		'High Risk' AS Type
	 
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
		SUM( BoneLogisticsCount ) AS 'Bone', 
		SUM( SkinLogisticsCount ) AS 'Skin', 
		SUM( HeartLogisticsCount ) AS 'Heart', 
		SUM( EyesLogisticsCount ) AS 'Eyes', 		
		'Logistics' AS Type
			 
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
		SUM( BoneHrtTxablCount ) AS 'Bone', 
		SUM( SkinHrtTxablCount ) AS 'Skin', 
		SUM( HeartHrtTxablCount ) AS 'Heart', 
		SUM( EyesHrtTxablCount ) AS 'Eyes', 		
		'Heart Taxable' AS Type
			 
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
		SUM( BoneUnKnownCount ) AS 'Bone', 
		SUM( SkinUnKnownCount ) AS 'Skin', 
		SUM( HeartUnKnownCount  ) AS 'Heart', 
		SUM( EyesUnKnownCount ) AS 'Eyes', 		
		'UnKnown' AS Type
			 
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
		SUM( BoneFamilyROCount ) AS 'Bone', 
		SUM( SkinFamilyROCount ) AS 'Skin', 
		SUM( HeartFamilyROCount ) AS 'Heart', 
		SUM( EyesFamilyROCount ) AS 'Eyes', 		
		'Family RO' AS Type
		 
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
		SUM( BoneNtRecvrdCount ) AS 'Bone', 
		SUM( SkinNtRecvrdCount ) AS 'Skin', 
		SUM( HeartNtRecvrdCount ) AS 'Heart', 
		SUM( EyesNtRecvrdCount ) AS 'Eyes', 		
		'Not Recovered' AS Type
		
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
		SUM( BoneNACount ) AS 'Bone', 
		SUM( SkinNACount ) AS 'Skin', 
		SUM( HeartNACount ) AS 'Heart', 
		SUM( EyesNACount ) AS 'Eyes', 		
		'Not Available' AS Type

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

