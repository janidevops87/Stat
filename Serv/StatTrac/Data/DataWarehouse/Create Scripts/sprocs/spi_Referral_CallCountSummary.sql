SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_CallCountSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_CallCountSummary]
GO







-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_CallCountSummary 2, 2005
CREATE    PROCEDURE spi_Referral_CallCountSummary
   @DayID   int,	
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

/******************************************************************************
**		File: 
**		Name: spi_Referral_CallCountSummary
**		Desc: creates table data for billable report
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 3/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/


--Create the temp table
CREATE TABLE ##_Temp_Referral_CallCountSummary 
   (
	[YearID] [int] ,
	[MonthID] [int] ,
	[DayID]  [int],
	[OrganizationID] [int] ,
	[SourceCodeID] [int]  ,
	[UnknownOTE] [smallint] NULL DEFAULT(0),
	[UnknownTissue] [smallint] NULL DEFAULT(0),
	[UnknownTE] [smallint] NULL DEFAULT(0),
	[UnknownEye] [smallint] NULL DEFAULT(0),
	[UnknownAgeRO] [smallint] NULL DEFAULT(0),
	[UnknownMedRO] [smallint] NULL DEFAULT(0),
	[UnknownOther] [smallint] NULL DEFAULT(0),
	[UnknownOtherEye] [smallint] NULL DEFAULT(0),
	[ConsentedOTE] [smallint] NULL DEFAULT(0),
	[ConsentedTissue] [smallint] NULL DEFAULT(0),
	[ConsentedTE] [smallint] NULL DEFAULT(0),
	[ConsentedEye] [smallint] NULL DEFAULT(0),
	[ConsentedAgeRO] [smallint] NULL DEFAULT(0),
	[ConsentedMedRO] [smallint] NULL DEFAULT(0),
	[ConsentedOther] [smallint] NULL DEFAULT(0),
	[ConsentedOtherEye] [smallint] NULL DEFAULT(0),
	[DeniedOTE] [smallint] NULL DEFAULT(0),
	[DeniedTissue] [smallint] NULL DEFAULT(0),
	[DeniedTE] [smallint] NULL DEFAULT(0),
	[DeniedEye] [smallint] NULL DEFAULT(0),
	[DeniedAgeRO] [smallint] NULL DEFAULT(0),
	[DeniedMedRO] [smallint] NULL DEFAULT(0),
	[DeniedOther] [smallint] NULL DEFAULT(0),
	[DeniedOtherEye] [smallint] NULL DEFAULT(0),
	[NotApprchOTE] [smallint] NULL DEFAULT(0),
	[NotApprchTissue] [smallint] NULL DEFAULT(0),
	[NotApprchTE] [smallint] NULL DEFAULT(0),
	[NotApprchEye] [smallint] NULL DEFAULT(0),
	[NotApprchAgeRO] [smallint] NULL DEFAULT(0),
	[NotApprchMedRO] [smallint] NULL DEFAULT(0),
	[NotApprchOther] [smallint] NULL DEFAULT(0),
	[NotApprchOtherEye] [smallint] NULL DEFAULT(0),
	[TotOTE] [int] NULL DEFAULT(0),
	[TotTissue] [int] NULL DEFAULT(0),
	[TotTE] [int] NULL DEFAULT(0),
	[TotEye] [int] NULL DEFAULT(0),
	[TotAgeRO] [int] NULL DEFAULT(0),
	[TotMedRO] [int] NULL DEFAULT(0),
	[TotOther] [int] NULL DEFAULT(0),
	[TotOtherEye] [int] NULL DEFAULT(0),
	[TotRO] [int] NULL DEFAULT(0)
	)

CREATE TABLE ##_Temp_Referral_CallCountSummarySelect
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
	[ReferralValvesConversionID] [int] NULL 
   )
	
--Store TimeZone CASE string
--exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--TRUNCATE TABLE ##_Temp_Referral_AgeDemo
	TRUNCATE TABLE ##_Temp_Referral_CallCountSummary
      --Get the list of organizations

	INSERT ##_Temp_Referral_CallCountSummary
	(YearID, MonthID, DayID, OrganizationID, SourceCodeID)

	SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,
	DATEPART(m, CallDateTime) AS MonthID,
	DATEPART(d, CallDateTime) AS DayID,
	ReferralCallerOrganizationID,  
	_ReferralProdReport.dbo.Call.SourceCodeID
	
	FROM _ReferralProdReport.dbo.Call
	JOIN _ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID
	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN _ReferralProd_DataWarehouse.dbo.AgeRange ON _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID = _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID

	WHERE DATEPART(yyyy, CallDateTime) = @YearID
	AND DATEPART(m, CallDateTime) =   @MonthID
	AND DATEPART(d, CallDateTime) =   @DayID
	ORDER BY ReferralCallerOrganizationID

        --Build a TempTable
            --Clean ##_Temp_Referral_CallCountSummarySelect
               TRUNCATE TABLE ##_Temp_Referral_CallCountSummarySelect
            --Insert Data into ##_Temp_Referral_CallCountSummarySelect based on agerange, gender, month and year
		INSERT ##_Temp_Referral_CallCountSummarySelect (ReferralCallerOrganizationID, SourceCodeID, ReferralID,
		ReferralTypeID, ReferralGeneralConsent, ReferralApproachTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID,
		ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID,
		ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID,
		ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID,
		ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID,
		ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID,
		ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID,
		ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID,
		ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, 
		ReferralValvesConsentID, ReferralValvesConversionID)
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
		ReferralValvesConsentID, ReferralValvesConversionID
		FROM _ReferralProdReport.dbo.Referral
		JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID
		JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

		WHERE DATEPART(yyyy, CallDateTime) = @YearID
		AND DATEPART(m, CallDateTime) =  @MonthID
		AND DATEPART(d, CallDateTime) =  @DayID
		ORDER BY ReferralCallerOrganizationID, SourceCodeID, ReferralID 

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- UnknownOTE
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_CallCountSummary
	    SET      UnknownOTE = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_CallCountSummarySelect
	    WHERE	ReferralTypeID = 1 		 
	    AND	(isnull(ReferralGeneralConsent,-1) = -1)
	    --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	    AND	(isnull(ReferralApproachTypeID,-1) <> 1)
	    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND      DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- UnknownTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2 		 
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- UnknownTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2 		 
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- UnknownEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 3 		 
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- UnknownOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4 		 
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- UnknownOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_CallCountSummarySelect
	WHERE	(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- UnknownAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(isnull(ReferralGeneralConsent,-1) = -1 )
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- UnknownMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      UnknownMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(isnull(ReferralGeneralConsent,-1) = -1)
        --bjk replacing line AND	(isnull(ReferralApproachTypeID,-1) = -1 OR ReferralApproachTypeID = 7)
	AND	(isnull(ReferralApproachTypeID,-1) <> 1)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
--**************************************************************************************************************************************************************************************
	-- ConsentedOTE
--***************************************************************************************************************************************************************************************

	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
--**************************************************************************************************************************************************************************************
	-- ConsentedTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- ConsentedTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- ConsentedEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- ConsentedOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- ConsentedOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND DayID = @DayID



--**************************************************************************************************************************************************************************************
	-- ConsentedAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- ConsentedMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      ConsentedMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 1 OR ReferralGeneralConsent = 2)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- DeniedOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND	(ReferralGeneralConsent = 3)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- DeniedTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	(ReferralGeneralConsent = 3)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- DeniedTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	(ReferralGeneralConsent = 3)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- DeniedEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND	(ReferralGeneralConsent = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- DeniedOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- DeniedOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
	AND	(ReferralGeneralConsent = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- DeniedAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- DeniedMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      DeniedMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	(ReferralGeneralConsent = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchOTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND	ReferralApproachTypeID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID


--**************************************************************************************************************************************************************************************
	-- NotApprchTissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	ReferralApproachTypeID = 1	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchTE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND	ReferralApproachTypeID = 1	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND	ReferralApproachTypeID = 1	
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
	AND	##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchOther
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	ReferralApproachTypeID = 1	
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
	AND	ReferralApproachTypeID = 1	
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID



--**************************************************************************************************************************************************************************************
	-- NotApprchAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	ReferralApproachTypeID = 1	
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- NotApprchMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_CallCountSummary
	SET      NotApprchMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND	ReferralApproachTypeID = 1	
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID

--**************************************************************************************************************************************************************************************
	-- Do Totals here - 1/08 jth
--***************************************************************************************************************************************************************************************
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 1
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 3
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
	AND	##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
	UPDATE  ##_Temp_Referral_CallCountSummary
	SET     TotOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	ReferralTypeID = 4
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
UPDATE   ##_Temp_Referral_CallCountSummary
	SET      TotOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_CallCountSummarySelect
	WHERE	(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
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
	AND		##_Temp_Referral_CallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND     DayID = @DayID
	
UPDATE   ##_Temp_Referral_CallCountSummary
	SET     TotRO = TotMedRO + TotAgeRO
	WHERE	YearID = @YearID
	AND		MonthID = @MonthID	
	AND     DayID = @DayID
--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_CallCountSummary
	WHERE 	YearID = @YearID
	AND	MonthID = @MonthID
	AND     DayID = @DayID


	--Update the count statistics
	INSERT INTO Referral_CallCountSummary
	SELECT * FROM ##_Temp_Referral_CallCountSummary 
	ORDER BY YearID, MonthID, DayID, OrganizationID, SourceCodeID
        
	DROP TABLE ##_Temp_Referral_CallCountSummarySelect             
	DROP TABLE ##_Temp_Referral_CallCountSummary
return 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

