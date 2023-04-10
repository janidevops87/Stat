if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_FSConversionRateCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_FSConversionRateCount]
GO

CREATE TABLE [dbo].[Referral_FSConversionRateCount] (
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	--[DayID] [int] NOT NULL ,
	--[HourID] [int] NOT NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[StatEmployeeID] [int] NOT NULL ,
	--[CallID][int] NOT NULL, 
	[TotalReferralsCount] [int] NOT NULL, -- Referral Count
										  -- CallDateTime	
										  -- ReferralCallerOrganization
										  -- Call.StatEmployeeID
	[TotalAppropriateCount] [int] NOT NULL , -- Referral.XXXXXAppropriate any = 1
											-- CallDateTime	
											-- ReferralCallerOrganization
											 -- Call.StatEmployeeID
	[TotalFamilyApproachCount] [int] NOT NULL , -- SecondaryApproached = 1
										   -- 1.1.2.1.2.	SecondaryApproachBy
										   -- 1.1.2.1.3.	FSCaseBillApproachDateTime
										   -- Referral.XXXXXAppropriate any = 1
	[TotalWrittenConsentCount] [int] NOT NULL,  -- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
											-- 1.1.5.1.3.	SecondaryConsentBy
											-- 1.1.5.1.4.	FSCaseBillApproachDateTime
											-- Referral.XXXXXAppropriate any = 1
	[TotalRecoveredCount] [int] NOT NULL, -- SecondaryApproached = 1 AND SecondaryApproachOutcome = 2
										 -- Referral.XXXXXAppropriate any = 1
										 -- Referral.XXXXRecovered any = 1 
										 -- FSCase.FSCaseFinalUserID
	
	[TotalROCount] [int] NULL ,
	
	[BoneAppropriateCount] [int] NOT NULL , 
	[BoneFamilyApproachCount] [int] NOT NULL ,
	[BoneWrittenConsentCount] [int] NOT NULL,
	[BoneRecoveredCount] [int] NOT NULL, 


	[SkinAppropriateCount] [int] NOT NULL , 
	[SkinFamilyApproachCount] [int] NOT NULL ,
	[SkinWrittenConsentCount] [int] NOT NULL,
	[SkinRecoveredCount] [int] NOT NULL, 

	[HeartValvesAppropriateCount] [int] NOT NULL , 
	[HeartValvesFamilyApproachCount] [int] NOT NULL ,
	[HeartValvesWrittenConsentCount] [int] NOT NULL,
	[HeartValvesRecoveredCount] [int] NOT NULL, 

	[EyesAppropriateCount] [int] NOT NULL , 
	[EyesFamilyApproachCount] [int] NOT NULL ,
	[EyesWrittenConsentCount] [int] NOT NULL,
	[EyesRecoveredCount] [int] NOT NULL ,

	[BoneCnrROCount] [int] NOT NULL, 
	[SkinCnrROCount] [int] NOT NULL, 
	[EyesCnrROCount] [int] NOT NULL, 
	[HeartCnrROCount] [int] NOT NULL, 

	[BoneNBDCount] [int] NOT NULL, 
	[SkinNBDCount] [int] NOT NULL, 
	[EyesNBDCount] [int] NOT NULL ,
	[HeartNBDCount] [int] NOT NULL, 

	[BoneMROCount] [int] NOT NULL, 
	[SkinMROCount] [int] NOT NULL, 
	[EyesMROCount] [int] NOT NULL, 
	[HeartMROCount] [int] NOT NULL, 

	[BoneHighRiskCount] [int] NOT NULL, 
	[SkinHighRiskCount] [int] NOT NULL, 
	[EyesHighRiskCount] [int] NOT NULL, 
	[HeartHighRiskCount] [int] NOT NULL, 

	[BoneLogisticsCount] [int] NOT NULL, 
	[SkinLogisticsCount] [int] NOT NULL, 
	[EyesLogisticsCount] [int] NOT NULL, 
	[HeartLogisticsCount] [int] NOT NULL, 

	[BoneHrtTxablCount] [int] NOT NULL, 
	[SkinHrtTxablCount] [int] NOT NULL, 
	[EyesHrtTxablCount] [int] NOT NULL, 
	[HeartHrtTxablCount] [int] NOT NULL, 

	[BoneUnKnownCount] [int] NOT NULL, 
	[SkinUnKnownCount] [int] NOT NULL, 
	[EyesUnKnownCount] [int] NOT NULL, 
	[HeartUnKnownCount] [int] NOT NULL, 

	[BoneFamilyROCount] [int] NOT NULL, 
	[SkinFamilyROCount] [int] NOT NULL, 
	[EyesFamilyROCount] [int] NOT NULL, 
	[HeartFamilyROCount] [int] NOT NULL, 

	[BoneNtRecvrdCount] [int] NOT NULL, 
	[SkinNtRecvrdCount] [int] NOT NULL, 
	[EyesNtRecvrdCount] [int] NOT NULL, 
	[HeartNtRecvrdCount] [int] NOT NULL,
	
	-- NA is Not Available the field was not filled in
	[BoneNACount] [int] NOT NULL, 
	[SkinNACount] [int] NOT NULL, 
	[EyesNACount] [int] NOT NULL, 
	[HeartNACount] [int] NOT NULL
	

) ON [PRIMARY]
GO

