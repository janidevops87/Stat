SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralAnalysis]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralAnalysis]
GO



CREATE PROCEDURE sps_ReferralAnalysis
	@vReportGroupID	int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0

AS

DECLARE

	@vOrgName		varchar(80),
	@vMonthYear		varchar(14),
	@vNumMonths		smallint,
	@vCurrentMonth	smallint,
	@vCurrentYear		smallint,
	@vCounter		smallint


	--Create the temp table
	CREATE TABLE #_Temp_Referral_Analysis
	(
	[YearID] [int]  NULL DEFAULT (0),
	[MonthID] [int] NULL DEFAULT (0),
	[MonthYear] [varchar] (14) NULL DEFAULT (0),
	[OrganizationID] [int] NOT NULL ,
	[OrganizationName] [varchar] (80) NOT NULL,
	[AllTypes] [int] NULL DEFAULT (0),
	[Over75] [int] NULL DEFAULT (0),
	[Eyes_MedRO] [int] NULL DEFAULT (0),
	[FamilyInitiated] [int] NULL DEFAULT (0),
	[PreApproach] [int] NULL DEFAULT (0),
	[PostApproach] [int] NULL DEFAULT (0),
	[FamilyDecline] [int] NULL DEFAULT (0),
	[FamilyConsent] [int] NULL DEFAULT (0),
	[ActualRecovered] [int] NULL DEFAULT (0)
	)

	--Clean temp tables
	DELETE #_Temp_Referral_Analysis

	
IF	@vOrgID = 0

	BEGIN

	--Get the base data
	INSERT INTO #_Temp_Referral_Analysis
	(OrganizationID, OrganizationName)

    	SELECT 	_ReferralProdReport.dbo.Organization.OrganizationID, OrganizationName
    	FROM 		_ReferralProdReport.dbo.Organization
	LEFT JOIN	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID	
  	ORDER BY 	OrganizationName


	--See if there is referral count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		AllTypes = CountTable.AllTypes
	FROM		

	(
    	SELECT 	Referral_TypeCount.OrganizationID, Sum(AllTypes) AS AllTypes

    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_TypeCount.MonthID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_TypeCount.OrganizationID

	) AS CountTable
	
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID


	--See if there is Over 75 age count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		Over75 = CountTable.Over75
	FROM		

	(
	SELECT 	Referral_AgeDemoCount.OrganizationID, Sum(AllTypes) As Over75
	FROM		Referral_AgeDemoCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AgeDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AgeDemoCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
    	

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND Referral_AgeDemoCount.AgeRangeID > 12

	GROUP BY	Referral_AgeDemoCount.OrganizationID

	) AS CountTable

	WHERE	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID


	--See if there is Med RO count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		Eyes_MedRO = CountTable.Eyes_MedRO
	FROM		

	(
    	SELECT 	Referral_AppropriateReasonCount.OrganizationID, Sum(AppropriateEyesHighRisk + AppropriateEyesMedRO + AppropriateEyesNotAppropriate) AS Eyes_MedRO

    	FROM 		Referral_AppropriateReasonCount
    	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
    	
   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_AppropriateReasonCount.OrganizationID

	) AS CountTable
	
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	
	--See if there is family approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyInitiated = CountTable.FamilyInitiated
	FROM		

	(
	SELECT 	Referral_ApproachCount.OrganizationID, Sum(E_FamilyInitiated_Approached_DR + E_FamilyInitiated_Approached_NonDR) AS FamilyInitiated

	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	
	GROUP BY	Referral_ApproachCount.OrganizationID

	) AS CountTable
		
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	--See if there is Pre-approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		PreApproach = CountTable.PreApproach
	FROM		

	(
	SELECT 	Referral_ApproachCount.OrganizationID, Sum((E_PreRef_Approached_DR + E_PreRef_Approached_NonDR) - (E_FamilyInitiated_Approached_DR + E_FamilyInitiated_Approached_NonDR)) AS PreApproach

	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ApproachCount.OrganizationID

	) AS CountTable
			
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	
	--See if there is Post-approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		PostApproach = CountTable.PostApproach
	FROM		

	(
	SELECT 	Referral_ApproachCount.OrganizationID, Sum(E_PostRef_Approached_DR + E_PostRef_Approached_NonDR) AS PostApproach

	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ApproachCount.OrganizationID

	) AS CountTable
				
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	
	--See if there is Family Decline Consent count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyDecline = CountTable.FamilyDecline
	FROM		

	(
	SELECT 	Referral_ConsentReasonCount.OrganizationID, Sum(ConsentEyesNotConsented + RegConsentEyesNotConsented) AS FamilyDecline

	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ConsentReasonCount.OrganizationID

	) AS CountTable
		
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	
	--See if there is Family Consent count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyConsent = CountTable.FamilyConsent
	FROM		

	(
	SELECT 	Referral_ConsentReasonCount.OrganizationID, Sum(ConsentEyes + RegConsentEyes) AS FamilyConsent

	FROM 		Referral_ConsentReasonCount

	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ConsentReasonCount.OrganizationID

	) AS CountTable
			
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
	
	
	--See if there is Recovery count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		ActualRecovered = CountTable.ActualRecovered
	FROM		

	(
	SELECT 	Referral_ConversionReasonCount.OrganizationID, Sum(ConversionEyes + RegConversionEyes) AS ActualRecovered

	FROM 		Referral_ConversionReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConversionReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConversionReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_ConversionReasonCount.OrganizationID

	) AS CountTable
				
	WHERE 	#_Temp_Referral_Analysis.OrganizationID = CountTable.OrganizationID
		
	
	--Select the final list
    	SELECT 	OrganizationID, OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(Over75)  As Over75,
			Sum(Eyes_MedRO)  As Eyes_MedRO,
			Sum(FamilyInitiated)  As FamilyInitiated,
			Sum(PreApproach)  As PreApproach,
			Sum(PostApproach)  As PostApproach,
			Sum(FamilyDecline)  As FamilyDecline,
			Sum(FamilyConsent)  As FamilyConsent,
			Sum(ActualRecovered)  As ActualRecovered

    	FROM 		#_Temp_Referral_Analysis

	GROUP BY	OrganizationID, OrganizationName
    	ORDER BY 	OrganizationName

	END

-- Logic branch if organization id is available
IF	@vOrgID > 0

	BEGIN

	--Get the organization name
    	SELECT 	@vOrgName = OrganizationName
    	FROM 		_ReferralProdReport.dbo.Organization
   	 WHERE 	OrganizationID = @vOrgID	

	--Get the number of months between the start date and the end date
	SELECT @vNumMonths = DATEDIFF(month, @vStartDate, @vEndDate)
	SELECT @vCurrentMonth = Month(@vStartDate)
	SELECT @vCurrentYear = Year(@vStartDate)

	--Loop through each month and year and insert a row
	SELECT @vCounter = 0

	WHILE (@vCounter < @vNumMonths + 1)

		BEGIN
			
			--Insert each row
			INSERT INTO #_Temp_Referral_Analysis
			(YearID, MonthID, MonthYear, OrganizationID, OrganizationName)

			SELECT 	@vCurrentYear,
					@vCurrentMonth,   
					CAST(@vCurrentYear AS varchar(4))  + ' ' + MonthName,
					@vOrgID, 
					@vOrgName

			FROM		Month
			WHERE	Month.MonthID = @vCurrentMonth

			--Increment the month and year
			IF @vCurrentMonth = 12 
				BEGIN
				SELECT @vCurrentMonth = 1
				SELECT @vCurrentYear = @vCurrentYear + 1
				END
			ELSE
				BEGIN
				SELECT @vCurrentMonth = @vCurrentMonth + 1
				END
			
			--Increment the counter
			SELECT @vCounter = @vCounter + 1	

		END


	--See if there is referral count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		AllTypes = CountTable.AllTypes
	FROM		

	(
    	SELECT 	YearID, MonthID,  AllTypes
    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

   	 WHERE 	Referral_TypeCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID



	--See if there is Over 75 age data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		Over75 = CountTable.Over75
	FROM		

	(
	SELECT 	YearID, MonthID, SUM(Referral_AgeDemoCount.AllTypes) as Over75
	FROM		Referral_AgeDemoCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AgeDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

   	 WHERE 	Referral_AgeDemoCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND Referral_AgeDemoCount.AgeRangeID > 12
	GROUP BY YearId, MonthId

	) AS CountTable

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID

	--See if there is Med RO count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		Eyes_MedRO = CountTable.Eyes_MedRO
	FROM		

	(
    	SELECT 	YearID, MonthID, AppropriateEyesHighRisk + AppropriateEyesMedRO + AppropriateEyesNotAppropriate as Eyes_MedRO
    	FROM 		Referral_AppropriateReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

   	WHERE 	Referral_AppropriateReasonCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID		
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	
	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Family Initiated approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyInitiated = CountTable.FamilyInitiated
	FROM		

	(
	SELECT 	YearID, MonthID, E_FamilyInitiated_Approached_DR + E_FamilyInitiated_Approached_NonDR as FamilyInitiated
	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ApproachCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Pre-Ref approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		PreApproach = CountTable.PreApproach
	FROM		

	(
	SELECT 	YearID, MonthID, (E_PreRef_Approached_DR + E_PreRef_Approached_NonDR) - (E_FamilyInitiated_Approached_DR + E_FamilyInitiated_Approached_NonDR) as PreApproach
	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ApproachCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID		
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Post-Ref approach count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		PostApproach = CountTable.PostApproach
	FROM		

	(
	SELECT 	YearID, MonthID, E_PostRef_Approached_DR + E_PostRef_Approached_NonDR as PostApproach
	FROM 		Referral_ApproachCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ApproachCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Family Decline Consent count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyDecline = CountTable.FamilyDecline
	FROM		

	(
	SELECT 	YearID, MonthID, ConsentEyesNotConsented + RegConsentEyesNotConsented as FamilyDecline
	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ConsentReasonCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Family Consent count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		FamilyConsent = CountTable.FamilyConsent
	FROM		

	(
	SELECT 	YearID, MonthID, ConsentEyes + RegConsentEyes as FamilyConsent
	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ConsentReasonCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
	
	
	--See if there is Recovery count data and update the temp table
	UPDATE	#_Temp_Referral_Analysis
	SET		ActualRecovered = CountTable.ActualRecovered
	FROM		

	(
	SELECT 	YearID, MonthID, ConversionEyes + RegConversionEyes as ActualRecovered
	FROM 		Referral_ConversionReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConversionReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

	WHERE 	Referral_ConversionReasonCount.OrganizationID = @vOrgID
	AND		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable	

	WHERE	#_Temp_Referral_Analysis.YearID = CountTable.YearID
	AND		#_Temp_Referral_Analysis.MonthID = CountTable.MonthID
		
	
	--Select the final list
    	SELECT 	YearID, MonthID, MonthYear, 
			OrganizationID, OrganizationName, 
			AllTypes,
			Over75,
			Eyes_MedRO,
			FamilyInitiated,
			PreApproach,
			PostApproach,
			FamilyDecline,
			FamilyConsent,
			ActualRecovered

    	FROM 		#_Temp_Referral_Analysis
	ORDER BY	YearID, MonthID

	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

