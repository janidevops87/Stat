SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ConsentReasonCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ConsentReasonCount]
GO





-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_ConsentReasonCount 3, 2000
CREATE PROCEDURE spi_Referral_ConsentReasonCount

	@MonthID	int,
	@YearID		int


AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE

	@ReferralCount		int,
	@ReasonID		int,
	@AprchDMVReasonID	int,
	@AprchRegReasonID	int,
	@CnsntDMVReasonID	int,
	@CnsntRegReasonID	int,
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT	
	--Create the temp table
	CREATE TABLE #_Temp_Referral_ConsentReasonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,

	[ConsentOrgan] [int] NULL Default(0) ,
	[ConsentBone] [int] NULL Default(0) ,
	[ConsentTissue] [int] NULL Default(0) ,
	[ConsentSkin] [int] NULL Default(0) ,
	[ConsentValves] [int] NULL Default(0) ,
	[ConsentEyes] [int] NULL Default(0) ,
	[ConsentOther] [int] NULL Default(0) ,
	[ConsentAllTissue] [int] NULL Default(0) ,

	[ConsentOrganNotConsented] [int] NULL Default(0) ,
	[ConsentBoneNotConsented] [int] NULL Default(0) ,
	[ConsentTissueNotConsented] [int] NULL Default(0) ,
	[ConsentSkinNotConsented] [int] NULL Default(0) ,
	[ConsentValvesNotConsented] [int] NULL Default(0) ,
	[ConsentEyesNotConsented] [int] NULL Default(0) ,
	[ConsentOtherNotConsented] [int] NULL Default(0) ,
	[ConsentAllTissueNotConsented] [int] NULL Default(0) ,

	[ConsentOrganEthnic] [int] NULL Default(0) ,
	[ConsentBoneEthnic] [int] NULL Default(0) ,
	[ConsentTissueEthnic] [int] NULL Default(0) ,
	[ConsentSkinEthnic] [int] NULL Default(0) ,
	[ConsentValvesEthnic] [int] NULL Default(0) ,
	[ConsentEyesEthnic] [int] NULL Default(0) ,
	[ConsentOtherEthnic] [int] NULL Default(0) ,
	[ConsentAllTissueEthnic] [int] NULL Default(0) ,

	[ConsentOrganReligious] [int] NULL Default(0) ,
	[ConsentBoneReligious] [int] NULL Default(0) ,
	[ConsentTissueReligious] [int] NULL Default(0) ,
	[ConsentSkinReligious] [int] NULL Default(0) ,
	[ConsentValvesReligious] [int] NULL Default(0) ,
	[ConsentEyesReligious] [int] NULL Default(0) ,
	[ConsentOtherReligious] [int] NULL Default(0) ,
	[ConsentAllTissueReligious] [int] NULL Default(0) ,

	[ConsentOrganEmotional] [int] NULL Default(0) ,
	[ConsentBoneEmotional] [int] NULL Default(0) ,
	[ConsentTissueEmotional] [int] NULL Default(0) ,
	[ConsentSkinEmotional] [int] NULL Default(0) ,
	[ConsentValvesEmotional] [int] NULL Default(0) ,
	[ConsentEyesEmotional] [int] NULL Default(0) ,
	[ConsentOtherEmotional] [int] NULL Default(0) ,
	[ConsentAllTissueEmotional] [int] NULL Default(0) ,

	[ConsentOrganUnknown] [int] NULL Default(0) ,
	[ConsentBoneUnknown] [int] NULL Default(0) ,
	[ConsentTissueUnknown] [int] NULL Default(0) ,
	[ConsentSkinUnknown] [int] NULL Default(0) ,
	[ConsentValvesUnknown] [int] NULL Default(0) ,
	[ConsentEyesUnknown] [int] NULL Default(0) ,
	[ConsentOtherUnknown] [int] NULL Default(0) ,
	[ConsentAllTissueUnknown] [int] NULL Default(0) ,

	[ConsentOrganPrevDiscussion] [int] NULL Default(0) ,
	[ConsentBonePrevDiscussion] [int] NULL Default(0) ,
	[ConsentTissuePrevDiscussion] [int] NULL Default(0) ,
	[ConsentSkinPrevDiscussion] [int] NULL Default(0) ,
	[ConsentValvesPrevDiscussion] [int] NULL Default(0) ,
	[ConsentEyesPrevDiscussion] [int] NULL Default(0) ,
	[ConsentOtherPrevDiscussion] [int] NULL Default(0) ,
	[ConsentAllTissuePrevDiscussion] [int] NULL Default(0) ,

	[AppropriateRO] [int] NULL ,

	--10/30/01 drh
	[RegConsentOrgan] [int] NULL Default(0) ,
	[RegConsentBone] [int] NULL Default(0) ,
	[RegConsentTissue] [int] NULL Default(0) ,
	[RegConsentSkin] [int] NULL Default(0) ,
	[RegConsentValves] [int] NULL Default(0) ,
	[RegConsentEyes] [int] NULL Default(0) ,
	[RegConsentOther] [int] NULL Default(0) ,
	[RegConsentAllTissue] [int] NULL Default(0) ,

	[RegConsentOrganDMVReg] [int] NULL Default(0) ,
	[RegConsentBoneDMVReg] [int] NULL Default(0) ,
	[RegConsentTissueDMVReg] [int] NULL Default(0) ,
	[RegConsentSkinDMVReg] [int] NULL Default(0) ,
	[RegConsentValvesDMVReg] [int] NULL Default(0) ,
	[RegConsentEyesDMVReg] [int] NULL Default(0) ,
	[RegConsentOtherDMVReg] [int] NULL Default(0) ,
	[RegConsentAllTissueDMVReg] [int] NULL Default(0) ,

	[RegConsentOrganDRReg] [int] NULL Default(0) ,
	[RegConsentBoneDRReg] [int] NULL Default(0) ,
	[RegConsentTissueDRReg] [int] NULL Default(0) ,
	[RegConsentSkinDRReg] [int] NULL Default(0) ,
	[RegConsentValvesDRReg] [int] NULL Default(0) ,
	[RegConsentEyesDRReg] [int] NULL Default(0) ,
	[RegConsentOtherDRReg] [int] NULL Default(0) ,
	[RegConsentAllTissueDRReg] [int] NULL Default(0) ,

	[RegConsentOrganNotConsented] [int] NULL Default(0) ,
	[RegConsentBoneNotConsented] [int] NULL Default(0) ,
	[RegConsentTissueNotConsented] [int] NULL Default(0) ,
	[RegConsentSkinNotConsented] [int] NULL Default(0) ,
	[RegConsentValvesNotConsented] [int] NULL Default(0) ,
	[RegConsentEyesNotConsented] [int] NULL Default(0) ,
	[RegConsentOtherNotConsented] [int] NULL Default(0) ,
	[RegConsentAllTissueNotConsented] [int] NULL Default(0) ,

	[RegConsentOrganEthnic] [int] NULL Default(0) ,
	[RegConsentBoneEthnic] [int] NULL Default(0) ,
	[RegConsentTissueEthnic] [int] NULL Default(0) ,
	[RegConsentSkinEthnic] [int] NULL Default(0) ,
	[RegConsentValvesEthnic] [int] NULL Default(0) ,
	[RegConsentEyesEthnic] [int] NULL Default(0) ,
	[RegConsentOtherEthnic] [int] NULL Default(0) ,
	[RegConsentAllTissueEthnic] [int] NULL Default(0) ,

	[RegConsentOrganReligious] [int] NULL Default(0) ,
	[RegConsentBoneReligious] [int] NULL Default(0) ,
	[RegConsentTissueReligious] [int] NULL Default(0) ,
	[RegConsentSkinReligious] [int] NULL Default(0) ,
	[RegConsentValvesReligious] [int] NULL Default(0) ,
	[RegConsentEyesReligious] [int] NULL Default(0) ,
	[RegConsentOtherReligious] [int] NULL Default(0) ,
	[RegConsentAllTissueReligious] [int] NULL Default(0) ,

	[RegConsentOrganEmotional] [int] NULL Default(0) ,
	[RegConsentBoneEmotional] [int] NULL Default(0) ,
	[RegConsentTissueEmotional] [int] NULL Default(0) ,
	[RegConsentSkinEmotional] [int] NULL Default(0) ,
	[RegConsentValvesEmotional] [int] NULL Default(0) ,
	[RegConsentEyesEmotional] [int] NULL Default(0) ,
	[RegConsentOtherEmotional] [int] NULL Default(0) ,
	[RegConsentAllTissueEmotional] [int] NULL Default(0) ,

	[RegConsentOrganUnknown] [int] NULL Default(0) ,
	[RegConsentBoneUnknown] [int] NULL Default(0) ,
	[RegConsentTissueUnknown] [int] NULL Default(0) ,
	[RegConsentSkinUnknown] [int] NULL Default(0) ,
	[RegConsentValvesUnknown] [int] NULL Default(0) ,
	[RegConsentEyesUnknown] [int] NULL Default(0) ,
	[RegConsentOtherUnknown] [int] NULL Default(0) ,
	[RegConsentAllTissueUnknown] [int] NULL Default(0) ,

	[RegConsentOrganPrevDiscussion] [int] NULL Default(0) ,
	[RegConsentBonePrevDiscussion] [int] NULL Default(0) ,
	[RegConsentTissuePrevDiscussion] [int] NULL Default(0) ,
	[RegConsentSkinPrevDiscussion] [int] NULL Default(0) ,
	[RegConsentValvesPrevDiscussion] [int] NULL Default(0) ,
	[RegConsentEyesPrevDiscussion] [int] NULL Default(0) ,
	[RegConsentOtherPrevDiscussion] [int] NULL Default(0) ,
	[RegConsentAllTissuePrevDiscussion] [int] NULL Default(0),

	-- ccarroll 11/20/2006 -  Added following options StatTrac 8.2 release
	[ConsentOrganNotPronounced] [int] NULL Default(0) ,
	[ConsentBoneNotPronounced] [int] NULL Default(0) ,
	[ConsentTissueNotPronounced] [int] NULL Default(0) ,
	[ConsentSkinNotPronounced] [int] NULL Default(0) ,
	[ConsentValvesNotPronounced] [int] NULL Default(0) ,
	[ConsentEyesNotPronounced] [int] NULL Default(0) ,
	[ConsentOtherNotPronounced] [int] NULL Default(0) ,
	[ConsentAllTissueNotPronounced] [int] NULL Default(0) ,

	[ConsentOrganNoJurisdiction] [int] NULL Default(0) ,
	[ConsentBoneNoJurisdiction] [int] NULL Default(0) ,
	[ConsentTissueNoJurisdiction] [int] NULL Default(0) ,
	[ConsentSkinNoJurisdiction] [int] NULL Default(0) ,
	[ConsentValvesNoJurisdiction] [int] NULL Default(0) ,
	[ConsentEyesNoJurisdiction] [int] NULL Default(0) ,
	[ConsentOtherNoJurisdiction] [int] NULL Default(0) ,
	[ConsentAllTissueNoJurisdiction] [int] NULL Default(0) ,

	[ConsentOrganDidNotDie] [int] NULL Default(0) ,
	[ConsentBoneDidNotDie] [int] NULL Default(0) ,
	[ConsentTissueDidNotDie] [int] NULL Default(0) ,
	[ConsentSkinDidNotDie] [int] NULL Default(0) ,
	[ConsentValvesDidNotDie] [int] NULL Default(0) ,
	[ConsentEyesDidNotDie] [int] NULL Default(0) ,
	[ConsentOtherDidNotDie] [int] NULL Default(0) ,
	[ConsentAllTissueDidNotDie] [int] NULL Default(0),

	-- ccarroll 11/20/2006 - Added Reg options StatTrac 8.2 release
	[RegConsentOrganNotPronounced] [int] NULL Default(0) ,
	[RegConsentBoneNotPronounced] [int] NULL Default(0) ,
	[RegConsentTissueNotPronounced] [int] NULL Default(0) ,
	[RegConsentSkinNotPronounced] [int] NULL Default(0) ,
	[RegConsentValvesNotPronounced] [int] NULL Default(0) ,
	[RegConsentEyesNotPronounced] [int] NULL Default(0) ,
	[RegConsentOtherNotPronounced] [int] NULL Default(0) ,
	[RegConsentAllTissueNotPronounced] [int] NULL Default(0) ,

	[RegConsentOrganNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentBoneNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentTissueNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentSkinNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentValvesNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentEyesNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentOtherNoJurisdiction] [int] NULL Default(0) ,
	[RegConsentAllTissueNoJurisdiction] [int] NULL Default(0) ,

	[RegConsentOrganDidNotDie] [int] NULL Default(0) ,
	[RegConsentBoneDidNotDie] [int] NULL Default(0) ,
	[RegConsentTissueDidNotDie] [int] NULL Default(0) ,
	[RegConsentSkinDidNotDie] [int] NULL Default(0) ,
	[RegConsentValvesDidNotDie] [int] NULL Default(0) ,
	[RegConsentEyesDidNotDie] [int] NULL Default(0) ,
	[RegConsentOtherDidNotDie] [int] NULL Default(0) ,
	[RegConsentAllTissueDidNotDie] [int] NULL Default(0)
	)

CREATE TABLE #_Temp_Referral_ConsentReasonSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
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
	-- 9/21/04 - SAP
	[RegistryStatus][int] NULL
   )
	--Clean temp table
	TRUNCATE TABLE   #_Temp_Referral_ConsentReasonCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ConsentReasonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdReport.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Call'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
               TRUNCATE TABLE   #_Temp_Referral_ConsentReasonSelect

        --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_ConsentReasonSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, RegistryStatus)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID,'
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdReport.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdReport.dbo.RegistryStatus ON _ReferralProdReport.dbo.Referral.CallId = _ReferralProdReport.dbo.RegistryStatus.CallId'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

	EXEC(@strSelectLine+@strSelectLine2)	


--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************
	--BEGIN NON-REGISTERED 
--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************

---------------------------------Begin Appropiate----------------------------------------------------

SET @ReasonID = 1
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- ConsentOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- ConsentBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyes
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOther
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End Consent-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin NotConsented----------------------------------------------------------

	SET @ReasonID = 1
--**************************************************************************************************************************************************************************************
	-- ConsentOrganNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID <> @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID <> @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID <> @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID <> @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesNotConsented 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID <> @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID <> @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherNotConsented

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID <> @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End NotConsented-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin Ethnic----------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- ConsentOrganEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesEthnic 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherEthnic
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueEthnic
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End Ethnic-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
--------------------------------Begin Religious--------------------------------------------------------------

	SET @ReasonID = 3
--**************************************************************************************************************************************************************************************
	-- ConsentOrganReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueReligious = CountTable.ReferralCount
	FROM		
	(

	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesReligious 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount

	SET		ConsentOtherReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------End Religious-------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin Emotional--------------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- ConsentOrganEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ConsentBoneEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentValvesEmotional 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End Emotional-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin Unknown-----------------------------------------------------------------

	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- ConsentOrganUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End Unknown----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------Begin PrevDiscussion----------------------------------------------------------

	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- ConsentOrganPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBonePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBonePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount

	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesPrevDiscussion 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End PrevDiscussion----------------------------------------------------------
---------------------------------------------Begin NotPronounced----------------------------------------------------------

	SET @ReasonID = 9
--**************************************************************************************************************************************************************************************
	-- ConsentOrganNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount

	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesNotPronounced 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End NotPronounced----------------------------------------------------------
---------------------------------------------Begin NoJurisdiction----------------------------------------------------------

	SET @ReasonID = 10
--**************************************************************************************************************************************************************************************
	-- ConsentOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount

	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesNoJurisdiction 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End NoJurisdiction----------------------------------------------------------
---------------------------------------------Begin DidNotDie----------------------------------------------------------

	SET @ReasonID = 11
--**************************************************************************************************************************************************************************************
	-- ConsentOrganDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentOrganDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentBoneDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentBoneDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount

	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentSkinDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentSkinDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValvesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentValvesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentEyesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		ConsentEyesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentOtherDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentOtherDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		ConsentAllTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID = @ReasonID AND	ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1)
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND ReferralTissueApproachID = 1)
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1)
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End DidNotDie----------------------------------------------------------



--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************
	--END NON-REGISTERED 
--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************


--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************
	--BEGIN REGISTERED 
--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************


---------------------------------Begin RegAppropiate----------------------------------------------------

SET @ReasonID = 1
SET @AprchDMVReasonID = 12
SET @AprchRegReasonID = 13
SET @CnsntDMVReasonID = 7
SET @CnsntRegReasonID = 8
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- RegConsentOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralOrganConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- RegConsentBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralTissueConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralSkinConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralValvesConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesTransConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesRschConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus > 0)
	AND		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	(((ReferralBoneConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID) 
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus > 0) AND ReferralBoneAppropriateID = 1)
		OR
			(((ReferralTissueConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID) 
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus > 0) AND ReferralTissueAppropriateID = 1)
		OR		
			(((ReferralSkinConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID) 
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus > 0) AND ReferralSkinAppropriateID = 1)
		OR		
			(((ReferralValvesConsentID IN(@CnsntDMVReasonID, @CnsntRegReasonID) 
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus > 0) AND ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End RegConsent-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

---------------------------------Begin RegConsentDMVReg----------------------------------------------------
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganDMVReg
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralOrganConsentID IN(@CnsntDMVReasonID)
	AND		ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralOrganAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneDMVReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID IN(@CnsntDMVReasonID)
	AND		ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralBoneAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueDMVReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralTissueConsentID IN(@CnsntDMVReasonID)
	AND		ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralTissueAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinDMVReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralSkinConsentID IN(@CnsntDMVReasonID)
	AND		ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralSkinAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesDMVReg 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralValvesConsentID IN(@CnsntDMVReasonID)
	AND		ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralValvesAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesDMVReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesTransConsentID IN(@CnsntDMVReasonID)
	AND		ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralEyesTransAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherDMVReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesRschConsentID IN(@CnsntDMVReasonID)
	AND		ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 1)
	AND		ReferralEyesRschAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueDMVReg
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect

	WHERE (((ReferralBoneConsentID IN(@CnsntDMVReasonID) 
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus = 1) AND ReferralBoneAppropriateID = 1)
		OR
			(((ReferralTissueConsentID IN(@CnsntDMVReasonID) 
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus = 1) AND ReferralTissueAppropriateID = 1)
		OR		
			(((ReferralSkinConsentID IN(@CnsntDMVReasonID) 
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus = 1) AND ReferralSkinAppropriateID = 1)
		OR		
			(((ReferralValvesConsentID IN(@CnsntDMVReasonID) 
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus = 1) AND ReferralValvesAppropriateID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End RegConsentDMVReg-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

---------------------------------Begin RegConsentDRReg----------------------------------------------------
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganDRReg
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralOrganConsentID IN(@CnsntRegReasonID)
	AND		ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralOrganAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneDRReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralBoneConsentID IN(@CnsntRegReasonID)
	AND		ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralBoneAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueDRReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralTissueConsentID IN(@CnsntRegReasonID)
	AND		ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinDRReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralSkinConsentID IN(@CnsntRegReasonID)
	AND		ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralSkinAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesDRReg 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralValvesConsentID IN(@CnsntRegReasonID)
	AND		ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralValvesAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesDRVReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesTransConsentID IN(@CnsntRegReasonID)
	AND		ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralEyesTransAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherDRReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		((ReferralEyesRschConsentID IN(@CnsntRegReasonID)
	AND		ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			RegistryStatus = 2)
	AND		ReferralEyesRschAppropriateID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueDRReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect

	WHERE (((ReferralBoneConsentID IN(@CnsntRegReasonID) 
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus = 2) AND ReferralBoneAppropriateID = 1)
		OR
			(((ReferralTissueConsentID IN(@CnsntRegReasonID) 
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)) 
			OR RegistryStatus = 2) AND ReferralTissueAppropriateID = 1)
		OR		
			(((ReferralSkinConsentID IN(@CnsntRegReasonID) 
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus = 2) AND ReferralSkinAppropriateID = 1)
		OR		
			(((ReferralValvesConsentID IN(@CnsntRegReasonID) 
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR RegistryStatus = 2) AND ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End RegConsentDRReg-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------Begin RegNotConsented----------------------------------------------------------

	SET @ReasonID = 1
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralOrganConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralOrganAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralOrganConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralBoneConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralBoneAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralBoneConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralTissueConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralTissueAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralTissueConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralSkinConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralSkinAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralSkinConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesNotConsented 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralValvesConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralValvesAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralValvesConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralEyesTransConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralEyesTransAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralEyesTransConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherNotConsented = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		(ReferralEyesRschConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID)
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
	OR			(ReferralEyesRschAppropriateID = 1 
	AND 		RegistryStatus > 0 
	AND		ReferralEyesRschConsentID NOT IN(1, @CnsntDMVReasonID, @CnsntRegReasonID))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueNotConsented
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueNotConsented = CountTable.ReferralCount

	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID) AND ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR 
			(ReferralBoneAppropriateID = 1 AND RegistryStatus > 0 AND ReferralBoneConsentID NOT IN (1,@CnsntDMVReasonID, @CnsntRegReasonID)))
		OR
			((ReferralTissueConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID) AND ReferralTissueAppropriateID = 1 AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR 
			(ReferralTissueAppropriateID = 1 AND RegistryStatus > 0 AND ReferralTissueConsentID NOT IN (1,@CnsntDMVReasonID, @CnsntRegReasonID)))
		OR
			((ReferralSkinConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID) AND	ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR 
			(ReferralSkinAppropriateID = 1 AND RegistryStatus > 0 AND ReferralSkinConsentID NOT IN (1,@CnsntDMVReasonID, @CnsntRegReasonID)))
		OR
			((ReferralValvesConsentID NOT IN(@CnsntDMVReasonID, @CnsntRegReasonID) AND ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID))
			OR 
			(ReferralValvesAppropriateID = 1 AND RegistryStatus > 0 AND ReferralValvesConsentID NOT IN (1,@CnsntDMVReasonID, @CnsntRegReasonID)))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegNotConsented-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin RegEthnic----------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)

	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesEthnic 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesEthnic
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherEthnic
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueEthnic
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueEthnic = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegEthnic-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
--------------------------------Begin RegReligious--------------------------------------------------------------

	SET @ReasonID = 3
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesReligious 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount

	SET		RegConsentOtherReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueReligious
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueReligious = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------End RegReligious-------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin RegEmotional--------------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- RegConsentBoneEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)

	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentValvesEmotional 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueEmotional
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueEmotional = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegEmotional-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin RegUnknown-----------------------------------------------------------------

	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneUnknown = CountTable.ReferralCount
	FROM		
	(

	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End RegUnknown----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------Begin RegPrevDiscussion----------------------------------------------------------

	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBonePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBonePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConsentTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesPrevDiscussion 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesPrevDiscussion

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable

	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherPrevDiscussion

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegPrevDiscussion----------------------------------------------------------
------------------------------------------------Begin RegNotPronounced----------------------------------------------------------

	SET @ReasonID = 9
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConsentTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesNotPronounced 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable

	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegNotPronounced----------------------------------------------------------
------------------------------------------------Begin RegNoJurisdiction----------------------------------------------------------

	SET @ReasonID = 10
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConsentTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesNoJurisdiction 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable

	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegNoJurisdiction----------------------------------------------------------

------------------------------------------------Begin RegDidNotDie----------------------------------------------------------

	SET @ReasonID = 11
--**************************************************************************************************************************************************************************************
	-- RegConsentOrganDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOrganDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralOrganConsentID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		(ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentBoneDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentBoneDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralBoneConsentID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		(ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConsentTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralTissueConsentID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		(ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentSkinDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentSkinDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralSkinConsentID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		(ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConsentValvesDidNotDie 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentValvesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralValvesConsentID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		(ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentEyesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConsentReasonCount
	SET		RegConsentEyesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesTransConsentID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		(ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable

	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentOtherDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentOtherDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE		ReferralEyesRschConsentID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		(ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchRegReasonID)
	OR			RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConsentAllTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConsentReasonCount
	SET		RegConsentAllTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConsentReasonSelect
	WHERE	((ReferralBoneConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralTissueConsentID = @ReasonID AND ReferralBoneAppropriateID = 1 AND (ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralSkinConsentID = @ReasonID AND	ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0))
	OR		(ReferralValvesConsentID = @ReasonID AND ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchRegReasonID) OR RegistryStatus > 0)))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegDidNotDie----------------------------------------------------------





--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************
	--END REGISTERED 
--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************


--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_ConsentReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_ConsentReasonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID


	--Update the count statistics
	INSERT INTO Referral_ConsentReasonCount
	SELECT * FROM #_Temp_Referral_ConsentReasonCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

--Select * from #_Temp_Referral_ConsentReasonCount
	DROP TABLE #_Temp_Referral_ConsentReasonCount
	DROP TABLE #_Temp_Referral_ConsentReasonSelect




GO


