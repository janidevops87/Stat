-- BillableCountRun Stored Procedure Manifest
-- spi_Referral_CallCountSummary_Archive
-- spi_Referral_FSCallCountSummary2_Archive
-- spi_Referral_MessageCountSummary_Archive

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_CallCountSummary_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_CallCountSummary_Archive]
GO







-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_CallCountSummary_Archive 2, 2005
CREATE    PROCEDURE spi_Referral_CallCountSummary_Archive
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
**		Name: spi_Referral_CallCountSummary_Archive
**		Desc: creates table data for billable report from archive data 
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
**      11/12/2010	ccarroll				Updated Archive sproc to latest version
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
	_ReferralProdArchive.dbo.Call.SourceCodeID
	
	FROM _ReferralProdArchive.dbo.Call
	JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID
	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID
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
		SELECT ReferralCallerOrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralID,
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
		FROM _ReferralProdArchive.dbo.Referral
		JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID
		JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID

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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_FSCallCountSummary2_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_FSCallCountSummary2_Archive]
GO




CREATE    PROCEDURE spi_Referral_FSCallCountSummary2_Archive
   @DayID   int, 	
   @MonthID	int,
   @YearID	int

AS
/******************************************************************************
**		File: 
**		Name: spi_Referral_FSCallCountSummary2_Archive
**		Desc: builds table to populate data for billable reports...this is a newer version of the previous two versions
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**		Run nightly to populate data warehouse db
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 3/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------    		-------------------------------------------
**      11/09/2006	ccarroll  - Added Billing counts for OTE Screening
**      11/12/2010	ccarroll  Updated Archive sproc to latest version
*******************************************************************************/
/* 
*/

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

IF (object_id ('tempdb.dbo.#_Temp_Referral_FSCallCountSummary') is not null)
BEGIN
	DROP TABLE 	#_Temp_Referral_FSCallCountSummary
END

--Create the temp table
CREATE TABLE #_Temp_Referral_FSCallCountSummary 
   (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[DayID] [int] NULL ,
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
	[SecondaryROTotal] [smallint] NULL DEFAULT(0),
	
	[FamilyApproachOTE] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTissue] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTE] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachEye] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachAgeRO] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachMedRO] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOther] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherEye] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachROTotal] [smallint] NULL DEFAULT(0),
	
	[MedSocOTE] [smallint] NULL DEFAULT(0) ,
	[MedSocTissue] [smallint] NULL DEFAULT(0) ,
	[MedSocTE] [smallint] NULL DEFAULT(0) ,
	[MedSocEye] [smallint] NULL DEFAULT(0) ,
	[MedSocAgeRO] [smallint] NULL DEFAULT(0) ,
	[MedSocMedRO] [smallint] NULL DEFAULT(0) ,
	[MedSocOther] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherEye] [smallint] NULL DEFAULT(0),
	[MedSocROTotal] [smallint] NULL DEFAULT(0),

	--1/17/03 drh
	[FamilyUnavailableOTE] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableTissue] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableTE] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableEye] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableAgeRO] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableMedRO] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableOther] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableOtherEye] [smallint] NULL DEFAULT(0) ,
	[FamilyUnavailableROTotal] [smallint] NULL DEFAULT(0),

	[CryolifeFormOTE] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTissue] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTE] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormEye] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormAgeRO] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormMedRO] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOther] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherEye] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormROTotal] [smallint] NULL DEFAULT(0),
	
	[FamilyApproachOTECount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTissueCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachTECount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachEyeCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachAgeROCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachMedROCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachOtherEyeCount] [smallint] NULL DEFAULT(0) ,
	[FamilyApproachROCountTotal] [smallint] NULL DEFAULT(0),
	
	[MedSocOTECount] [smallint] NULL DEFAULT(0) ,
	[MedSocTissueCount] [smallint] NULL DEFAULT(0) ,
	[MedSocTECount] [smallint] NULL DEFAULT(0) ,
	[MedSocEyeCount] [smallint] NULL DEFAULT(0) ,
	[MedSocAgeROCount] [smallint] NULL DEFAULT(0) ,
	[MedSocMedROCount] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherCount] [smallint] NULL DEFAULT(0) ,
	[MedSocOtherEyeCount] [smallint] NULL DEFAULT(0) ,
	[MedSocROCountTotal] [smallint] NULL DEFAULT(0),

	[CryolifeFormOTECount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTissueCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormTECount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormEyeCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormAgeROCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormMedROCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherCount] [smallint] NULL DEFAULT(0) ,
	[CryolifeFormOtherEyeCount] [smallint] NULL DEFAULT(0),
	[CryolifeFormROCountTotal] [smallint] NULL DEFAULT(0),

	--5/19/03 DEO
	[SecondaryApproachOTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachTissue] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachEye] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachAgeRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachMedRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachOther] [smallint] NULL DEFAULT(0) ,
	[SecondaryApproachOtherEye] [smallint] NULL DEFAULT(0) ,

	[SecondaryNoApproachOTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachTissue] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachTE] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachEye] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachAgeRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachMedRO] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachOther] [smallint] NULL DEFAULT(0) ,
	[SecondaryNoApproachOtherEye] [smallint] NULL DEFAULT(0) ,

	[NoSecondaryApproachOTE] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachTissue] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachTE] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachEye] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachAgeRO] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachMedRO] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachOther] [smallint] NULL DEFAULT(0) ,
	[NoSecondaryApproachOtherEye] [smallint] NULL DEFAULT(0) ,

	--ccarroll 11/09/2006 OTE Billing 
	[FSCaseBillOTE] [smallint] NULL DEFAULT(0) 

	)
IF (object_id ('tempdb.dbo.#_Temp_Referral_FSCallCountSummarySelect') is not null)
BEGIN
	DROP TABLE 	#_Temp_Referral_FSCallCountSummarySelect
END
CREATE TABLE #_Temp_Referral_FSCallCountSummarySelect
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
	[FSCaseBillCryoFormCount][int] NULL,
	
	--ccarroll 10/09/2006 Added Count for OTE billing
	[FSCaseBillOTECount][int] NULL

	--CallID                   INT,      	                                          
	--CallDateTime                    DATETIME
   )
	
--Store TimeZone CASE string
--exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--TRUNCATE TABLE #_Temp_Referral_AgeDemo
	TRUNCATE TABLE #_Temp_Referral_FSCallCountSummary
      --Get the list of organizations

	INSERT #_Temp_Referral_FSCallCountSummary
	(YearID, MonthID, DayID, OrganizationID, SourceCodeID)

	SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,
	DATEPART(m, CallDateTime) AS MonthID,
	DATEPART(d, CallDateTime) AS DayID,
	ReferralCallerOrganizationID,  
	c.SourceCodeID
	FROM _ReferralProdArchive.dbo.Call c
	JOIN _ReferralProdArchive.dbo.Referral r ON r.CallID = c.CallID
	JOIN _ReferralProdArchive.dbo.Organization ro ON ro.OrganizationID = r.ReferralCallerOrganizationID 
	JOIN _ReferralProdArchive.dbo.FSCase fsc ON fsc.CallID = c.CallID
	WHERE DATEPART(yyyy, CallDateTime) = @YearID
	AND DATEPART(m, CallDateTime) =   @MonthID
	AND DATEPART(d, CallDateTime) =   @DayID
	ORDER BY ReferralCallerOrganizationID

        --Build a TempTable
            --Clean #_Temp_Referral_FSCallCountSummarySelect
               TRUNCATE TABLE #_Temp_Referral_FSCallCountSummarySelect
            --Insert Data into #_Temp_Referral_FSCallCountSummarySelect based on agerange, gender, month and year
		INSERT #_Temp_Referral_FSCallCountSummarySelect (ReferralCallerOrganizationID, SourceCodeID, ReferralID,
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
		FSCaseBillFamUnavailUserID, FSCaseBillCryoFormUserID, FSCaseBillApproachCount, FSCaseBillMedSocCount, FSCaseBillCryoFormCount, 
		FSCaseBillOTECount)
		--1/17/03 drh
		SELECT ReferralCallerOrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralID,
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
		fsc.FSCaseBillFamUnavailUserID, fsc.FSCaseBillCryoFormUserID, fsc.FSCaseBillApproachCount, fsc.FSCaseBillMedSocCount, fsc.FSCaseBillCryoFormCount,	--1/17/03 drh
		fsc.FSCaseBillOTECount -- ccarroll 11/09/2006
		FROM _ReferralProdArchive.dbo.Referral
		JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID
		JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID
		JOIN _ReferralProdArchive.dbo.FSCase fsc ON fsc.CallID = _ReferralProdArchive.dbo.Call.CallID
		WHERE DATEPART(yyyy, CallDateTime) = @YearID
		AND DATEPART(m, CallDateTime) =  @MonthID
		AND DATEPART(d, CallDateTime) =  @DayID
		ORDER BY ReferralCallerOrganizationID, SourceCodeID, ReferralID 

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- NoSecondaryOTE
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_FSCallCountSummary
	    SET      NoSecondaryOTE = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_FSCallCountSummarySelect
	    WHERE	ReferralTypeID = 1 		
	    AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	    AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	    AND (FSCaseBillMedSocUserID IS NULL OR FSCaseBillMedSocUserID = 0)
	    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     #_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     #_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     #_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     #_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     #_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- NoSecondaryMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
--**************************************************************************************************************************************************************************************
	-- SecondaryOTE
--***************************************************************************************************************************************************************************************

	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	--AND ReferralOrganAppropriateID = 1 
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
--**************************************************************************************************************************************************************************************
	-- SecondaryTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID



--**************************************************************************************************************************************************************************************
	-- SecondaryAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryMedRO = CountTable.ReferralCount
	FROM		

	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
	
--**************************************************************************************************************************************************************************************
	-- SecondaryROTotal
	-- Added ROTotal due to new criteria jth 2/08
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryROTotal = CountTable.ReferralCount
	FROM		

	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND	(ReferralOrganAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1 
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesTransAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1)
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachOTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(ReferralOrganApproachID = 1)
    AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND	(ReferralGeneralConsent = 3)
	--AND ( ReferralOrganApproachID <> 3 
	AND	(ReferralBoneApproachID <> 3
	OR 	ReferralTissueApproachID <> 3
	OR 	ReferralValvesApproachID <> 3
	OR 	ReferralSkinApproachID <> 3
	OR 	ReferralEyesTransApproachID <> 3
	OR 	ReferralEyesRschApproachID <> 3) 
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
    --AND 	ReferralTypeID = 2		
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
    --AND		ReferralTypeID = 2    		
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND 	( ReferralBoneApproachID = 1 
	OR 		ReferralTissueApproachID = 1
	OR 		ReferralSkinApproachID = 1
	OR 		ReferralValvesApproachID = 1) 		
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
	--AND     ReferralTypeID = 3
   	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3)	
	--AND	 	ReferralEyesRschApproachID <> 3)
	--AND     ReferralTypeID = 4
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3)
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	--AND		(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	--AND 	(ReferralOrganApproachID <> 3
	--AND	 	ReferralBoneApproachID <> 3  
	--AND		ReferralTissueApproachID <> 3
	--AND		ReferralSkinApproachID <> 3
	--AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	--AND 	(ReferralOrganApproachID <> 3
	--AND	 	ReferralBoneApproachID <> 3  
	--AND		ReferralTissueApproachID <> 3
	--AND		ReferralSkinApproachID <> 3
	--AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
	
--**************************************************************************************************************************************************************************************
	-- FamilyApproachROTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachROTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
	AND	(ReferralOrganApproachID <> 1
	AND	ReferralBoneApproachID <> 1 
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesTransApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1)
					
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocOTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND     ReferralOrganConsentID = 1
	--AND	ReferralApproachTypeID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- MedSocTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- MedSocEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 3
	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 4
	        (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
		    (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID



--**************************************************************************************************************************************************************************************
	-- MedSocAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
		
--**************************************************************************************************************************************************************************************
	-- MedSocROTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocROTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID	
	AND		DayID   = @DayID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(ReferralOrganApproachID = 1)
	AND ((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
    OR ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
    --AND ( ReferralOrganApproachID = 3 
	AND	(ReferralBoneApproachID = 3
	OR 	ReferralTissueApproachID = 3
	OR 	ReferralValvesApproachID = 3
	OR 	ReferralEyesTransApproachID = 3
	OR 	ReferralEyesRschApproachID = 3))) 	
	--AND	(ReferralGeneralConsent = 3)
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR      ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID = 3
	OR	 	ReferralBoneApproachID = 3  
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3
	OR	 	ReferralEyesTransApproachID = 3	
	OR	 	ReferralEyesRschApproachID = 3)))
    --AND 	ReferralTypeID = 2		
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3
	OR	 	ReferralEyesRschApproachID = 3)))
	--AND		ReferralTypeID = 2		
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	--OR 		ReferralEyesTransApproachID = 3
	OR	 	ReferralEyesRschApproachID = 3)))
	--AND ReferralTypeID = 3		
	AND ReferralOrganApproachID <>1  
	AND ReferralEyesTransApproachID =1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1	
	
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3)))
	--OR	 	ReferralEyesRschApproachID = 3)))
	--AND     ReferralTypeID = 4
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3))) 
	--OR 		ReferralEyesTransApproachID = 3
	--OR	 	ReferralEyesRschApproachID = 3)))
	--AND		(ReferralTypeID = 4 	OR 		ReferralTypeID = 3)
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	--OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND 	(ReferralOrganAppropriateID = 3  
	--OR	 	ReferralBoneApproachID = 3 
	--OR 		ReferralTissueApproachID = 3
	--OR 		ReferralSkinApproachID = 3
	--OR 		ReferralValvesApproachID = 3 
	--OR 		ReferralEyesTransApproachID = 3
	--OR	 	ReferralEyesRschApproachID = 3)))
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	--OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND 	(ReferralOrganAppropriateID = 3  
	--OR	 	ReferralBoneApproachID = 3 
	--OR 		ReferralTissueApproachID = 3
	--OR 		ReferralSkinApproachID = 3
	--OR 		ReferralValvesApproachID = 3 
	--OR 		ReferralEyesTransApproachID = 3
	--OR	 	ReferralEyesRschApproachID = 3)))
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyUnavailableROTotal
	-- Added ROTotal due to new criteria jth 2/08
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyUnavailableROTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR      ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID = 3
	OR	 	ReferralBoneApproachID = 3  
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3
	OR	 	ReferralEyesTransApproachID = 3	
	OR	 	ReferralEyesRschApproachID = 3)))
	AND	(ReferralOrganApproachID <> 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesTransApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1)
			
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- CryolifeFormOTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND		ReferralOrganConsentID = 1
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- CryolifeFormTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  

	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 3
	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 4
	        (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--(ReferralTypeID = 4 OR ReferralTypeID = 3)
		    (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
	



--**************************************************************************************************************************************************************************************
	-- CryolifeFormAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- CryolifeFormROTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormROTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID	
	
	

--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- FamilyApproachOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOTECount = CountTable.ReferralCount
	FROM	
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(ReferralOrganApproachID = 1)
	AND (FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)	
	AND ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND ( ReferralOrganApproachID <> 3 
	AND	(ReferralBoneApproachID <> 3
	OR 	ReferralTissueApproachID <> 3
	OR 	ReferralValvesApproachID <> 3
	OR 	ReferralSkinApproachID <> 3
	OR 	ReferralEyesTransApproachID <> 3
	OR 	ReferralEyesRschApproachID <> 3))  
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	((FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)	
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3))
    --AND 	ReferralTypeID = 2		
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)		
	--AND		ReferralTypeID = 2
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 		
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
	--AND		ReferralTypeID = 3
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3)	
	--AND	 	ReferralEyesRschApproachID <> 3)
	--AND		ReferralTypeID = 4
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3)
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	--AND		(ReferralTypeID = 4 OR 	ReferralTypeID = 3)
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	--AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND 	(ReferralOrganApproachID <> 3
	--AND	 	ReferralBoneApproachID <> 3  
	--AND		ReferralTissueApproachID <> 3
	--AND		ReferralSkinApproachID <> 3
	--AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- FamilyApproachMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	--AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	--AND 	(ReferralOrganApproachID <> 3
	--AND	 	ReferralBoneApproachID <> 3  
	--AND		ReferralTissueApproachID <> 3
	--AND		ReferralSkinApproachID <> 3
	--AND		ReferralValvesApproachID <> 3
	--AND	 	ReferralEyesTransApproachID <> 3	
	--AND	 	ReferralEyesRschApproachID <> 3)
	AND		ReferralTypeID = 4
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FamilyApproachROCountTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FamilyApproachROCountTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillApproachCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillApproachCount IS NOT NULL AND FSCaseBillApproachCount <> 0)
	AND		(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)	
	AND	(ReferralOrganApproachID <> 1
	AND	ReferralBoneApproachID <> 1 
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesTransApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1)
			
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID	




--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- MedSocOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND     ReferralOrganConsentID = 1
	--AND	ReferralApproachTypeID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- MedSocTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 3
	(FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 4
	        (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--(ReferralTypeID = 4 OR ReferralTypeID = 3)
	        (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID



--**************************************************************************************************************************************************************************************
	-- MedSocAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- MedSocMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID
	
--**************************************************************************************************************************************************************************************
	-- MedSocROCountTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      MedSocROCountTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillMedSocCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 4
    (FSCaseBillMedSocCount IS NOT NULL AND FSCaseBillMedSocCount <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--1/17/03 drh
--**************************************************************************************************************************************************************************************
	-- CryolifeFormOTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 1
	(FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID = 1 
	--AND	ReferralApproachTypeID = 1	


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- CryolifeFormTissueCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTissueCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormTECount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormTECount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 2
	(FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 		


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 3
	(FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--ReferralTypeID = 4
	        (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormOtherEyeCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormOtherEyeCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	--(ReferralTypeID = 4 OR ReferralTypeID = 3)
	        (FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID



--**************************************************************************************************************************************************************************************
	-- CryolifeFormAgeROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormAgeROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormMedROCount
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormMedROCount = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- CryolifeFormROCountTotal
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      CryolifeFormROCountTotal = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID, 
		Sum(FSCaseBillCryoFormCount) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillCryoFormCount IS NOT NULL AND FSCaseBillCryoFormCount <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID	
	

--5/19/03 DEO
--**************************************************************************************************************************************************************************************
	-- SecondaryApproachOTE
--***************************************************************************************************************************************************************************************

	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryApproachTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryApproachTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND 	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryApproachEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryApproachOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- SecondaryApproachOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID



--**************************************************************************************************************************************************************************************
	-- SecondaryApproachAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryApproachMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryApproachMedRO = CountTable.ReferralCount
	FROM		

	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachOTE
--***************************************************************************************************************************************************************************************

	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND 	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- SecondaryNoApproachMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      SecondaryNoApproachMedRO = CountTable.ReferralCount
	FROM		

	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND (FSCaseBillApproachUserID IS NULL OR FSCaseBillApproachUserID = 0)
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachOTE
--***************************************************************************************************************************************************************************************

	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachOTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 1
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	
	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachTissue
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachTE = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 2
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 3
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachOther
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachOtherEye
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachOtherEye = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(ReferralTypeID = 4
		OR
		ReferralTypeID = 3
		)
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND	YearID = @YearID
	AND	MonthID = @MonthID
	AND	DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachAgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachAgeRO = CountTable.ReferralCount
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

--**************************************************************************************************************************************************************************************
	-- NoSecondaryApproachMedRO
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      NoSecondaryApproachMedRO = CountTable.ReferralCount
	FROM		

	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	ReferralTypeID = 4
	AND (FSCaseBillSecondaryUserID IS NULL OR FSCaseBillSecondaryUserID = 0)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
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
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- FSCaseBillOTE
--***************************************************************************************************************************************************************************************
	UPDATE   #_Temp_Referral_FSCallCountSummary
	SET      FSCaseBillOTE = CountTable.ReferralCount
	FROM	 	
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	#_Temp_Referral_FSCallCountSummarySelect
	WHERE	(FSCaseBillOTECount IS NOT NULL AND FSCaseBillOTECount <> 0)

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_FSCallCountSummary.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID


--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************



 -- Update table for DEO added columns 5/20/2003
/*
update  Referral_FSCallCountSummary
set SecondaryApproachOTE = #_Temp_Referral_FSCallCountSummary.SecondaryApproachOTE, 
SecondaryApproachTissue = #_Temp_Referral_FSCallCountSummary.SecondaryApproachTissue, 
SecondaryApproachTE = #_Temp_Referral_FSCallCountSummary.SecondaryApproachTE, 
SecondaryApproachEye = #_Temp_Referral_FSCallCountSummary.SecondaryApproachEye, 
SecondaryApproachAgeRO = #_Temp_Referral_FSCallCountSummary.SecondaryApproachAgeRO, 
SecondaryApproachMedRO = #_Temp_Referral_FSCallCountSummary.SecondaryApproachMedRO, 
SecondaryApproachOther = #_Temp_Referral_FSCallCountSummary.SecondaryApproachOther, 
SecondaryApproachOtherEye = #_Temp_Referral_FSCallCountSummary.SecondaryApproachOtherEye, 
SecondaryNoApproachOTE = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachOTE, 
SecondaryNoApproachTissue = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachTissue, 
SecondaryNoApproachTE = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachTE, 
SecondaryNoApproachEye = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachEye, 
SecondaryNoApproachAgeRO = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachAgeRO, 
SecondaryNoApproachMedRO = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachMedRO, 
SecondaryNoApproachOther = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachOther, 
SecondaryNoApproachOtherEye = #_Temp_Referral_FSCallCountSummary.SecondaryNoApproachOtherEye, 
NoSecondaryApproachOTE = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachOTE, 
NoSecondaryApproachTissue = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachTissue, 
NoSecondaryApproachTE = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachTE, 
NoSecondaryApproachEye = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachEye, 
NoSecondaryApproachAgeRO = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachAgeRO, 
NoSecondaryApproachMedRO = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachMedRO, 
NoSecondaryApproachOther = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachOther, 
NoSecondaryApproachOtherEye = #_Temp_Referral_FSCallCountSummary.NoSecondaryApproachOtherEye
FROM #_Temp_Referral_FSCallCountSummary
where Referral_FSCallCountSummary.YearID = #_Temp_Referral_FSCallCountSummary.YearID
AND Referral_FSCallCountSummary.MonthID = #_Temp_Referral_FSCallCountSummary.MonthID
AND Referral_FSCallCountSummary.OrganizationID = #_Temp_Referral_FSCallCountSummary.OrganizationID
AND Referral_FSCallCountSummary.SourceCodeID = #_Temp_Referral_FSCallCountSummary.SourceCodeID
*/


	-- Delete any records for the given month and year
	DELETE 	Referral_FSCallCountSummary
	WHERE 	YearID = @YearID
	AND		MonthID = @MonthID
	AND		DayID   = @DayID

	--Update the count statistics
	INSERT INTO Referral_FSCallCountSummary
	SELECT * FROM #_Temp_Referral_FSCallCountSummary 
	ORDER BY YearID, MonthID, DayID, OrganizationID, SourceCodeID


	DROP TABLE #_Temp_Referral_FSCallCountSummarySelect             
	DROP TABLE #_Temp_Referral_FSCallCountSummary
return 0








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_MessageCountSummary_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_MessageCountSummary_Archive]
GO



-- Updated w/tzCASE function 04.0700 [ttw]

CREATE PROCEDURE spi_Referral_MessageCountSummary_Archive
   @DayID	int, 	
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
   @strSelectLine	varchar(8000),
   @strSelectLine2	varchar(8000),
   @strTemp		varchar(2000)


   Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
/******************************************************************************
**		File: 
**		Name: spi_Referral_MessageCountSummary_Archive
**		Desc: insert proc to build message counts for billable report
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
**		Date: 03/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      11/12/2010	ccarroll  Updated Archive sproc to latest version
*******************************************************************************/

--Create the temp table
CREATE TABLE #_Temp_Referral_MessageCountSummary 
   (
   	[YearID] [int] NULL ,
   	[MonthID] [int] NULL  ,
   	[DayID] [int] NULL  ,
   	[OrganizationID] [int]  ,
   	[SourceCodeID] [int] NULL ,
	[TotalMessages] [smallint] DEFAULT(0) ,
	[TotalImports] [smallint] DEFAULT(0) 
   )

CREATE TABLE #_Temp_Referral_MessageCountSummarySelect
   (
	
	[OrganizationID][int] NULL, 
	[SourceCodeID] [int] NULL ,
	[MessageID][int] NULL, 
	[MessageTypeID] [int] NULL

   )
	
--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--TRUNCATE TABLE #_Temp_Referral_AgeDemo
	TRUNCATE TABLE #_Temp_Referral_MessageCountSummary
      --Get the list of organizations
	set @strSelectLine = 'INSERT #_Temp_Referral_MessageCountSummary'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, DayID, OrganizationID, SourceCodeID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, CallDateTime) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(d, CallDateTime) AS DayID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Message.OrganizationID, ' 
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID ' 

	set @strSelectLine = @strSelectLine + ' FROM _ReferralProdArchive.dbo.Message'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Message.CallID' 
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Message.OrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 07/29/2011 Added Join to TimeZone  
	
	set @strSelectLine2 = ' WHERE DATEPART(yyyy, CallDateTime) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, CallDateTime) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(d, CallDateTime) = ' + ltrim(str(@DayID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Message.OrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID '

	EXEC(@strSelectLine+@strSelectLine2)
--select @strSelectLine+@strSelectLine2



        --Build a TempTable
            --Clean #_Temp_Referral_MessageCountSummarySelect
               TRUNCATE TABLE #_Temp_Referral_MessageCountSummarySelect
            --Insert Data into #_Temp_Referral_MessageCountSummarySelect based on agerange, gender, month and year
		set @strSelectLine = 'INSERT #_Temp_Referral_MessageCountSummarySelect (OrganizationID,SourceCodeID,MessageID, MessageTypeID)'
		set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Message.OrganizationID,'
		set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID, ' 
		set @strSelectLine = @strSelectLine + ' MessageID, MessageTypeID'
		set @strSelectLine = @strSelectLine + ' FROM _ReferralProdArchive.dbo.Message'
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Message.CallID' 
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Message.OrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
		set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
		-- ccarroll 07/29/2011 Added Join to TimeZone  

		set @strSelectLine2 = ' WHERE DATEPART(yyyy, CallDateTime) = '+ltrim(str(@YearID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, CallDateTime) = ' + ltrim(str(@MonthID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(d, CallDateTime) = ' + ltrim(str(@DayID))
		set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Message.OrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID '

	EXEC(@strSelectLine+@strSelectLine2)
--select @strSelectLine+@strSelectLine2
	
	-- update the count stats


--**************************************************************************************************************************************************************************************
	-- TotalMessages
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_MessageCountSummary
	    SET      TotalMessages = CountTable.ReferralCount
	    FROM		
	    (
		SELECT 	OrganizationID, 
			SourceCodeID,
			Count(MessageID) AS  ReferralCount
		FROM 	#_Temp_Referral_MessageCountSummarySelect
		WHERE 	MessageTypeID <> 2 

		GROUP BY OrganizationID, SourceCodeID
	    
	   ) AS CountTable
	   WHERE	#_Temp_Referral_MessageCountSummary.OrganizationID = CountTable.OrganizationID
	   AND		#_Temp_Referral_MessageCountSummary.SourceCodeID  = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND		DayID = @DayID
	
--**************************************************************************************************************************************************************************************
	-- TotalImports
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_MessageCountSummary
	    SET      TotalImports = CountTable.ReferralCount
	    FROM		
	    (
		SELECT 	OrganizationID, 
			SourceCodeID,
			Count(MessageID) AS  ReferralCount
		FROM 	#_Temp_Referral_MessageCountSummarySelect
		WHERE 	MessageTypeID = 2 

		GROUP BY OrganizationID, SourceCodeID
	    
	   ) AS CountTable
	   WHERE	#_Temp_Referral_MessageCountSummary.OrganizationID = CountTable.OrganizationID
	   AND		#_Temp_Referral_MessageCountSummary.SourceCodeID  = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND		DayID = @DayID
	   

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_MessageCountSummary
	WHERE 	YearID = @YearID
	AND	MonthID = @MonthID
	AND		DayID = @DayID

	--Update the count statistics
	INSERT INTO Referral_MessageCountSummary
	SELECT * FROM #_Temp_Referral_MessageCountSummary 
	ORDER BY YearID, MonthID, DayID, OrganizationID, SourceCodeID
        
	DROP TABLE #_Temp_Referral_MessageCountSummarySelect             
	DROP TABLE #_Temp_Referral_MessageCountSummary


return 0



















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


