SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AgeDemoSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AgeDemoSummary_A]
GO





CREATE PROCEDURE sps_AgeDemoSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

SET NOCOUNT ON 

DECLARE
   @DonorGender varchar,
   @DonorGenderCount int 

SET @DonorGender = 'M'
SET @DonorGenderCount = 1

--Build Temp Table
CREATE TABLE #_Temp_Referral_AgeDemoSummary
   (
   [AgeRangeID] [int] NULL,
   [AgeName] [char] (10)  NULL,
   [AgeRangeStart] [int] NULL,
   [AgeRangeEnd] [int] NULL,
   [OrganizationID] [int] NULL,
   [DonorGender] [char] (1) NULL,
   [AllTypes] [int] NULL DEFAULT(0),
   [AppropriateOrgan] [int] NULL DEFAULT(0),
   [AppropriateAllTissue] [int] NULL DEFAULT(0),
   [AppropriateEyes] [int] NULL DEFAULT(0),
   [AppropriateRO] [int] NULL DEFAULT(0),

   --2/8/02 drh
   [AllTypes_Reg] [int] NULL DEFAULT(0),
   [AppropriateOrgan_Reg] [int] NULL DEFAULT(0),
   [AppropriateAllTissue_Reg] [int] NULL DEFAULT(0),
   [AppropriateEyes_Reg] [int] NULL DEFAULT(0),
   [AppropriateRO_Reg] [int] NULL DEFAULT(0)
   )

WHILE @DonorGenderCount <= 2
BEGIN

   --Add initial Data
   INSERT #_Temp_Referral_AgeDemoSummary
   (AgeRangeID, AgeName, AgeRangeStart, AgeRangeEnd)
   SELECT AgeRangeID, AgeRangeName, AgeRangeStart, AgeRangeEnd 
   FROM AgeRange

   -- UPDATE DonorGender
   UPDATE #_Temp_Referral_AgeDemoSummary
   SET DonorGender = @DonorGender
   WHERE DonorGender IS NULL

   If @DonorGender = 'F' 
   	BEGIN 
      		SET @DonorGender = 'M' 
   	END
   Else 
   	BEGIN 
      		SET @DonorGender = 'F' 
   	END
   SET @DonorGenderCount = @DonorGenderCount + 1
END

IF	@vOrgID = 0

      
        UPDATE    #_Temp_Referral_AgeDemoSummary
        SET      
	    --OrganizationID = CountTable.OrganizationID,
                  AllTypes = CountTable.AllTypes, 
                  AppropriateOrgan = CountTable.AppropriateOrgan,
                  AppropriateAllTissue = CountTable.AppropriateAllTissue,
                  AppropriateEyes = CountTable.AppropriateEyes,
                  AppropriateRO = CountTable.AppropriateRO,

	    --2/8/02 drh
	     AllTypes_Reg = CountTable.AllTypes_Reg, 
                  AppropriateOrgan_Reg = CountTable.AppropriateOrgan_Reg,
                  AppropriateAllTissue_Reg = CountTable.AppropriateAllTissue_Reg,
                  AppropriateEyes_Reg = CountTable.AppropriateEyes_Reg,
                  AppropriateRO_Reg = CountTable.AppropriateRO_Reg
      FROM                  
      (

       SELECT 		--Referral_AgeDemoCount.OrganizationID AS OrganizationID,
			Referral_AgeDemoCount.AgeRangeID,
                        		Referral_AgeDemoCount.DonorGender,
                        		Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO,

			--2/8/02 drh
                        		Sum(AllTypes_Reg) AS AllTypes_Reg,
			Sum(AppropriateOrgan_Reg) AS AppropriateOrgan_Reg, 
			Sum(AppropriateAllTissue_Reg) AS AppropriateAllTissue_Reg,
			Sum(AppropriateEyes_Reg) AS AppropriateEyes_Reg, 
			Sum(AppropriateRO_Reg) AS AppropriateRO_Reg
    	FROM 		Referral_AgeDemoCount
    	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AgeDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AgeDemoCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	LEFT JOIN	AgeRange ON Referral_AgeDemoCount.AgeRangeID = AgeRange.AgeRangeID
   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	GROUP BY	DonorGender, Referral_AgeDemoCount.AgeRangeID--, Referral_AgeDemoCount.OrganizationID
        ) AS CountTable   
        WHERE   #_Temp_Referral_AgeDemoSummary.DonorGender = CountTable.DonorGender
        AND     #_Temp_Referral_AgeDemoSummary.AgeRangeID  = CountTable.AgeRangeID


IF	@vOrgID > 0

        UPDATE    #_Temp_Referral_AgeDemoSummary
        SET     
	     --OrganizationID = CountTable.OrganizationID,
                  AllTypes = CountTable.AllTypes, 
                  AppropriateOrgan = CountTable.AppropriateOrgan,
                  AppropriateAllTissue = CountTable.AppropriateAllTissue,
                  AppropriateEyes = CountTable.AppropriateEyes,
                  AppropriateRO = CountTable.AppropriateRO,

	    --2/8/02 drh
	     AllTypes_Reg = CountTable.AllTypes_Reg, 
                  AppropriateOrgan_Reg = CountTable.AppropriateOrgan_Reg,
                  AppropriateAllTissue_Reg = CountTable.AppropriateAllTissue_Reg,
                  AppropriateEyes_Reg = CountTable.AppropriateEyes_Reg,
                  AppropriateRO_Reg = CountTable.AppropriateRO_Reg
      FROM                  
      (

    	SELECT 		--YearID, Referral_AgeDemoCount.MonthID AS MonthID, 
			--Referral_AgeDemoCount.OrganizationID AS OrganizationID,
			Referral_AgeDemoCount.AgeRangeID,
			AgeRangeName As AgeName, 
			DonorGender,
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			--Referral_AgeDemoCount.OrganizationID, OrganizationName, 
                        Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes,  Sum(AppropriateRO) AS AppropriateRO,

			--2/8/02 drh
                        		Sum(AllTypes_Reg) AS AllTypes_Reg,
			Sum(AppropriateOrgan_Reg) AS AppropriateOrgan_Reg, 
			Sum(AppropriateAllTissue_Reg) AS AppropriateAllTissue_Reg,
			Sum(AppropriateEyes_Reg) AS AppropriateEyes_Reg, 
			Sum(AppropriateRO_Reg) AS AppropriateRO_Reg

    	FROM 		Referral_AgeDemoCount
    	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AgeDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AgeDemoCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_AgeDemoCount.MonthID
	LEFT JOIN	AgeRange ON Referral_AgeDemoCount.AgeRangeID = AgeRange.AgeRangeID
   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_AgeDemoCount.OrganizationID = @vOrgID

	GROUP BY	--YearID, Referral_AgeDemoCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
                        Referral_AgeDemoCount.AgeRangeID, DonorGender,  AgeRangeName--, Referral_AgeDemoCount.OrganizationID
			
        ) AS CountTable   
        WHERE   #_Temp_Referral_AgeDemoSummary.DonorGender = CountTable.DonorGender
        AND     #_Temp_Referral_AgeDemoSummary.AgeRangeID  = CountTable.AgeRangeID

SELECT * FROM #_Temp_Referral_AgeDemoSummary
DROP TABLE #_Temp_Referral_AgeDemoSummary















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

