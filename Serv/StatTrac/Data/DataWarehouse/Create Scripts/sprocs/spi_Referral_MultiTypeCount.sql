SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_MultiTypeCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_MultiTypeCount]
GO








CREATE PROCEDURE spi_Referral_MultiTypeCount
   @MonthID	int,
   @YearID	int

AS

/*
	Stored Procedure:	spi_Referral_MultiTypeCount
	Developer:		Bret Knoll
	Date:			7/05/06
	Description:		Procedure creates counts for a referral Types listed below. 
				The originl development is for a one time run. If data is useful a new report can be developed.
				
				Total:	All Referrals with no filters

				OTE: 	Referrals with a ReferralType of 1 or Organ
	
				OT:	Referrals with a Referral Type of 1 or Organ/Tissue/Eye
					AND 	ReferralOrganAppropriateID is equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is not equal to 1 or Yes
					AND 	at least 1 of the Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, or ReferralValvesAppropriateID is equal to 1 or yes.
				
				OE:	Referrals with a Referral Type of 1 or Organ/Tissue/Eye
					AND 	ReferralOrganAppropriateID is equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is equal to 1 or Yes
					AND 	All Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, and ReferralValvesAppropriateID is not equal to 1 or yes.
				O:	Referrals with a Referral Type of 1 or Organ/Tissue/Eye
					AND 	ReferralOrganAppropriateID is equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is not equal to 1 or Yes
					AND 	All Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, and ReferralValvesAppropriateID is not equal to 1 or yes.

				Tissue: Referrals with a Referral Type of 2 or Tissue/Eye
					AND 	ReferralOrganAppropriateID  is not equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is not equal to 1 or Yes
					AND 	at least 1 of the Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, or ReferralValvesAppropriateID is equal to 1 or yes.

				TE:	Referrals with a Referral Type of 2 or Tissue/Eye
					AND 	ReferralOrganAppropriateID  is not equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is equal to 1 or Yes
					AND 	at least 1 of the Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, or ReferralValvesAppropriateID is equal to 1 or yes.

				Eye:	Referrals with a Referral Type of 3 or Eye		 
					AND 	ReferralOrganAppropriateID is not equal to 1 or Yes  
					AND 	ReferralEyesTransAppropriateID or Eyes is equal to 1 or Yes
					AND 	All Tissue types ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, and ReferralValvesAppropriateID is not equal to 1 or yes.

				AgeRO:  Referrals with a Referral Type equal to 4 or Ruleout
					AND ReferralEyesRschAppropriateID is not equal to 1 or Yes
					AND ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
						ReferralSkinAppropriateID, ReferralEyesTransAppropriateID 
						and ReferralValvesAppropriateID are not equal 3 or 4 (High Risk or Med RO)

				MedRO:	Referrals with a Referral Type equal to 4 or Ruleout
						AND ReferralEyesRschAppropriateID is not equal to 1 or Yes
						AND ReferralBoneAppropriateID, ReferralTissueAppropriateID, 
							ReferralSkinAppropriateID, ReferralEyesTransAppropriateID 
							and ReferralValvesAppropriateID are equal 3 or 4 (High Risk or Med RO)

				removed
					
				Other:	Referrals with a Referral Type of 4 or Ruleout
					AND ReferralEyesRschAppropriateID is equal to 1 or Yes
					AND all categories ReferralOrganAppropriateID, ReferralEyesTransAppropriateID,
					ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, 
						and ReferralValvesAppropriateID are not equal to 1 or yes

				OtherE:	Referrals with a Referral Type of 3 or 4 (Eye or Ruleout)
					AND ReferralEyesRschAppropriateID is equal to 1 or Yes
					AND ReferralEyesTransAppropriateID is equal to 1 or Yes
					AND ReferralOrganAppropriateID is not equal to 1 or Yes
					AND ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, 
						and ReferralValvesAppropriateID are greater to 1 or yes

	Test: spi_Referral_MultiTypeCount 1, 2006

		  	
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

--Create the temp table
CREATE TABLE ##_Temp_Referral_MultiTypeCount 
   	(
	[YearID] [int] ,
	[MonthID] [int] ,
	[OrganizationID] [int] ,
	[SourceCodeID] [int]  ,
	[Total] [smallint] DEFAULT 0 ,		-- TotalReferrals
	[OTE] [smallint] DEFAULT 0 ,		-- Organ/Tissue/Eye 
	[OT] [smallint] DEFAULT 0 ,		-- Organ/Tissue 
	[OE] [smallint] DEFAULT 0 ,		-- Organ/Eye 
	[O] [smallint] DEFAULT 0 ,		-- Organ 
	[Tissue] [smallint] DEFAULT 0 ,	-- Tissue
	[TE] [smallint] DEFAULT 0 ,		-- Tissue/Eye
	[Eye] [smallint] DEFAULT 0 ,		-- Eye Only
--	[Other] [smallint] DEFAULT 0 , 	-- Other
--	[OtherE] [smallint] DEFAULT 0 ,	-- Other/Eye 
	[AgeRO] [smallint] DEFAULT 0 , 	-- Age rule outs
	[MedRO] [smallint] DEFAULT 0 ,		-- Medical RO
	[RO] [smallint] DEFAULT 0		-- RO
	)
	--- [Message] [smallint] DEFAULT 0 , does not fit with messages. Use Referral_MessageCount


CREATE TABLE ##_Temp_Referral_MultiTypeCountSelect
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
	TRUNCATE TABLE ##_Temp_Referral_MultiTypeCount
      --Get the list of organizations

	INSERT ##_Temp_Referral_MultiTypeCount
	(YearID, MonthID, OrganizationID, SourceCodeID)

	SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,
	DATEPART(m, CallDateTime) AS MonthID,
	ReferralCallerOrganizationID,  
	_ReferralProdReport.dbo.Call.SourceCodeID
	
	FROM _ReferralProdReport.dbo.Call
	JOIN _ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID
	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN _ReferralProd_DataWarehouse.dbo.AgeRange ON _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID = _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID

	WHERE DATEPART(yyyy, CallDateTime) = @YearID
	AND DATEPART(m, CallDateTime) =   @MonthID
	ORDER BY ReferralCallerOrganizationID

        --Build a TempTable
            --Clean ##_Temp_Referral_MultiTypeCountSelect
               TRUNCATE TABLE ##_Temp_Referral_MultiTypeCountSelect
            --Insert Data into ##_Temp_Referral_MultiTypeCountSelect based on agerange, gender, month and year
		INSERT ##_Temp_Referral_MultiTypeCountSelect (ReferralCallerOrganizationID, SourceCodeID, ReferralID,
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
		ORDER BY ReferralCallerOrganizationID, SourceCodeID, ReferralID 

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- ALL
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_MultiTypeCount
	    SET      Total = ISNULL(CountTable.ReferralCount , 0)
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_MultiTypeCountSelect

          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- OTE
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_MultiTypeCount
	    SET      OTE = ISNULL(CountTable.ReferralCount , 0)
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_MultiTypeCountSelect
	    WHERE	ReferralTypeID = 1 		 
	    AND 	ReferralOrganAppropriateID = 1  
	    AND 	ReferralEyesTransAppropriateID = 1
	    AND 	( ReferralBoneAppropriateID = 1 

	    		OR ReferralTissueAppropriateID = 1
	    		OR ReferralSkinAppropriateID = 1
	    		OR ReferralValvesAppropriateID = 1) 		
	    --AND		ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye		   
	    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- OT
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_MultiTypeCount
	    SET      OT = ISNULL(CountTable.ReferralCount , 0)
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_MultiTypeCountSelect
	    WHERE	ReferralTypeID = 1 		 
	    AND 	ReferralOrganAppropriateID = 1  
	    AND 	ReferralEyesTransAppropriateID <>1
	    AND 	( ReferralBoneAppropriateID = 1 
	    		OR ReferralTissueAppropriateID = 1
	    		OR ReferralSkinAppropriateID = 1
	    		OR ReferralValvesAppropriateID = 1) 		
	    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- OE
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_MultiTypeCount
	    SET      OE = ISNULL(CountTable.ReferralCount , 0)
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_MultiTypeCountSelect
	    WHERE	ReferralTypeID = 1 		 
	    AND 	ReferralOrganAppropriateID = 1  
	    AND 	ReferralEyesTransAppropriateID = 1
	    AND		ReferralBoneAppropriateID <> 1
	    AND		ReferralTissueAppropriateID <> 1
	    AND		ReferralSkinAppropriateID <> 1
	    AND		ReferralValvesAppropriateID <> 1
	    --AND		ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye		   
    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- O
--***************************************************************************************************************************************************************************************
            UPDATE   ##_Temp_Referral_MultiTypeCount
	    SET      O = ISNULL(CountTable.ReferralCount , 0)
	    FROM		
	    (
            SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	             Count(ReferralID) AS ReferralCount
	    FROM     ##_Temp_Referral_MultiTypeCountSelect
	    WHERE	ReferralTypeID = 1 		 
	    AND 	ReferralOrganAppropriateID = 1  
	    AND 	ReferralEyesTransAppropriateID <> 1
	    AND		ReferralBoneAppropriateID <> 1
	    AND		ReferralTissueAppropriateID <> 1
	    AND		ReferralSkinAppropriateID <> 1
	    AND		ReferralValvesAppropriateID <> 1
	    --AND		ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye		   
    		
          GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	   ) AS CountTable
	   WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- Tissue
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      Tissue = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_MultiTypeCountSelect
	WHERE	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID <> 1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- TE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      TE = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_MultiTypeCountSelect
	WHERE	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 		

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- Eye
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      Eye = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_MultiTypeCountSelect
	WHERE	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	-- AND	ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
/*

removed
--**************************************************************************************************************************************************************************************
	-- Other
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      Other = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_MultiTypeCountSelect
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
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- OtherE
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      OtherE = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
	     Count(ReferralID) AS ReferralCount
	FROM     ##_Temp_Referral_MultiTypeCountSelect
	WHERE	(ReferralTypeID = 4 		 
		OR
		ReferralTypeID = 3)
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
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID
*/
--**************************************************************************************************************************************************************************************
	-- AgeRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      AgeRO = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_MultiTypeCountSelect
	WHERE	(ReferralOrganAppropriateID <> 1
	AND	ReferralBoneAppropriateID = 2
	AND	ReferralTissueAppropriateID = 2 
	AND	ReferralSkinAppropriateID = 2
	AND	ReferralValvesAppropriateID = 2
	AND	ReferralEyesTransAppropriateID = 2)
	--AND	ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye	

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- MedRO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      MedRO = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_MultiTypeCountSelect
	WHERE	(ReferralOrganAppropriateID <> 1
	AND 	ReferralBoneAppropriateID > 2
	AND	ReferralTissueAppropriateID > 2 
	AND	ReferralSkinAppropriateID > 2
	AND	ReferralValvesAppropriateID > 2
	AND	ReferralEyesTransAppropriateID > 2)
	-- AND	ReferralEyesRschAppropriateID <> 1	not looking at other considered ruleout, enable if using Other and Other/Eye 

	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- RO
--***************************************************************************************************************************************************************************************
	UPDATE   ##_Temp_Referral_MultiTypeCount
	SET      RO = ISNULL(CountTable.ReferralCount , 0)
	FROM		
	(
	SELECT   ReferralCallerOrganizationID, SourceCodeID,  
		Count(ReferralID) AS ReferralCount
	FROM	##_Temp_Referral_MultiTypeCountSelect
	WHERE	(ReferralOrganAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesTransAppropriateID <> 1)


	GROUP BY   ReferralCallerOrganizationID, SourceCodeID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		##_Temp_Referral_MultiTypeCount.SourceCodeID = CountTable.SourceCodeID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_MultiTypeCount
	WHERE 	YearID = @YearID
	AND	MonthID = @MonthID


	--Update the count statistics
	INSERT INTO Referral_MultiTypeCount
	SELECT * FROM ##_Temp_Referral_MultiTypeCount 
	ORDER BY YearID, MonthID, OrganizationID, SourceCodeID
        
	DROP TABLE ##_Temp_Referral_MultiTypeCountSelect             
	DROP TABLE ##_Temp_Referral_MultiTypeCount
return 0

















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

