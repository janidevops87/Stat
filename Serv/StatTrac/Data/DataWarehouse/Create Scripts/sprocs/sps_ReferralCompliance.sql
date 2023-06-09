SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCompliance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCompliance]
GO





CREATE PROCEDURE sps_ReferralCompliance

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
	@vCounter		smallint,
	@SourceCodeList varchar(50)		--drh 09/26/03


	--Create the temp table
	CREATE TABLE #_Temp_Referral_Compliance
	(
	[YearID] [int]  NULL DEFAULT (0),
	[MonthID] [int] NULL DEFAULT (0),
	[MonthYear] [varchar] (14) NULL DEFAULT (0),
	[OrganizationID] [int] NOT NULL ,
	[OrganizationName] [varchar] (80) NOT NULL,
	[AllTypes] [int] NULL DEFAULT (0),
	[TotalDeaths] [int] NULL DEFAULT (0),
	[TotalRegistry] [int] NULL DEFAULT (0)
	)

	--Clean temp tables
	DELETE #_Temp_Referral_Compliance

	--drh 09/26/03 Get the SourceCode List for this Report Group
	exec sps_GetReportGroupSourceCodeList @vReportGroupID, @SourceCodeList output

	
IF	@vOrgID = 0

	BEGIN

	--Get the base data
	INSERT INTO #_Temp_Referral_Compliance
	(OrganizationID, OrganizationName)

    	SELECT 	_ReferralProdReport.dbo.Organization.OrganizationID, OrganizationName
    	FROM 		_ReferralProdReport.dbo.Organization
	LEFT JOIN	_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID	
  	ORDER BY 	OrganizationName


	--See if there is referral count data and update the temp table
	UPDATE	#_Temp_Referral_Compliance
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
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_TypeCount.OrganizationID

	) AS CountTable
	
	WHERE 	#_Temp_Referral_Compliance.OrganizationID = CountTable.OrganizationID

	--See if there is death data and update the temp table
	UPDATE	#_Temp_Referral_Compliance
	SET		TotalDeaths = CountTable.TotalDeaths
	FROM		

	(
	SELECT 	OrganizationDeaths.OrganizationID, Sum(TotalDeaths) As TotalDeaths
	FROM		OrganizationDeaths
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = OrganizationDeaths.OrganizationID

   	 WHERE 	WebReportGroupID = @vReportGroupID	
	AND		OrganizationDeaths.SourceCodeList = @SourceCodeList	--drh 09/26/03
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	OrganizationDeaths.OrganizationID

	) AS CountTable

	WHERE	#_Temp_Referral_Compliance.OrganizationID = CountTable.OrganizationID


	--See if there is registry count data and update the temp table
	UPDATE	#_Temp_Referral_Compliance
	SET		TotalRegistry = CountTable.RegistryType
	FROM		

	(
    	SELECT 	Referral_TypeCount.OrganizationID, Sum(RegistryType) AS RegistryType

    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_TypeCount.MonthID

   	 WHERE 	_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_TypeCount.OrganizationID

	) AS CountTable
	
	WHERE 	#_Temp_Referral_Compliance.OrganizationID = CountTable.OrganizationID
	

	--Select the final list
    	SELECT 	OrganizationID, OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(TotalDeaths)  As TotalDeaths,
			Sum(TotalRegistry)  As TotalRegistry

    	FROM 		#_Temp_Referral_Compliance

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
			INSERT INTO #_Temp_Referral_Compliance
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
	UPDATE	#_Temp_Referral_Compliance
	SET		AllTypes = CountTable.AllTypes
	FROM		

	(
    	SELECT 	YearID, MonthID,  SUM(AllTypes) as AllTypes
    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

   	 WHERE 	Referral_TypeCount.OrganizationID = @vOrgID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY YearID, MonthID

	) AS CountTable	

	WHERE	#_Temp_Referral_Compliance.YearID = CountTable.YearID
	AND		#_Temp_Referral_Compliance.MonthID = CountTable.MonthID



	--See if there is death data and update the temp table
	UPDATE	#_Temp_Referral_Compliance
	SET		TotalDeaths = CountTable.TotalDeaths
	FROM		

	(
	SELECT 	YearID, MonthID, TotalDeaths
	FROM		OrganizationDeaths

   	 WHERE 	OrganizationDeaths.OrganizationID = @vOrgID
	AND		OrganizationDeaths.SourceCodeList = @SourceCodeList	--drh 09/26/03	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	) AS CountTable

	WHERE	#_Temp_Referral_Compliance.YearID = CountTable.YearID
	AND		#_Temp_Referral_Compliance.MonthID = CountTable.MonthID

	--See if there is registry count data and update the temp table
	UPDATE	#_Temp_Referral_Compliance
	SET		TotalRegistry = CountTable.RegistryType
	FROM		

	(
    	SELECT 	YearID, MonthID, SUM(RegistryType) as RegistryType
    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID

   	 WHERE 	Referral_TypeCount.OrganizationID = @vOrgID	
	AND 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY YearID, MonthID

	) AS CountTable	

	WHERE	#_Temp_Referral_Compliance.YearID = CountTable.YearID
	AND		#_Temp_Referral_Compliance.MonthID = CountTable.MonthID


	--Select the final list
    	SELECT 	YearID, MonthID, MonthYear, 
			OrganizationID, OrganizationName, 
			AllTypes,
			TotalDeaths,
			TotalRegistry

    	FROM 		#_Temp_Referral_Compliance
	ORDER BY	YearID, MonthID

	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

