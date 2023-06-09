SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GOLM_ClinicalTriggers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GOLM_ClinicalTriggers]
GO

CREATE PROCEDURE sps_GOLM_ClinicalTriggers
	@vReportGroupID		int = 0,
	@vStartDate		datetime = null,
	@vEndDate		datetime = null,
	@vOrgID			int = 0

AS
------------------------------------------------------

DECLARE @vOrgName		varchar(80),
	@vMonthYear		varchar(14),
	@vNumMonths		smallint,
	@vCurrentMonth	smallint,
	@vCurrentYear		smallint,
	@vCounter		smallint,
	@SourceCodeList varchar(50)		--drh 09/26/03


--Create the temp table
	CREATE TABLE #_Temp_ClinicalTriggers
	(
	[YearID] [int]  NULL DEFAULT (0),
	[MonthID] [int] NULL DEFAULT (0),
	[MonthYear] [varchar] (14) NULL DEFAULT (0),
	[OrganizationID] [int] NOT NULL ,
	[OrganizationName] [varchar] (80) NOT NULL,
	[Referral_Count] [int] NULL DEFAULT (0),
	[ClinicalTriggers_Count] [int] NULL DEFAULT (0),
	[OnTimeReferrals_Count] [int] NULL DEFAULT (0)
	)

	--Clean temp tables
	DELETE #_Temp_ClinicalTriggers

	--drh 09/26/03 Get the SourceCode List for this Report Group
	exec sps_GetReportGroupSourceCodeList @vReportGroupID, @SourceCodeList output

IF	@vOrgID = 0
BEGIN

	--Get the base data
	INSERT INTO #_Temp_ClinicalTriggers
	(OrganizationID, OrganizationName)

    	SELECT 	_ReferralProdReport.dbo.Organization.OrganizationID, OrganizationName
    	FROM 		_ReferralProdReport.dbo.Organization
	LEFT JOIN	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID
  	ORDER BY 	OrganizationName


	--See if there is referral count data and update the temp table
	UPDATE	#_Temp_ClinicalTriggers
	SET		Referral_Count = CountTable.AllTypes		
	FROM		
	(
    	SELECT 	Referral_TypeCount.OrganizationID,
			SUM(AllTypes) AS 'AllTypes'
    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_TypeCount.OrganizationID
	) AS CountTable
	WHERE 	#_Temp_ClinicalTriggers.OrganizationID = CountTable.OrganizationID

	--See if there is referral cms count data and update the temp table
	UPDATE	#_Temp_ClinicalTriggers
	SET		ClinicalTriggers_Count = CountTable.ClinicalTriggers_Count		
	FROM		
	(
    	SELECT 	Referral_CMSReport.OrganizationID,
			SUM(Referral_CT) AS 'ClinicalTriggers_Count'
    	FROM 		Referral_CMSReport
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_CMSReport.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CMSReport.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_CMSReport.OrganizationID
	) AS CountTable
	WHERE 	#_Temp_ClinicalTriggers.OrganizationID = CountTable.OrganizationID

	--See if there is death data and update the temp table
	UPDATE	#_Temp_ClinicalTriggers
	SET		OnTimeReferrals_Count = CountTable.OnTimeReferrals_Count
	FROM		
	(
	SELECT 	OrganizationSuppliedData.OrganizationID, Sum(OnTimeReferrals) As OnTimeReferrals_Count
	FROM		OrganizationSuppliedData
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = OrganizationSuppliedData.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID	
	AND		OrganizationSuppliedData.SourceCodeList = @SourceCodeList	--drh 09/26/03
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	OrganizationSuppliedData.OrganizationID
	) AS CountTable
	WHERE	#_Temp_ClinicalTriggers.OrganizationID = CountTable.OrganizationID


	--Select final list
	SELECT OrganizationID,
			OrganizationName,
			SUM(Referral_Count) AS 'Referral_Count',
			SUM(ClinicalTriggers_Count) AS 'ClinicalTriggers_Count',
			SUM(OnTimeReferrals_Count) AS 'OnTimeReferrals_Count'
    	FROM 	#_Temp_ClinicalTriggers
	GROUP BY 	OrganizationID, OrganizationName
	ORDER BY 	OrganizationName
END
------------------------------------------------------

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
			INSERT INTO #_Temp_ClinicalTriggers
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
	UPDATE	#_Temp_ClinicalTriggers
	SET		Referral_Count = CountTable.AllTypes		
	FROM		
	(
    	SELECT 	YearID, MonthID,
			SUM(AllTypes) AS 'AllTypes'
    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND	 	Referral_TypeCount.OrganizationID = @vOrgID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY YearID, MonthID

	) AS CountTable
	WHERE	#_Temp_ClinicalTriggers.YearID = CountTable.YearID
	AND		#_Temp_ClinicalTriggers.MonthID = CountTable.MonthID

	--See if there is referral cms count data and update the temp table
	UPDATE	#_Temp_ClinicalTriggers
	SET		ClinicalTriggers_Count = CountTable.ClinicalTriggers_Count		
	FROM		
	(
    	SELECT 	YearID, MonthID,
			SUM(Referral_CT) AS 'ClinicalTriggers_Count'
    	FROM 		Referral_CMSReport
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_CMSReport.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CMSReport.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND 		Referral_CMSReport.OrganizationID = @vOrgID
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY YearID, MonthID

	) AS CountTable
	WHERE	#_Temp_ClinicalTriggers.YearID = CountTable.YearID
	AND		#_Temp_ClinicalTriggers.MonthID = CountTable.MonthID

	--See if there is death data and update the temp table
	UPDATE	#_Temp_ClinicalTriggers
	SET		OnTimeReferrals_Count = CountTable.OnTimeReferrals_Count
	FROM		
	(
	SELECT 	YearID, MonthID, OnTimeReferrals As OnTimeReferrals_Count
	FROM		OrganizationSuppliedData
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = OrganizationSuppliedData.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID	
	AND		OrganizationSuppliedData.SourceCodeList = @SourceCodeList	--drh 09/26/03
	AND 		OrganizationSuppliedData.OrganizationID = @vOrgID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	
	) AS CountTable
	WHERE	#_Temp_ClinicalTriggers.YearID = CountTable.YearID
	AND		#_Temp_ClinicalTriggers.MonthID = CountTable.MonthID


	--Select final list
	SELECT OrganizationID,
			OrganizationName,
			MonthID,
			YearID,
			SUM(Referral_Count) AS 'Referral_Count',
			SUM(ClinicalTriggers_Count) AS 'ClinicalTriggers_Count',
			SUM(OnTimeReferrals_Count) AS 'OnTimeReferrals_Count'
    	FROM 	#_Temp_ClinicalTriggers
	GROUP BY 	MonthID,
			YearID,
			OrganizationName,
			OrganizationID,			
			Referral_Count,
			ClinicalTriggers_Count,
			OnTimeReferrals_Count

	ORDER BY	OrganizationName, 
			YearID, 
			MonthID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

