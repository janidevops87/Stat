SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_FSCallCountSummary1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_FSCallCountSummary1]
GO




-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_FSCallCountSummary 7, 2001
CREATE PROCEDURE spi_Referral_FSCallCountSummary1
   @MonthID	int,
   @YearID	int

AS

DECLARE
   
   @ReferralCount	int,
   @CurrentAgeRangeID	int,
   @CurrentAgeStart	int,
   @CurrentAgeEnd	int, 
   @DayLightStartDate   datetime,
   @DayLightEndDate     datetime,
   @maxAgeRangeID	int,
   @strSelectLine	varchar(8000),
   @strSelectLine2	varchar(8000),
   @strTemp		varchar(2000)


   --Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

--Create the temp table
CREATE TABLE ##_Temp_Referral_FSCallCountSummary 
   (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	
	[NoSecondaryOTE] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryTissue] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryTE] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryEye] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryAgeRO] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryMedRO] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryOther] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryOtherEye] [smallint] NULL DEFAULT(0) ,
	
	[SecondaryOTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryTissue] [smallint] NULL DEFAULT(0) ,
	[SecondaryTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryEye] [smallint] NULL DEFAULT(0) ,
	[SecondaryAgeRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryMedRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryOther] [smallint] NULL DEFAULT(0) ,
	[SecondaryOtherEye] [smallint] NULL DEFAULT(0) ,
	
	[FamilyApproachOTE] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTissue] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTE] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachEye] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachAgeRO] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachMedRO] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOther] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherEye] [smallint] NULL DEFAULT(0) ,
	
	[MedSocOTE] [smallint] NULL DEFAULT(0) ,
	[MedSocTissue] [smallint] NULL DEFAULT(0) ,
	[MedSocTE] [smallint] NULL DEFAULT(0) ,
	[MedSocEye] [smallint] NULL DEFAULT(0) ,
	[MedSocAgeRO] [smallint] NULL DEFAULT(0) ,
	[MedSocMedRO] [smallint] NULL DEFAULT(0) ,
	[MedSocOther] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherEye] [smallint] NULL DEFAULT(0),

	--1/17/03 drh
	[FamilyUnavailableOTE] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableTissue] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableTE] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableEye] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableAgeRO] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableMedRO] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableOther] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableOtherEye] [smallint] NULL DEFAULT(0) ,

	[CryolifeFormOTE] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTissue] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTE] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormEye] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormAgeRO] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormMedRO] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOther] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherEye] [smallint] NULL DEFAULT(0) ,
	
	[FamilyApproachOTECount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTissueCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTECount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachEyeCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachAgeROCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachMedROCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherEyeCount] [smallint] NULL DEFAULT(0) ,
	
	[MedSocOTECount] [smallint] NULL DEFAULT(0) ,
	[MedSocTissueCount] [smallint] NULL DEFAULT(0) ,
	[MedSocTECount] [smallint] NULL DEFAULT(0) ,
	[MedSocEyeCount] [smallint] NULL DEFAULT(0) ,
	[MedSocAgeROCount] [smallint] NULL DEFAULT(0) ,
	[MedSocMedROCount] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherCount] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherEyeCount] [smallint] NULL DEFAULT(0) ,

	[CryolifeFormOTECount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTissueCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTECount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormEyeCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormAgeROCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormMedROCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherEyeCount] [smallint] NULL DEFAULT(0)

	)

CREATE TABLE ##_Temp_Referral_FSCallCountSummarySelect
   (
	
	[ReferralCallerOrganizationID][int] NULL, 
	[SourceCodeID] [int] NULL,
	[ReferralID][int] NULL, 
	[ReferralTypeID] [int] NULL ,
	[ReferralGeneralConsent] [smallint] NULL ,
	[ReferralApproachTypeID] [int] NULL ,
	[ReferralOrganAppropriateID] [int] NULL ,
	[ReferralOrganApproachID] [int] NULL ,
	[ReferralOrganConsentID] [int] NULL ,
	[ReferralOrganConversionID] [int] NULL ,
	[ReferralBoneAppropriateID] [int] NULL ,
	[ReferralBoneApproachID] [int] NULL ,
	[ReferralBoneConsentID] [int] NULL ,
	[ReferralBoneConversionID] [int] NULL ,
	[ReferralTissueAppropriateID] [int] NULL ,
	[ReferralTissueApproachID] [int] NULL ,
	[ReferralTissueConsentID] [int] NULL ,
	[ReferralTissueConversionID] [int] NULL ,
	[ReferralSkinAppropriateID] [int] NULL ,
	[ReferralSkinApproachID] [int] NULL ,
	[ReferralSkinConsentID] [int] NULL ,
	[ReferralSkinConversionID] [int] NULL ,
	[ReferralEyesTransAppropriateID] [int] NULL ,
	[ReferralEyesTransApproachID] [int] NULL ,
	[ReferralEyesTransConsentID] [int] NULL ,
	[ReferralEyesTransConversionID] [int] NULL ,
	[ReferralEyesRschAppropriateID] [int] NULL ,
	[ReferralEyesRschApproachID] [int] NULL ,
	[ReferralEyesRschConsentID] [int] NULL ,
	[ReferralEyesRschConversionID] [int] NULL ,
	[ReferralValvesAppropriateID] [int] NULL ,
	[ReferralValvesApproachID] [int] NULL ,
	[ReferralValvesConsentID] [int] NULL ,
	[ReferralValvesConversionID] [int] NULL, 
	[FSCaseBillSecondaryUserID][int] NULL ,
	[FSCaseBillApproachUserID][int] NULL ,
	[FSCaseBillMedSocUserID][int] NULL ,

	--1/17/03 drh
	[FSCaseBillFamUnavailUserID][int] NULL ,
	[FSCaseBillCryoFormUserID][int] NULL ,
	[FSCaseBillApproachCount][int] NULL ,
	[FSCaseBillMedSocCount][int] NULL ,
	[FSCaseBillCryoFormCount][int] NULL
	
	--CallID                   INT,      	                                          
	--CallDateTime                    DATETIME
   )
	
--Store TimeZone CASE string
--exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--TRUNCATE TABLE ##_Temp_Referral_AgeDemo
	TRUNCATE TABLE ##_Temp_Referral_FSCallCountSummary
      --Get the list of organizations

	INSERT ##_Temp_Referral_FSCallCountSummary
	(YearID, MonthID, OrganizationID, SourceCodeID)

	SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,
	DATEPART(m, CallDateTime) AS MonthID,
	ReferralCallerOrganizationID,  
	c.SourceCodeID
	FROM _ReferralProdReport.dbo.Call c
	JOIN _ReferralProdReport.dbo.Referral r ON r.CallID = c.CallID
	JOIN _ReferralProdReport.dbo.Organization ro ON ro.OrganizationID = r.ReferralCallerOrganizationID 
	JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
	WHERE DATEPART(yyyy, CallDateTime) = @YearID
	AND DATEPART(m, CallDateTime) =   @MonthID
	ORDER BY ReferralCallerOrganizationID

        --Build a TempTable
            --Clean ##_Temp_Referral_FSCallCountSummarySelect
               TRUNCATE TABLE ##_Temp_Referral_FSCallCountSummarySelect
            --Insert Data into ##_Temp_Referral_FSCallCountSummarySelect based on agerange, gender, month and year
		INSERT ##_Temp_Referral_FSCallCountSummarySelect (ReferralCallerOrganizationID, SourceCodeID, ReferralID,
		ReferralTypeID, ReferralGeneralConsent, ReferralApproachTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID,
		ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID,
		ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID,
		ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID,
		ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID,
		ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID,
		ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID,
		ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID,
		ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, 
		ReferralValvesConsentID, ReferralValvesConversionID,
		FSCaseBillSecondaryUserID, FSCaseBillApproachUserID, FSCaseBillMedSocUserID,
		FSCaseBillFamUnavailUserID, FSCaseBillCryoFormUserID, FSCaseBillApproachCount, FSCaseBillMedSocCount, FSCaseBillCryoFormCount)	--1/17/03 drh
		SELECT ReferralCallerOrganizationID, _ReferralProdReport.dbo.Call.SourceCodeID, ReferralID,
		ReferralTypeID, ReferralGeneralConsent, ReferralApproachTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID,
		ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID,
		ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID,
		ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID,
		ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID,
		ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID,
		ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID,
		ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID,
		ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, 
		ReferralValvesConsentID, ReferralValvesConversionID, 
		fsc.FSCaseBillSecondaryUserID, fsc.FSCaseBillApproachUserID, fsc.FSCaseBillMedSocUserID,
		fsc.FSCaseBillFamUnavailUserID, fsc.FSCaseBillCryoFormUserID, fsc.FSCaseBillApproachCount, fsc.FSCaseBillMedSocCount, fsc.FSCaseBillCryoFormCount	--1/17/03 drh
		FROM _ReferralProdReport.dbo.Referral
		JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID
		JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = _ReferralProdReport.dbo.Call.CallID
		WHERE DATEPART(yyyy, CallDateTime) = @YearID
		AND DATEPART(m, CallDateTime) =  @MonthID
		ORDER BY ReferralCallerOrganizationID, SourceCodeID, ReferralID 

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- NoSecondaryOTE
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_FSCallCountSummary
	    SET      NoSecondaryOTE = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_FSCallCountSummarySelect
	    WHERE	ReferralTypeID = 1 		
	    AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	    AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	    AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2 		 
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2 	
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	
	--AND	(ReferralGeneralConsent = -1 OR ReferralGeneralConsent IS NULL)
	--AND	(ReferralApproachTypeID = -1 OR ReferralApproachTypeID = 7)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3 	
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4 		 
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4 		 
		OR
		ReferralTypeID = 3)
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID > 1
	AND	ReferralTissueAppropriateID > 1
	AND	ReferralSkinAppropriateID > 1
	AND	ReferralValvesAppropriateID > 1
	AND	ReferralEyesRschAppropriateID = 1	
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3
	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3	
	AND	ReferralEyesRschAppropriateID <> 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
--**************************************************************************************************************************************************************************************
	-- SecondaryOTE
--***************************************************************************************************************************************************************************************

	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1

	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
--**************************************************************************************************************************************************************************************
	-- SecondaryTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- SecondaryTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND 	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- SecondaryEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable

	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- SecondaryOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS 	CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- SecondaryOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1	
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS 	CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID



--**************************************************************************************************************************************************************************************
	-- SecondaryAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3
	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- SecondaryMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      SecondaryMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
        AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND	(ReferralGeneralConsent = 3)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
      	AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3
	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)		
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	
	AND	ReferralEyesRschAppropriateID <> 1
			
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- MedSocTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- MedSocEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID



--**************************************************************************************************************************************************************************************
	-- MedSocAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3

	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
        AND (FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	--AND	(ReferralGeneralConsent = 3)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
      	AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3
	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)		
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	
	AND	ReferralEyesRschAppropriateID <> 1
			
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- CryolifeFormOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- CryolifeFormTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  

	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID



--**************************************************************************************************************************************************************************************
	-- CryolifeFormAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3

	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- FamilyApproachOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOTECount = CountTable.ReferralCount
	FROM	
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
        AND (FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)	
	--AND	(ReferralGeneralConsent = 3)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
      	AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)		
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)	
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3
	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
        AND 	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)		
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	
	AND	ReferralEyesRschAppropriateID <> 1
			
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- MedSocOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- MedSocTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID



--**************************************************************************************************************************************************************************************
	-- MedSocAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3

	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID

	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- MedSocMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      MedSocMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- CryolifeFormOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- CryolifeFormTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormTECount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganAppropriateID <>1 
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID



--**************************************************************************************************************************************************************************************
	-- CryolifeFormAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND	ReferralBoneAppropriateID <> 4
	AND	ReferralBoneAppropriateID <> 3
	AND	ReferralTissueAppropriateID <> 4
	AND	ReferralTissueAppropriateID <> 3

	AND	ReferralSkinAppropriateID <> 4
	AND	ReferralSkinAppropriateID <> 3
	AND	ReferralValvesAppropriateID <> 4
	AND	ReferralValvesAppropriateID <> 3
	AND	ReferralEyesTransAppropriateID <> 4
	AND	ReferralEyesTransAppropriateID <> 3
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	##_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND     (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND	(ReferralBoneAppropriateID = 4
	OR 	ReferralBoneAppropriateID = 3
	OR	ReferralTissueAppropriateID = 4
	OR	ReferralTissueAppropriateID = 3
	OR	ReferralSkinAppropriateID = 4
	OR	ReferralSkinAppropriateID = 3
	OR	ReferralValvesAppropriateID = 4
	OR	ReferralValvesAppropriateID = 3
	OR	ReferralEyesTransAppropriateID = 4
	OR	ReferralEyesTransAppropriateID = 3)
	AND	ReferralEyesRschAppropriateID <> 1

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_FSCallCountSummary
	WHERE 	YearID = @YearID
	AND	MonthID = @MonthID


	--Update the count statistics
	INSERT INTO Referral_FSCallCountSummary
	SELECT * FROM ##_Temp_Referral_FSCallCountSummary 
	ORDER BY YearID, MonthID, OrganizationID, SourceCodeID
        
	DROP TABLE ##_Temp_Referral_FSCallCountSummarySelect             
	DROP TABLE ##_Temp_Referral_FSCallCountSummary
return 0





























GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

