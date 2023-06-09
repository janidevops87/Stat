
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachReasonCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachReasonCount]
GO

CREATE   PROCEDURE [dbo].[spi_Referral_ApproachReasonCount]

	@MonthID	int,
	@YearID		int


AS
/******************************************************************************
**		File: spi_Referral_ApproachReasonCount.sql
**		Name: spi_Referral_ApproachReasonCount
**		Desc: 
**              
**		Return values:
** 
**		Called by: DataWarehouse  
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll  
**		Date: 08/01/2011
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**		11/17/2006	ccarroll		Added options for StatTrac 8.2 release
**      08/01/2010	ccarroll		Updated from Production
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE

	@ReferralCount		int,
	@ReasonID		int,
	@DMVReasonID		int,
	@DRReasonID		int,
	@DayLightStartDate   	datetime,
   	@DayLightEndDate     	datetime,
	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
	
	--Create the temp table
	CREATE TABLE #_Temp_Referral_ApproachReasonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[ApproachOrgan] [int] NULL Default(0) ,
	[ApproachBone] [int] NULL  Default(0) ,
	[ApproachTissue] [int] NULL  Default(0) ,
	[ApproachSkin] [int] NULL  Default(0) ,
	[ApproachValves] [int] NULL  Default(0) ,
	[ApproachEyes] [int] NULL  Default(0) ,
	[ApproachOther] [int] NULL  Default(0) ,
	[ApproachAllTissue] [int] NULL  Default(0) ,

	[ApproachOrganNotApproached] [int] NULL Default(0),
	[ApproachBoneNotApproached] [int] NULL Default(0),
	[ApproachTissueNotApproached] [int] NULL Default(0),
	[ApproachSkinNotApproached] [int] NULL Default(0),
	[ApproachValvesNotApproached] [int] NULL Default(0),
	[ApproachEyesNotApproached] [int] NULL Default(0),
	[ApproachOtherNotApproached] [int] NULL Default(0),
	[ApproachAllTissueNotApproached] [int] NULL Default(0),

	[ApproachOrganUnknown] [int] NULL  Default(0) ,
	[ApproachBoneUnknown] [int] NULL  Default(0) ,
	[ApproachTissueUnknown] [int] NULL  Default(0) ,
	[ApproachSkinUnknown] [int] NULL  Default(0) ,
	[ApproachValvesUnknown] [int] NULL  Default(0) ,
	[ApproachEyesUnknown] [int] NULL  Default(0) ,
	[ApproachOtherUnknown] [int] NULL   Default(0),
	[ApproachAllTissueUnknown] [int] NULL Default(0)  ,

	[ApproachOrganFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachBoneFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachTissueFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachSkinFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachValvesFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachEyesFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachOtherFamilyUnavailable] [int] NULL Default(0)  ,
	[ApproachAllTissueFamilyUnavailable] [int] NULL Default(0)  ,

	[ApproachOrganCoronerRuleout] [int] NULL Default(0) ,
	[ApproachBoneCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachTissueCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachSkinCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachValvesCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachEyesCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachOtherCoronerRuleout] [int] NULL  Default(0) ,
	[ApproachAllTissueCoronerRuleout] [int] NULL  Default(0) ,

	[ApproachOrganArrest] [int] NULL  Default(0) ,
	[ApproachBoneArrest] [int] NULL  Default(0) ,
	[ApproachTissueArrest] [int] NULL  Default(0) ,
	[ApproachSkinArrest] [int] NULL  Default(0) ,
	[ApproachValvesArrest] [int] NULL  Default(0) ,
	[ApproachEyesArrest] [int] NULL  Default(0) ,
	[ApproachOtherArrest] [int] NULL  Default(0) ,
	[ApproachAllTissueArrest] [int] NULL  Default(0) ,

	[ApproachOrganMedRO] [int] NULL  Default(0) ,
	[ApproachBoneMedRO] [int] NULL  Default(0) ,
	[ApproachTissueMedRO] [int] NULL  Default(0) ,
	[ApproachSkinMedRO] [int] NULL  Default(0) ,
	[ApproachValvesMedRO] [int] NULL  Default(0) ,
	[ApproachEyesMedRO] [int] NULL  Default(0) ,
	[ApproachOtherMedRO] [int] NULL  Default(0) ,
	[ApproachAllTissueMedRO] [int] NULL  Default(0) ,

	[ApproachOrganTimeLogistics] [int] NULL  Default(0) ,
	[ApproachBoneTimeLogistics] [int] NULL  Default(0) ,
	[ApproachTissueTimeLogistics] [int] NULL  Default(0) ,
	[ApproachSkinTimeLogistics] [int] NULL  Default(0) ,
	[ApproachValvesTimeLogistics] [int] NULL  Default(0) ,
	[ApproachEyesTimeLogistics] [int] NULL  Default(0) ,
	[ApproachOtherTimeLogistics] [int] NULL Default(0)  ,
	[ApproachAllTissueTimeLogistics] [int] NULL Default(0)  ,

	[ApproachOrganNeverBrainDead] [int] NULL Default(0)  ,
	[ApproachBoneNeverBrainDead] [int] NULL Default(0) ,
	[ApproachTissueNeverBrainDead] [int] NULL  Default(0) ,
	[ApproachSkinNeverBrainDead] [int] NULL  Default(0) ,
	[ApproachValvesNeverBrainDead] [int] NULL  Default(0) ,
	[ApproachEyesNeverBrainDead] [int] NULL  Default(0) ,
	[ApproachOtherNeverBrainDead] [int] NULL  Default(0) ,
	[ApproachAllTissueNeverBrainDead] [int] NULL  Default(0) ,

	[ApproachOrganHighRisk] [int] NULL  Default(0) ,
	[ApproachBoneHighRisk] [int] NULL  Default(0) ,
	[ApproachTissueHighRisk] [int] NULL  Default(0) ,
	[ApproachSkinHighRisk] [int] NULL Default(0) ,
	[ApproachValvesHighRisk] [int] NULL Default(0) ,
	[ApproachEyesHighRisk] [int] NULL Default(0) ,
	[ApproachOtherHighRisk] [int] NULL Default(0) ,
	[ApproachAllTissueHighRisk] [int] NULL Default(0) ,

	[ApproachOrganUnapproachable] [int] NULL Default(0),
	[ApproachBoneUnapproachable] [int] NULL Default(0),
	[ApproachTissueUnapproachable] [int] NULL Default(0),
	[ApproachSkinUnapproachable] [int] NULL Default(0),
	[ApproachValvesUnapproachable] [int] NULL Default(0),
	[ApproachEyesUnapproachable] [int] NULL Default(0),
	[ApproachOtherUnapproachable] [int] NULL Default(0),
	[ApproachAllTissueUnapproachable] [int] NULL Default(0),

	[AppropriateRO] [int] NULL,

	[ApproachOrganReg] [int] NULL Default(0) ,
	[ApproachBoneReg] [int] NULL  Default(0) ,
	[ApproachTissueReg] [int] NULL  Default(0) ,
	[ApproachSkinReg] [int] NULL  Default(0) ,
	[ApproachValvesReg] [int] NULL  Default(0) ,
	[ApproachEyesReg] [int] NULL  Default(0) ,
	[ApproachOtherReg] [int] NULL  Default(0) ,
	[ApproachAllTissueReg] [int] NULL  Default(0),

	[ApproachOrganDMVReg] [int] NULL Default(0) ,
	[ApproachBoneDMVReg] [int] NULL  Default(0) ,
	[ApproachTissueDMVReg] [int] NULL  Default(0) ,
	[ApproachSkinDMVReg] [int] NULL  Default(0) ,
	[ApproachValvesDMVReg] [int] NULL  Default(0) ,
	[ApproachEyesDMVReg] [int] NULL  Default(0) ,
	[ApproachOtherDMVReg] [int] NULL  Default(0) ,
	[ApproachAllTissueDMVReg] [int] NULL  Default(0),

	[ApproachOrganDRReg] [int] NULL Default(0) ,
	[ApproachBoneDRReg] [int] NULL  Default(0) ,
	[ApproachTissueDRReg] [int] NULL  Default(0) ,
	[ApproachSkinDRReg] [int] NULL  Default(0) ,
	[ApproachValvesDRReg] [int] NULL  Default(0) ,
	[ApproachEyesDRReg] [int] NULL  Default(0) ,
	[ApproachOtherDRReg] [int] NULL  Default(0) ,
	[ApproachAllTissueDRReg] [int] NULL  Default(0),

	--ccarroll nolonger used however still reported
	[ApproachOrganSecondaryRO] [int] NULL Default(0) ,
	[ApproachBoneSecondaryRO] [int] NULL  Default(0) ,
	[ApproachTissueSecondaryRO] [int] NULL  Default(0) ,
	[ApproachSkinSecondaryRO] [int] NULL  Default(0) ,
	[ApproachValvesSecondaryRO] [int] NULL  Default(0) ,
	[ApproachEyesSecondaryRO] [int] NULL  Default(0) ,
	[ApproachOtherSecondaryRO] [int] NULL  Default(0) ,
	[ApproachAllTissueSecondaryRO] [int] NULL  Default(0),

	--ccarroll 11/17/2006 Added following options
	[ApproachOrganPrevDiscussion] [int] NULL Default(0) ,
	[ApproachBonePrevDiscussion] [int] NULL  Default(0) ,
	[ApproachTissuePrevDiscussion] [int] NULL  Default(0) ,
	[ApproachSkinPrevDiscussion] [int] NULL  Default(0) ,
	[ApproachValvesPrevDiscussion] [int] NULL  Default(0) ,
	[ApproachEyesPrevDiscussion] [int] NULL  Default(0) ,
	[ApproachOtherPrevDiscussion] [int] NULL  Default(0) ,
	[ApproachAllTissuePrevDiscussion] [int] NULL  Default(0),

	[ApproachOrganNotPronounced] [int] NULL Default(0) ,
	[ApproachBoneNotPronounced] [int] NULL  Default(0) ,
	[ApproachTissueNotPronounced] [int] NULL  Default(0) ,
	[ApproachSkinNotPronounced] [int] NULL  Default(0) ,
	[ApproachValvesNotPronounced] [int] NULL  Default(0) ,
	[ApproachEyesNotPronounced] [int] NULL  Default(0) ,
	[ApproachOtherNotPronounced] [int] NULL  Default(0) ,
	[ApproachAllTissueNotPronounced] [int] NULL  Default(0),

	[ApproachOrganNoJurisdiction] [int] NULL Default(0) ,
	[ApproachBoneNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachTissueNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachSkinNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachValvesNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachEyesNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachOtherNoJurisdiction] [int] NULL  Default(0) ,
	[ApproachAllTissueNoJurisdiction] [int] NULL  Default(0),

	[ApproachOrganDidNotDie] [int] NULL Default(0) ,
	[ApproachBoneDidNotDie] [int] NULL  Default(0) ,
	[ApproachTissueDidNotDie] [int] NULL  Default(0) ,
	[ApproachSkinDidNotDie] [int] NULL  Default(0) ,
	[ApproachValvesDidNotDie] [int] NULL  Default(0) ,
	[ApproachEyesDidNotDie] [int] NULL  Default(0) ,
	[ApproachOtherDidNotDie] [int] NULL  Default(0) ,
	[ApproachAllTissueDidNotDie] [int] NULL  Default(0),

	[ApproachOrganHemodiluted] [int] NULL Default(0) ,
	[ApproachBoneHemodiluted] [int] NULL  Default(0) ,
	[ApproachTissueHemodiluted] [int] NULL  Default(0) ,
	[ApproachSkinHemodiluted] [int] NULL  Default(0) ,
	[ApproachValvesHemodiluted] [int] NULL  Default(0) ,
	[ApproachEyesHemodiluted] [int] NULL  Default(0) ,
	[ApproachOtherHemodiluted] [int] NULL  Default(0) ,
	[ApproachAllTissueHemodiluted] [int] NULL  Default(0),

	[ApproachOrganTeamLogistics] [int] NULL Default(0) ,
	[ApproachBoneTeamLogistics] [int] NULL  Default(0) ,
	[ApproachTissueTeamLogistics] [int] NULL  Default(0) ,
	[ApproachSkinTeamLogistics] [int] NULL  Default(0) ,
	[ApproachValvesTeamLogistics] [int] NULL  Default(0) ,
	[ApproachEyesTeamLogistics] [int] NULL  Default(0) ,
	[ApproachOtherTeamLogistics] [int] NULL  Default(0) ,
	[ApproachAllTissueTeamLogistics] [int] NULL  Default(0),

	[ApproachOrganConsentRetracted] [int] NULL Default(0) ,
	[ApproachBoneConsentRetracted] [int] NULL  Default(0) ,
	[ApproachTissueConsentRetracted] [int] NULL  Default(0) ,
	[ApproachSkinConsentRetracted] [int] NULL  Default(0) ,
	[ApproachValvesConsentRetracted] [int] NULL  Default(0) ,
	[ApproachEyesConsentRetracted] [int] NULL  Default(0) ,
	[ApproachOtherConsentRetracted] [int] NULL  Default(0) ,
	[ApproachAllTissueConsentRetracted] [int] NULL  Default(0),

	[ApproachOrganDeclinedByProcessors] [int] NULL Default(0) ,
	[ApproachBoneDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachTissueDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachSkinDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachValvesDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachEyesDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachOtherDeclinedByProcessors] [int] NULL  Default(0) ,
	[ApproachAllTissueDeclinedByProcessors] [int] NULL  Default(0)
	)

CREATE TABLE #_Temp_Referral_ApproachReasonSelect
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
   [RegistryStatus][int] NULL
   )

	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_ApproachReasonCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachReasonCount'
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
               TRUNCATE TABLE  #_Temp_Referral_ApproachReasonSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year

	set @strSelectLine = 'INSERT #_Temp_Referral_ApproachReasonSelect'
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
                     
---------------------------------Begin Appropiate----------------------------------------------------

	SET @ReasonID = 1
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- ApproachOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID  = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOther


--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	AND		RegistryStatus = 0

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End Approach-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------Begin NotApproached-----------------------------------------------------------------

	SET @ReasonID = 1
	SET @DMVReasonID = 12
	SET @DRReasonID = 13
--**************************************************************************************************************************************************************************************
	-- ApproachOrganNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesNotApproached 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNotApproached

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNotApproached

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID,ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End NotApproached----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin Registered-----------------------------------------------------------------
--**************************************************************************************************************************************************************************************
	-- ApproachOrganRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralOrganAppropriateID = 1
	
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(((ReferralBoneApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End Registered----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin DMVRegistered-----------------------------------------------------------------
--**************************************************************************************************************************************************************************************
	-- ApproachOrganDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect

	WHERE		(ReferralSkinApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDMVRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDMVRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDMVRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(((ReferralBoneApproachID= @DMVReasonID OR RegistryStatus = 1) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End DMVRegistered----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin DRRegistered-----------------------------------------------------------------
--**************************************************************************************************************************************************************************************
	-- ApproachOrganDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDRRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDRRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDRRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(((ReferralBoneApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End DRRegistered----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin Unknown-----------------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- ApproachOrganUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesUnknown

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherUnknown


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End Unknown----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin FamilyUnavailable----------------------------------------------------------

	SET @ReasonID = 3
--**************************************************************************************************************************************************************************************
	-- ApproachOrganFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganFamilyUnavailable = CountTable.ReferralCount

	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount

	SET		ApproachSkinFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesFamilyUnavailable 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesFamilyUnavailable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherFamilyUnavailable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End FamilyUnavailable-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
--------------------------------Begin CoronerRuleout--------------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- ApproachOrganCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesCoronerRuleout 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------End CoronerRuleout-------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin Arrest--------------------------------------------------------------

	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- ApproachOrganArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID

	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesArrest 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable

	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End Arrest-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
--------------------------------Begin MedRO--------------------------------------------------------------

	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- ApproachOrganMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesMedRO 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTRansAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End MedRO-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
--------------------------------Begin TimeLogistics-------------------------------------------------------

	SET @ReasonID = 7
--**************************************************************************************************************************************************************************************
	-- ApproachOrganTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesTimeLogistics 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------------------End TimeLogistics----------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin NeverBrainDead----------------------------------------------------------

	SET @ReasonID = 8
--**************************************************************************************************************************************************************************************
	-- ApproachOrganNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesNeverBrainDead 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End NeverBrainDead----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin HighRisk----------------------------------------------------------

	SET @ReasonID = 9
--**************************************************************************************************************************************************************************************
	-- ApproachOrganHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesHighRisk 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End HighRisk----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin Unapproachable----------------------------------------------------------

	SET @ReasonID = 11
--**************************************************************************************************************************************************************************************
	-- ApproachOrganUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************

	-- ApproachSkinUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesUnapproachable 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End Unapproachable----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin SecondaryRO----------------------------------------------------------
	SET @ReasonID = 14
--**************************************************************************************************************************************************************************************
	-- ApproachOrganSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesSecondaryRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherSecondaryRO

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueSecondaryRO
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueSecondaryRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End SecondaryRO----------------------------------------------------------

------------------------------------------------Begin PrevDiscussion----------------------------------------------------------
	SET @ReasonID = 15
--**************************************************************************************************************************************************************************************
	-- ApproachOrganPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBonePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBonePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesPrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesPrevDiscussion

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherPrevDiscussion

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherPrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissuePrevDiscussion
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissuePrevDiscussion = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------PrevDiscussion----------------------------------------------------------

------------------------------------------------Begin NotPronounced----------------------------------------------------------
	SET @ReasonID = 16
--**************************************************************************************************************************************************************************************
	-- ApproachOrganNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End NotPronounced----------------------------------------------------------
------------------------------------------------Begin NoJurisdiction----------------------------------------------------------
	SET @ReasonID = 17
--**************************************************************************************************************************************************************************************
	-- ApproachOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End NoJurisdiction----------------------------------------------------------
------------------------------------------------Begin DidNotDie----------------------------------------------------------
	SET @ReasonID = 18
--**************************************************************************************************************************************************************************************
	-- ApproachOrganDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End DidNotDie----------------------------------------------------------
------------------------------------------------Begin Hemodiluted----------------------------------------------------------
	SET @ReasonID = 19
--**************************************************************************************************************************************************************************************
	-- ApproachOrganHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End Hemodiluted----------------------------------------------------------
------------------------------------------------Begin TeamLogistics----------------------------------------------------------
	SET @ReasonID = 20
--**************************************************************************************************************************************************************************************
	-- ApproachOrganTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End TeamLogistics----------------------------------------------------------
------------------------------------------------Begin ConsentRetracted----------------------------------------------------------
	SET @ReasonID = 21
--**************************************************************************************************************************************************************************************
	-- ApproachOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End ConsentRetracted----------------------------------------------------------
------------------------------------------------Begin DeclinedByProcessors----------------------------------------------------------
	SET @ReasonID = 22
--**************************************************************************************************************************************************************************************
	-- ApproachOrganDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOrganDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End DeclinedByProcessors----------------------------------------------------------







--************************************************************************************************************************************************************************************
	-- ApproachRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID NOT IN(1, @DMVReasonID, @DRReasonID) 
	AND		ReferralBoneApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		ReferralTissueApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		ReferralSkinApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		ReferralValvesApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		ReferralEyesTransApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		ReferralEyesRschApproachID NOT IN(1, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_ApproachReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_ApproachReasonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID


	--Update the count statistics
	INSERT INTO Referral_ApproachReasonCount
	SELECT * FROM #_Temp_Referral_ApproachReasonCount 
	ORDER BY YearID, MonthID, OrganizationID

	--Select * from #_Temp_Referral_ApproachReasonCount
	DROP TABLE #_Temp_Referral_ApproachReasonCount
	DROP TABLE #_Temp_Referral_ApproachReasonSelect

/*
--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

*/




GO


