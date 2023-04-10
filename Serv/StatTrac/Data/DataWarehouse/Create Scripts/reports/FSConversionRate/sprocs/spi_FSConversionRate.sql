if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_FSConversionRate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_FSConversionRate]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE spi_Referral_FSConversionRate 
	@MonthID INT,
	@YearID  INT
	
AS

SET NOCOUNT ON

-- Create a variable table of hours in a day
DECLARE @LoopCount	INT,
	@LoopCount2	INT,
	@MaxDay		INT,
	@DayID		INT,
	@sql1		VARCHAR(8000),
	@sql2		VARCHAR(8000),
	@sql3		VARCHAR(8000)
	
-- fill #_Temp_FSReferral_TypeCount with shell data (YearID, MonthID, DayID, HourID, SourceCodeID, StatEmployeeID)
-- build template for a givenmonth containing YearID, MonthID, HourID
-- for each SourceCode and EmployeeID insert the template
--************************************************************************************************************
-- 
--	START OF SECTION TO FILL @_Temp_FSReferral_ConversionRate WITH SHELL DATA
--	
--************************************************************************************************************
	DECLARE @_Temp_FSReferral_ConversionRate TABLE
		(
			[YearID] [int] NOT NULL ,
			[MonthID] [int] NOT NULL , 
			--, [DayID] [int] NOT NULL ,
			--[HourID] [int] NOT NULL ,
			[OrganizationID][int] NOT NULL,
			[SourceCodeID] [int] NOT NULL ,
			[StatEmployeeID] [int] NOT NULL ,
			[TotalReferralsCount] [int] NULL, 
			[TotalAppropriateCount] [int] NULL,			
			[TotalFamilyApproachCount] [int] NULL ,
			[TotalWrittenConsentCount] [int] NULL, 
			[TotalRecoveredCount] [int] NULL ,
			
			[TotalROCount] [int] NULL ,
				
			[BoneAppropriateCount] [int] NULL , 
			[BoneFamilyApproachCount] [int] NULL ,
			[BoneWrittenConsentCount] [int] NULL,
			[BoneRecoveredCount] [int] NULL, 

			[SkinAppropriateCount] [int] NULL , 
			[SkinFamilyApproachCount] [int] NULL ,
			[SkinWrittenConsentCount] [int] NULL,
			[SkinRecoveredCount] [int] NULL, 

			[HeartValvesAppropriateCount] [int] NULL , 
			[HeartValvesFamilyApproachCount] [int] NULL ,
			[HeartValvesWrittenConsentCount] [int] NULL,
			[HeartValvesRecoveredCount] [int] NULL, 

			[EyesAppropriateCount] [int] NULL , 
			[EyesFamilyApproachCount] [int] NULL ,
			[EyesWrittenConsentCount] [int] NULL,
			[EyesRecoveredCount] [int] NULL,

			[BoneCnrROCount] [int] NULL, 
			[SkinCnrROCount] [int] NULL, 
			[EyesCnrROCount] [int] NULL,
			[HeartCnrROCount] [int] NULL, 

			[BoneNBDCount] [int] NULL, 
			[SkinNBDCount] [int] NULL, 
			[EyesNBDCount] [int] NULL,
			[HeartNBDCount] [int] NULL, 

			[BoneMROCount] [int] NULL, 
			[SkinMROCount] [int] NULL, 
			[EyesMROCount] [int] NULL,
			[HeartMROCount] [int] NULL, 

			[BoneHighRiskCount] [int] NULL, 
			[SkinHighRiskCount] [int] NULL, 
			[EyesHighRiskCount] [int] NULL,
			[HeartHighRiskCount] [int] NULL, 

			[BoneLogisticsCount] [int] NULL, 
			[SkinLogisticsCount] [int] NULL, 
			[EyesLogisticsCount] [int] NULL,
			[HeartLogisticsCount] [int] NULL, 

			[BoneHrtTxablCount] [int] NULL, 
			[SkinHrtTxablCount] [int] NULL, 
			[EyesHrtTxablCount] [int] NULL,
			[HeartHrtTxablCount] [int] NULL, 

			[BoneUnKnownCount] [int] NULL, 
			[SkinUnKnownCount] [int] NULL, 
			[EyesUnKnownCount] [int] NULL,
			[HeartUnKnownCount] [int] NULL, 

			[BoneFamilyROCount] [int] NULL, 
			[SkinFamilyROCount] [int] NULL, 
			[EyesFamilyROCount] [int] NULL,
			[HeartFamilyROCount] [int] NULL, 

			[BoneNtRecvrdCount] [int] NULL, 
			[SkinNtRecvrdCount] [int] NULL, 
			[EyesNtRecvrdCount] [int] NULL, 
			[HeartNtRecvrdCount] [int] NULL,
			
			-- NA is Not Available the field was not filled in
			[BoneNACount] [int] NULL, 
			[SkinNACount] [int] NULL, 
			[EyesNACount] [int] NULL, 
			[HeartNACount] [int] NULL
					
		)
	-- fill the employees table use a union to obtain a distinct list of all fields 
	-- used with statemployeid
	INSERT @_Temp_FSReferral_ConversionRate
				(YearID , 
				MonthID , 
				OrganizationID ,
				SourceCodeID , 
				StatEmployeeID)	
		-- Who All Referrals and Appropriate
		SELECT DISTINCT @YearID, @MonthID, r.ReferralCallerOrganizationID, c.SourceCodeID, c.StatEmployeeID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 

		UNION
		-- Who Secondary Approach By
		SELECT DISTINCT @YearID, @MonthID, r.ReferralCallerOrganizationID, c.SourceCodeID, sea.StatEmployeeID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		LEFT 
		JOIN 
			_ReferralProdReport.dbo.SecondaryApproach s ON s.CallID = c.CallID
		LEFT 
		JOIN 
			_ReferralProdReport.dbo.StatEmployee sea ON sea.personid = s.SecondaryApproachedBy
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(s.SecondaryApproachedBy , 0) > 0
		AND ISNULL(sea.StatEmployeeID, 0) <> 0

		UNION
		-- Who Secondary Consent By
		SELECT DISTINCT @YearID, @MonthID, r.ReferralCallerOrganizationID, c.SourceCodeID, sec.StatEmployeeID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		LEFT 
		JOIN 
			_ReferralProdReport.dbo.SecondaryApproach s ON s.CallID = c.CallID
		LEFT
		JOIN 
			_ReferralProdReport.dbo.StatEmployee sec ON sec.personid = s.SecondaryConsentBy  		
		WHERE DATEPART(YYYY , c.CallDateTime) = @YearID 
		AND DATEPART(M , c.CallDateTime) = @MonthID 
		AND ISNULL(s.SecondaryConsentBy , 0) > 0
		AND ISNULL(sec.StatEmployeeID, 0) <> 0
		
		UNION
		-- Who Finalized Case
		SELECT DISTINCT @YearID, @MonthID, r.ReferralCallerOrganizationID, c.SourceCodeID, fsc.FSCaseFinalUserID
		FROM _ReferralProdReport.dbo.Referral r
		JOIN _ReferralProdReport.dbo.Call c ON c.CallID = r.CallID
		JOIN _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID
		WHERE DATEPART(YYYY , fsc.FSCaseFinalDateTime) = @YearID 
		AND DATEPART(M , fsc.FSCaseFinalDateTime) = @MonthID 
		AND ISNULL(fsc.FSCaseFinalUserID , 0) > 0 
		ORDER BY 2,3,4
				
-- SELECT * FROM @_Temp_FSReferral_ConversionRate

	-- SELECT * FROM @_Temp_FSReferral_ConversionRate

--************************************************************************************************************
-- 
-- 	END OF SECTION TO FILL @_Temp_FSReferral_ConversionRate WITH SHELL DATA
-- 	
--************************************************************************************************************

DECLARE @_Temp_FSReferral_Select TABLE 
	(
		[CallID] [INT] ,
		[SourceCodeID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[FSCaseApproachDateTime] [DATETIME] NULL ,
		[FSCaseBillSecondaryUserID] [INT] NULL ,
		[FSCaseBillDateTime] [DATETIME] NULL ,
		[FSCaseBillApproachDateTime] [DATETIME] NULL ,
		[FSCaseBillApproachUserID] [INT] NULL ,
		[SumOfFSCaseBillApproachCount] [SMALLINT] NULL ,
		[FSCaseBillFamUnavailUserId] [INT] NULL , 
		[FSCaseBillFamUnavailDateTime] [DATETIME] NULL , 
		[FSCaseBillMedSocUserID] [INT] NULL ,
		[FSCaseBillMedSocDateTime] [DATETIME] NULL,
		[SecondaryApproached] [INT] NULL ,
		[SecondaryApproachReason] [INT] NULL ,
		[SecondaryApproachedBy] [INT] NULL ,		
		[SecondaryApproachOutcome] [INT] NULL ,		
		[SecondaryConsentBy] [INT] NULL,
		
		[ReferralCallerOrganizationID] [INT] NULL , 
		[CallStatEmployeeID] [INT] NULL , 
		[ReferralOrganAppropriateID] [INT] NULL , 
		[ReferralBoneAppropriateID] [INT] NULL , 
		[ReferralTissueAppropriateID] [INT] NULL , 
		[ReferralSkinAppropriateID] [INT] NULL , 
		[ReferralEyesTransAppropriateID] [INT] NULL , 
		[ReferralEyesRschAppropriateID] [INT] NULL , 
		[ReferralValvesAppropriateID] [INT] NULL , 
		[ReferralOrganConversionID] [INT] NULL , 
		[ReferralBoneConversionID] [INT] NULL , 
		[ReferralTissueConversionID] [INT] NULL , 
		[ReferralSkinConversionID] [INT] NULL , 
		[ReferralEyesTransConversionID] [INT] NULL , 
		[ReferralEyesRschConversionID] [INT] NULL , 
		[ReferralValvesConversionID] [INT]  NULL ,
		[FSCASEFinalUserID] [INT] NULL , 
		[FSCaseFinalDateTime] [DATETIME] NULL 	 
	)


	--- insert all values for a month in to temp table @_Temp_FSReferral_Select
	INSERT @_Temp_FSReferral_Select
			(
				CallID , 
				SourceCodeID , 
				CallDateTime , 
				FSCaseApproachDateTime ,
				FSCaseBillSecondaryUserID , 
				FSCaseBillDateTime , 
				FSCaseBillApproachUserID , 
				FSCaseBillApproachDateTime , 
				SumOfFSCaseBillApproachCount , 
				FSCaseBillFamUnavailUserId , 
				FSCaseBillFamUnavailDateTime , 
				FSCaseBillMedSocUserID , 
				FSCaseBillMedSocDateTime , 
				SecondaryApproached , 
				SecondaryApproachReason , 
				SecondaryApproachedBy , 
				SecondaryApproachOutcome , 
				SecondaryConsentBy,				
				ReferralCallerOrganizationID,				
				CallStatEmployeeID ,
				ReferralOrganAppropriateID , 
				ReferralBoneAppropriateID , 
				ReferralTissueAppropriateID , 
				ReferralSkinAppropriateID , 
				ReferralEyesTransAppropriateID , 
				ReferralEyesRschAppropriateID , 
				ReferralValvesAppropriateID , 
				ReferralOrganConversionID , 
				ReferralBoneConversionID , 
				ReferralTissueConversionID , 
				ReferralSkinConversionID , 
				ReferralEyesTransConversionID , 
				ReferralEyesRschConversionID , 
				ReferralValvesConversionID , 
				FSCASEFinalUserID ,
				FSCaseFinalDateTime
				 
			)							  
	SELECT	
				c.CallID , 
				c.SourceCodeID , 
				c.CallDateTime , 
				fsc.FSCaseApproachDateTime ,
				fsc.FSCaseBillSecondaryUserID , 
				fsc.FSCaseBillDateTime , 
				fsc.FSCaseBillApproachUserID , 
				fsc.FSCaseBillApproachDateTime , 
				fsc.FSCaseBillApproachCount , 
				fsc.FSCaseBillFamUnavailUserId , 
				fsc.FSCaseBillFamUnavailDateTime , 
				fsc.FSCaseBillMedSocUserID , 
				fsc.FSCaseBillMedSocDateTime , 
				s.SecondaryApproached , 
				s.SecondaryApproachReason , 
				sea.StatEmployeeID , 
				s.SecondaryApproachOutcome , 
				sec.StatEmployeeID ,		
				r.ReferralCallerOrganizationID ,				
				c.StatEmployeeID ,
				r.ReferralOrganAppropriateID , 
				r.ReferralBoneAppropriateID , 
				r.ReferralTissueAppropriateID , 
				r.ReferralSkinAppropriateID , 
				r.ReferralEyesTransAppropriateID , 
				r.ReferralEyesRschAppropriateID , 
				r.ReferralValvesAppropriateID , 
				r.ReferralOrganConversionID , 
				r.ReferralBoneConversionID , 
				r.ReferralTissueConversionID , 
				r.ReferralSkinConversionID , 
				r.ReferralEyesTransConversionID , 
				r.ReferralEyesRschConversionID , 
				r.ReferralValvesConversionID , 
				fsc.FSCASEFinalUserID,
				fsc.FSCaseFinalDateTime
			FROM _ReferralProdReport.dbo.Call c 
			JOIN _ReferralProdReport.dbo.Referral r ON r.CallID = c.CallID 
			LEFT
			JOIN
				 _ReferralProdReport.dbo.FSCase fsc ON fsc.CallID = c.CallID 
			LEFT
			JOIN 
				_ReferralProdReport.dbo.SecondaryApproach s ON  s.CallID = c.CallID 
			
			LEFT 
			JOIN 
				_ReferralProdReport.dbo.StatEmployee sea ON sea.personid = s.SecondaryApproachedBy
			LEFT
			JOIN 
				_ReferralProdReport.dbo.StatEmployee sec ON sec.personid = s.SecondaryConsentBy  

	
	WHERE 
		DATEPART(yyyy , c.CallDateTime) = ltrim(str(@YearID))
	AND 
		DATEPART(m , c.CallDateTime) = ltrim(str(@MonthID))
	ORDER BY 
		s.CallID
--***************************************************************************************************************************************************************************************	
-- 
-- 	[TotalReferralsCount]  
-- 
--  **************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	TotalReferralsCount = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	
	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************	
-- 
-- 	[TotalAppropriateCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[TotalAppropriateCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		ReferralOrganAppropriateID = 1 OR 
		ReferralBoneAppropriateID = 1 OR 
		ReferralTissueAppropriateID = 1 OR 
		ReferralSkinAppropriateID = 1 OR 
		ReferralEyesTransAppropriateID = 1 OR 
		ReferralEyesRschAppropriateID = 1 OR 
		ReferralValvesAppropriateID = 1 

	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[TotalFamilyApproachCount] [int] NOT NULL , 
-- SecondaryApproached = 1
-- 1.1.2.1.2.	SecondaryApproachBy
-- 1.1.2.1.3.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[TotalFamilyApproachCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralOrganAppropriateID = 1 OR 
		ReferralBoneAppropriateID = 1 OR 
		ReferralTissueAppropriateID = 1 OR 
		ReferralSkinAppropriateID = 1 OR 
		ReferralEyesTransAppropriateID = 1 OR 
		ReferralEyesRschAppropriateID = 1 OR 
		ReferralValvesAppropriateID = 1 
		)
		AND SecondaryApproached = 1
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryApproachedBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************		
-- 
-- 		[TotalWrittenConsentCount] [int] NOT NULL,  
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- 1.1.5.1.3.	SecondaryConsentBy
-- 1.1.5.1.4.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[TotalWrittenConsentCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralOrganAppropriateID = 1 OR 
		ReferralBoneAppropriateID = 1 OR 
		ReferralTissueAppropriateID = 1 OR 
		ReferralSkinAppropriateID = 1 OR 
		ReferralEyesTransAppropriateID = 1 OR 
		ReferralEyesRschAppropriateID = 1 OR 
		ReferralValvesAppropriateID = 1 
		)
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome  = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryConsentBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- 		[TotalRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = 1 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[TotalRecoveredCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		FSCaseFinalUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseFinalDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseFinalDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralOrganAppropriateID = 1 OR 
		ReferralBoneAppropriateID = 1 OR 
		ReferralTissueAppropriateID = 1 OR 
		ReferralSkinAppropriateID = 1 OR 
		ReferralEyesTransAppropriateID = 1 OR 
		ReferralEyesRschAppropriateID = 1 OR 
		ReferralValvesAppropriateID = 1 
		)
	AND
		(
		ReferralOrganConversionID = 1 OR 
		ReferralBoneConversionID = 1 OR 
		ReferralTissueConversionID = 1 OR 
		ReferralSkinConversionID = 1 OR 
		ReferralEyesTransConversionID = 1 OR 
		ReferralEyesRschConversionID = 1 OR 
		ReferralValvesConversionID = 1  
		)		
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseFinalDateTime ), 
		DATEPART( M , FSCaseFinalDateTime ),  
		SourceCodeID,  
		FSCaseFinalUserID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

/* Bone Section Start */
--***************************************************************************************************************************************************************************************	
-- 
-- 	[BoneAppropriateCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[BoneAppropriateCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		ReferralBoneAppropriateID = 1
	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[BoneFamilyApproachCount] [int] NOT NULL , -- SecondaryApproached = 1
-- 1.1.2.1.2.	SecondaryApproachBy
-- 1.1.2.1.3.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[BoneFamilyApproachCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralBoneAppropriateID = 1 
		)
		AND SecondaryApproached = 1
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryApproachedBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************		
-- 
-- 		[BoneWrittenConsentCount] [int] NOT NULL,  
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- 1.1.5.1.3.	SecondaryConsentBy
-- 1.1.5.1.4.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[BoneWrittenConsentCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralBoneAppropriateID = 1 
		)
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome  = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryConsentBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- 		[BoneRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = 1 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[BoneRecoveredCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		FSCaseFinalUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseFinalDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseFinalDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralBoneAppropriateID = 1  
		)
	AND
		(
		ReferralBoneConversionID = 1   
		)		
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseFinalDateTime ), 
		DATEPART( M , FSCaseFinalDateTime ),  
		SourceCodeID,  
		FSCaseFinalUserID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

/* Bone Section End */

/* Skin Section Start */
--***************************************************************************************************************************************************************************************	
-- 
-- 	[SkinAppropriateCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[SkinAppropriateCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		ReferralSkinAppropriateID = 1

	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[SkinFamilyApproachCount] [int] NOT NULL , -- SecondaryApproached = 1
-- 1.1.2.1.2.	SecondaryApproachBy
-- 1.1.2.1.3.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[SkinFamilyApproachCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralSkinAppropriateID = 1 
		)
		AND SecondaryApproached = 1
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryApproachedBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************		
-- 
-- 		[SkinWrittenConsentCount] [int] NOT NULL,  
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- 1.1.5.1.3.	SecondaryConsentBy
-- 1.1.5.1.4.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[SkinWrittenConsentCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralSkinAppropriateID = 1  
		)
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome  = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryConsentBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- 		[SkinRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = 1 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[SkinRecoveredCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		FSCaseFinalUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseFinalDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseFinalDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralSkinAppropriateID = 1 
		)
	AND
		(
		ReferralSkinConversionID = 1 
		)		
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseFinalDateTime ), 
		DATEPART( M , FSCaseFinalDateTime ),  
		SourceCodeID,  
		FSCaseFinalUserID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID
/* Skin Section End */

/* Heart Valves Start */

--***************************************************************************************************************************************************************************************	
-- 
-- 	[HeartValvesAppropriateCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[HeartValvesAppropriateCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		ReferralValvesAppropriateID = 1 

	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[HeartValvesFamilyApproachCount] [int] NOT NULL , -- SecondaryApproached = 1
-- 1.1.2.1.2.	SecondaryApproachBy
-- 1.1.2.1.3.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[HeartValvesFamilyApproachCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralValvesAppropriateID = 1 
		)
		AND SecondaryApproached = 1
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryApproachedBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************		
-- 
-- 		[HeartValvesWrittenConsentCount] [int] NOT NULL,  
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- 1.1.5.1.3.	SecondaryConsentBy
-- 1.1.5.1.4.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[HeartValvesWrittenConsentCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralValvesAppropriateID = 1 
		)
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome  = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryConsentBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- 		[HeartValvesRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = 1 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[HeartValvesRecoveredCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		FSCaseFinalUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseFinalDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseFinalDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralValvesAppropriateID = 1 
		)
	AND
		(
		ReferralValvesConversionID = 1  
		)		
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseFinalDateTime ), 
		DATEPART( M , FSCaseFinalDateTime ),  
		SourceCodeID,  
		FSCaseFinalUserID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


/* Heart Valves End */

/* Eyes Start */
--***************************************************************************************************************************************************************************************	
-- 
-- 	[EyesAppropriateCount] 
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[EyesAppropriateCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		CallStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , CallDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , CallDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		ReferralEyesTransAppropriateID = 1

	GROUP BY   
		DATEPART( YYYY , CallDateTime ), 
		DATEPART( M , CallDateTime ),  
		SourceCodeID,  
		CallStatEmployeeID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--**************************************************************************************************************************************************************************************	
-- 
-- 	[EyesFamilyApproachCount] [int] NOT NULL , -- SecondaryApproached = 1
-- 1.1.2.1.2.	SecondaryApproachBy
-- 1.1.2.1.3.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[EyesFamilyApproachCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryApproachedBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralEyesTransAppropriateID = 1 
		)
		AND SecondaryApproached = 1
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryApproachedBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID


--***************************************************************************************************************************************************************************************		
-- 
-- 		[EyesWrittenConsentCount] [int] NOT NULL,  
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- 1.1.5.1.3.	SecondaryConsentBy
-- 1.1.5.1.4.	FSCaseApproachDateTime
-- Referral.XXXXXAppropriate any = 1
-- 
--**************************************************************************--************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[EyesWrittenConsentCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		SecondaryConsentBy AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseApproachDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseApproachDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralEyesTransAppropriateID = 1  
		)
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome  = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseApproachDateTime ), 
		DATEPART( M , FSCaseApproachDateTime ),  
		SourceCodeID,  
		SecondaryConsentBy, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- 		[EyesRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = 1 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	[EyesRecoveredCount] = CountTable.ReferralCount
	FROM		
	(
	SELECT	
		SourceCodeID AS CallSourceCodeID,
		FSCaseFinalUserID AS CallStatEmployeeID , -- StatEmployeeID different for every count
		ReferralCallerOrganizationID AS CallOrganizationID ,
		DATEPART( YYYY , FSCaseFinalDateTime ) AS CallYearID , 	-- YearID different for every count
		DATEPART( M , FSCaseFinalDateTime ) AS CallMonthID , 	-- MonthID different for every count
		Count(*) AS ReferralCount
	FROM	
		@_Temp_FSReferral_Select
	WHERE 
		(
		ReferralEyesTransAppropriateID = 1
		)
	AND
		(
		ReferralEyesTransConversionID = 1
		)		
		AND SecondaryApproached = 1
		AND SecondaryApproachOutcome = 2
	GROUP BY   
		DATEPART( YYYY , FSCaseFinalDateTime ), 
		DATEPART( M , FSCaseFinalDateTime ),  
		SourceCodeID,  
		FSCaseFinalUserID, 
		ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND		OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID

--***************************************************************************************************************************************************************************************		
-- 
-- [EyesRecoveredCount] [int] NOT NULL 
-- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
-- Referral.XXXXXAppropriate any = 1
-- Referral.XXXXRecovered any = > 
-- FSCase.FSCaseFinalUserID
-- FSCaseFinalDateTime
-- **************************************************************************************************************************************************************************************
/*
	*********************************************************************
	*********************************************************************
 */
	UPDATE	@_Temp_FSReferral_ConversionRate
	SET	
		BoneCnrROCount = CountTable.BoneCnrROCount, 
		SkinCnrROCount = CountTable.SkinCnrROCount, 
		EyesCnrROCount = CountTable.EyesCnrROCount, 
		HeartCnrROCount = CountTable.HeartCnrROCount, 
		BoneNBDCount = CountTable.BoneNBDCount, 
		SkinNBDCount = CountTable.SkinNBDCount, 
		EyesNBDCount = CountTable.EyesNBDCount, 
		HeartNBDCount = CountTable.HeartNBDCount, 
		BoneMROCount = CountTable.BoneMROCount, 
		SkinMROCount = CountTable.SkinMROCount, 
		EyesMROCount = CountTable.EyesMROCount, 
		HeartMROCount = CountTable.HeartMROCount, 
		BoneHighRiskCount = CountTable.BoneHighRiskCount, 
		SkinHighRiskCount = CountTable.SkinHighRiskCount, 
		EyesHighRiskCount = CountTable.EyesHighRiskCount, 
		HeartHighRiskCount = CountTable.HeartHighRiskCount, 
		BoneLogisticsCount = CountTable.BoneLogisticsCount, 
		SkinLogisticsCount = CountTable.SkinLogisticsCount, 
		EyesLogisticsCount = CountTable.EyesLogisticsCount, 
		HeartLogisticsCount = CountTable.HeartLogisticsCount, 
		BoneHrtTxablCount = CountTable.BoneHrtTxablCount, 
		SkinHrtTxablCount = CountTable.SkinHrtTxablCount, 
		EyesHrtTxablCount = CountTable.EyesHrtTxablCount, 
		HeartHrtTxablCount = CountTable.HeartHrtTxablCount, 
		BoneUnKnownCount = CountTable.BoneUnKnownCount, 
		SkinUnKnownCount = CountTable.SkinUnKnownCount, 
		EyesUnKnownCount = CountTable.EyesUnKnownCount, 
		HeartUnKnownCount = CountTable.HeartUnKnownCount, 
		BoneFamilyROCount = CountTable.BoneFamilyROCount, 
		SkinFamilyROCount = CountTable.SkinFamilyROCount, 
		EyesFamilyROCount = CountTable.EyesFamilyROCount, 
		HeartFamilyROCount = CountTable.HeartFamilyROCount, 
		BoneNtRecvrdCount = CountTable.BoneNtRecvrdCount, 
		SkinNtRecvrdCount = CountTable.SkinNtRecvrdCount, 
		EyesNtRecvrdCount = CountTable.EyesNtRecvrdCount, 
		HeartNtRecvrdCount = CountTable.HeartNtRecvrdCount, 
		BoneNACount = CountTable.BoneNACount, 
		SkinNACount = CountTable.SkinNACount, 
		EyesNACount = CountTable.EyesNACount, 
		HeartNACount = CountTable.HeartNACount,
		TotalROCount = CountTable.TotalROCount		
	FROM	
	(	-- CountTable
		SELECT
			DetailSourceCodeID AS CallSourceCodeID,
			DetailStatEmployeeID AS CallStatEmployeeID , -- StatEmployeeID different for every count
			DetailOrganizationID AS CallOrganizationID ,
			DetailYearID AS CallYearID , 	-- YearID different for every count
			DetailMonthID AS CallMonthID , 	-- MonthID different for every count
			SUM( BoneCnrROCount ) AS 'BoneCnrROCount', 
			SUM( SkinCnrROCount ) AS 'SkinCnrROCount', 
			SUM( EyesCnrROCount ) AS 'EyesCnrROCount', 
			SUM( HeartCnrROCount ) AS 'HeartCnrROCount', 
			SUM( BoneNBDCount ) AS 'BoneNBDCount', 
			SUM( SkinNBDCount ) AS 'SkinNBDCount', 
			SUM( EyesNBDCount ) AS 'EyesNBDCount', 
			SUM( HeartNBDCount ) AS 'HeartNBDCount', 
			SUM( BoneMROCount ) AS 'BoneMROCount', 
			SUM( SkinMROCount ) AS 'SkinMROCount', 
			SUM( EyesMROCount ) AS 'EyesMROCount', 
			SUM( HeartMROCount ) AS 'HeartMROCount', 
			SUM( BoneHighRiskCount ) AS 'BoneHighRiskCount', 
			SUM( SkinHighRiskCount ) AS 'SkinHighRiskCount', 
			SUM( EyesHighRiskCount ) AS 'EyesHighRiskCount', 
			SUM( HeartHighRiskCount ) AS 'HeartHighRiskCount', 
			SUM( BoneLogisticsCount ) AS 'BoneLogisticsCount', 
			SUM( SkinLogisticsCount ) AS 'SkinLogisticsCount', 
			SUM( EyesLogisticsCount ) AS 'EyesLogisticsCount', 
			SUM( HeartLogisticsCount ) AS 'HeartLogisticsCount', 
			SUM( BoneHrtTxablCount ) AS 'BoneHrtTxablCount', 
			SUM( SkinHrtTxablCount ) AS 'SkinHrtTxablCount', 
			SUM( EyesHrtTxablCount ) AS 'EyesHrtTxablCount', 
			SUM( HeartHrtTxablCount ) AS 'HeartHrtTxablCount', 
			SUM( BoneUnKnownCount ) AS 'BoneUnKnownCount', 
			SUM( SkinUnKnownCount ) AS 'SkinUnKnownCount', 
			SUM( EyesUnKnownCount ) AS 'EyesUnKnownCount', 
			SUM( HeartUnKnownCount ) AS 'HeartUnKnownCount', 
			SUM( BoneFamilyROCount ) AS 'BoneFamilyROCount', 
			SUM( SkinFamilyROCount ) AS 'SkinFamilyROCount', 
			SUM( EyesFamilyROCount ) AS 'EyesFamilyROCount', 
			SUM( HeartFamilyROCount ) AS 'HeartFamilyROCount', 
			SUM( BoneNtRecvrdCount ) AS 'BoneNtRecvrdCount', 
			SUM( SkinNtRecvrdCount ) AS 'SkinNtRecvrdCount', 
			SUM( EyesNtRecvrdCount ) AS 'EyesNtRecvrdCount', 
			SUM( HeartNtRecvrdCount ) AS 'HeartNtRecvrdCount', 
			SUM( BoneNACount ) AS 'BoneNACount', 
			SUM( SkinNACount ) AS 'SkinNACount', 
			SUM( EyesNACount ) AS 'EyesNACount', 
			SUM( HeartNACount ) AS 'HeartNACount',
			SUM( TotalROCount) AS 'TotalROCount'
		FROM 
		
		(--- DetailTable
		SELECT	
			SourceCodeID AS DetailSourceCodeID,
			FSCaseFinalUserID AS DetailStatEmployeeID , -- StatEmployeeID different for every count
			ReferralCallerOrganizationID AS DetailOrganizationID ,
			DATEPART( YYYY , FSCaseFinalDateTime ) AS DetailYearID , 	-- YearID different for every count
			DATEPART( M , FSCaseFinalDateTime ) AS DetailMonthID , 	-- MonthID different for every count
			--Count(*) AS ReferralCount
			--add counts for each recovery type used and add each type
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND 
				ReferralBoneConversionID = 2 
													THEN 1 ELSE 0 END AS 'BoneCnrROCount', 
			CASE WHEN 
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 2 
													THEN 1 ELSE 0 END AS 'SkinCnrROCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 2 
													THEN 1 ELSE 0 END AS 'EyesCnrROCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 2 
													THEN 1 ELSE 0 END AS 'HeartCnrROCount', 
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 4 
													THEN 1 ELSE 0 END AS 'BoneNBDCount', 
			CASE WHEN  
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 4 
													THEN 1 ELSE 0 END AS 'SkinNBDCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 4 
													THEN 1 ELSE 0 END AS 'EyesNBDCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 4 
													THEN 1 ELSE 0 END AS 'HeartNBDCount', 
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 5 
													THEN 1 ELSE 0 END AS 'BoneMROCount', 
			CASE WHEN  
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 5 
													THEN 1 ELSE 0 END AS 'SkinMROCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 5 
													THEN 1 ELSE 0 END AS 'EyesMROCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 5 
													THEN 1 ELSE 0 END AS 'HeartMROCount', 
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 6 										
													THEN 1 ELSE 0 END AS 'BoneHighRiskCount', 
			CASE WHEN  
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 6 
													THEN 1 ELSE 0 END AS 'SkinHighRiskCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 6 
													THEN 1 ELSE 0 END AS 'EyesHighRiskCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 6 
													THEN 1 ELSE 0 END AS 'HeartHighRiskCount', 
			CASE WHEN
				ReferralBoneAppropriateID = 1
				AND 
				ReferralBoneConversionID = 7 
													THEN 1 ELSE 0 END AS 'BoneLogisticsCount', 
			CASE WHEN 
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 7 
													THEN 1 ELSE 0 END AS 'SkinLogisticsCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 7 
													THEN 1 ELSE 0 END AS 'EyesLogisticsCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND 
				ReferralValvesConversionID = 7 
													THEN 1 ELSE 0 END AS 'HeartLogisticsCount', 
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 8 
													THEN 1 ELSE 0 END AS 'BoneHrtTxablCount', 
			CASE WHEN  
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 8 										
													THEN 1 ELSE 0 END AS 'SkinHrtTxablCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 8 
													THEN 1 ELSE 0 END AS 'EyesHrtTxablCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND 
				ReferralValvesConversionID = 8 
													THEN 1 ELSE 0 END AS 'HeartHrtTxablCount', 
			
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 9 
													THEN 1 ELSE 0 END AS 'BoneUnKnownCount', 
			CASE WHEN 
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 9 
													THEN 1 ELSE 0 END AS 'SkinUnKnownCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 9 
													THEN 1 ELSE 0 END AS 'EyesUnKnownCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 9 
													THEN 1 ELSE 0 END AS 'HeartUnKnownCount', 
			
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 10 
													THEN 1 ELSE 0 END AS 'BoneFamilyROCount', 
			CASE WHEN 
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 10 
													THEN 1 ELSE 0 END AS 'SkinFamilyROCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 10 
													THEN 1 ELSE 0 END AS 'EyesFamilyROCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 10 
													THEN 1 ELSE 0 END AS 'HeartFamilyROCount', 
			CASE WHEN 
				ReferralBoneAppropriateID = 1
				AND
				ReferralBoneConversionID = 11 
													THEN 1 ELSE 0 END AS 'BoneNtRecvrdCount', 
			CASE WHEN 
				ReferralSkinAppropriateID = 1
				AND
				ReferralSkinConversionID = 11 
													THEN 1 ELSE 0 END AS 'SkinNtRecvrdCount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				ReferralEyesTransConversionID = 11 
													THEN 1 ELSE 0 END AS 'EyesNtRecvrdCount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND
				ReferralValvesConversionID = 11 
													THEN 1 ELSE 0 END AS 'HeartNtRecvrdCount', 
			CASE WHEN
				ReferralBoneAppropriateID = 1
				AND  
				(ISNULL(ReferralBoneConversionID, -1)  = -1 
				OR ISNULL(ReferralBoneConversionID, -1) NOT IN (1, 2, 4, 5, 6, 7, 8, 9, 10, 11))
													THEN 1 ELSE 0 END AS 'BoneNACount', 
			CASE WHEN
				ReferralSkinAppropriateID = 1
				AND 
				(ISNULL(ReferralSkinConversionID, -1)  = -1 
				OR ISNULL(ReferralSkinConversionID, -1) NOT IN (1, 2, 4, 5, 6, 7, 8, 9, 10, 11))
													THEN 1 ELSE 0 END AS 'SkinNACount', 
			CASE WHEN 
				ReferralEyesTransAppropriateID = 1
				AND
				(ISNULL(ReferralEyesTransConversionID, -1)  = -1 				
				OR ISNULL(ReferralEyesTransConversionID, -1) NOT IN (1, 2, 4, 5, 6, 7, 8, 9, 10, 11))
													THEN 1 ELSE 0 END AS 'EyesNACount', 
			CASE WHEN 
				ReferralValvesAppropriateID = 1
				AND 
				(ISNULL(ReferralValvesConversionID, -1)  = -1 
				OR ISNULL(ReferralValvesConversionID, -1) NOT IN (1, 2, 4, 5, 6, 7, 8, 9, 10, 11))
													THEN 1 ELSE 0 END AS 'HeartNACount',
			CASE WHEN 
			(
				(ReferralBoneAppropriateID = 1
				AND 
				ISNULL(ReferralBoneConversionID, -1) > 1 )
				OR
				(ReferralSkinAppropriateID = 1
				AND
				ISNULL(ReferralSkinConversionID, -1) > 1)
				OR
				(ReferralEyesTransAppropriateID = 1
				AND
				ISNULL(ReferralEyesTransConversionID, -1) > 1)
				OR
				(ReferralValvesAppropriateID = 1
				AND
				ISNULL(ReferralValvesConversionID, -1) > 1)
				
			)
													THEN 1 ELSE 0 END AS 'TotalROCount'
												 
		FROM	
			@_Temp_FSReferral_Select
		WHERE 
			SecondaryApproached = 1
			AND SecondaryApproachOutcome = 2
		) AS DetailTable -- DetailTable
			GROUP BY   
			DetailYearID, 
			DetailMonthID,  
			DetailSourceCodeID,  
			DetailStatEmployeeID, 
			DetailOrganizationID

	)AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 	StatEmployeeID = CountTable.CallStatEmployeeID
	AND	OrganizationID = CountTable.CallOrganizationID
	AND	YearID = CountTable.CallYearID
	AND	MonthID = CountTable.CallMonthID



/* Eyes End */
-- remove select after development
-- SELECT * FROM @_Temp_FSReferral_ConversionRate 
-- select * from @_Temp_FSReferral_Select

-- Delete any records for the given month and year
	DELETE 	Referral_FSConversionRateCount                                                                       
	WHERE 	
		MonthID = @MonthID
	AND	
		YearID = @YearID

--Update the count statistics

	-- TEMPORARY FIX IS TO ONLY INSERT RECORDS WITH VALUES
	-- PERMENANENT FIX WILL NEED TO LIMIT THE SIZE OF THE ORIGINAL SIZE
	INSERT 
		[Referral_FSConversionRateCount] 
	SELECT 
		YearID , 
		MonthID , 
		SourceCodeID , 
		OrganizationID , 
		StatEmployeeID , 
		ISNULL( TotalReferralsCount , 0) , 
		ISNULL( TotalAppropriateCount , 0) , 
		ISNULL( TotalFamilyApproachCount , 0) , 
		ISNULL( TotalWrittenConsentCount , 0) , 
		ISNULL( TotalRecoveredCount , 0) ,
		ISNULL( TotalROCount, 0), 
		ISNULL(BoneAppropriateCount , 0 ) , 
		ISNULL(BoneFamilyApproachCount , 0 ) , 
		ISNULL(BoneWrittenConsentCount , 0 ) , 
		ISNULL(BoneRecoveredCount , 0 ) , 
		ISNULL(SkinAppropriateCount , 0 ) , 
		ISNULL(SkinFamilyApproachCount , 0 ) , 
		ISNULL(SkinWrittenConsentCount , 0 ) , 
		ISNULL(SkinRecoveredCount , 0 ) , 
		ISNULL(HeartValvesAppropriateCount , 0 ) , 
		ISNULL(HeartValvesFamilyApproachCount , 0 ) , 
		ISNULL(HeartValvesWrittenConsentCount , 0 ) , 
		ISNULL(HeartValvesRecoveredCount , 0 ) , 
		ISNULL(EyesAppropriateCount , 0 ) , 
		ISNULL(EyesFamilyApproachCount , 0 ) , 
		ISNULL(EyesWrittenConsentCount , 0 ) , 
		ISNULL(EyesRecoveredCount , 0 ) ,
		ISNULL(BoneCnrROCount, 0), 
		ISNULL(SkinCnrROCount, 0), 
		ISNULL(EyesCnrROCount, 0), 
		ISNULL(HeartCnrROCount, 0), 
		ISNULL(BoneNBDCount, 0), 
		ISNULL(SkinNBDCount, 0), 
		ISNULL(EyesNBDCount, 0), 
		ISNULL(HeartNBDCount, 0), 
		ISNULL(BoneMROCount, 0), 
		ISNULL(SkinMROCount, 0), 
		ISNULL(EyesMROCount, 0), 
		ISNULL(HeartMROCount, 0), 
		ISNULL(BoneHighRiskCount, 0), 
		ISNULL(SkinHighRiskCount, 0), 
		ISNULL(EyesHighRiskCount, 0), 
		ISNULL(HeartHighRiskCount, 0), 
		ISNULL(BoneLogisticsCount, 0), 
		ISNULL(SkinLogisticsCount, 0), 
		ISNULL(EyesLogisticsCount, 0), 
		ISNULL(HeartLogisticsCount, 0), 
		ISNULL(BoneHrtTxablCount, 0), 
		ISNULL(SkinHrtTxablCount, 0), 
		ISNULL(EyesHrtTxablCount, 0), 
		ISNULL(HeartHrtTxablCount, 0), 
		ISNULL(BoneUnKnownCount, 0), 
		ISNULL(SkinUnKnownCount, 0), 
		ISNULL(EyesUnKnownCount, 0), 
		ISNULL(HeartUnKnownCount, 0), 
		ISNULL(BoneFamilyROCount, 0), 
		ISNULL(SkinFamilyROCount, 0), 
		ISNULL(EyesFamilyROCount, 0), 
		ISNULL(HeartFamilyROCount, 0), 
		ISNULL(BoneNtRecvrdCount, 0), 
		ISNULL(SkinNtRecvrdCount, 0), 
		ISNULL(EyesNtRecvrdCount, 0), 
		ISNULL(HeartNtRecvrdCount, 0), 
		ISNULL(BoneNACount, 0), 
		ISNULL(SkinNACount, 0), 
		ISNULL(EyesNACount, 0), 
		ISNULL(HeartNACount, 0) 
		 
		
	FROM @_Temp_FSReferral_ConversionRate 
	WHERE ISNULL( TotalReferralsCount , 0) <> 0 
	OR ISNULL( TotalAppropriateCount , 0) <> 0 
	OR ISNULL( TotalFamilyApproachCount , 0) <> 0 
	OR ISNULL( TotalWrittenConsentCount , 0) <> 0 
	OR ISNULL( TotalRecoveredCount , 0) <> 0 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 