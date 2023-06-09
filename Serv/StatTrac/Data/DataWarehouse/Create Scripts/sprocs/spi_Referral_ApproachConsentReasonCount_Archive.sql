SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachConsentReasonCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachConsentReasonCount_Archive]
GO



CREATE PROCEDURE spi_Referral_ApproachConsentReasonCount_Archive

	@MonthID	int,
	@YearID		int


AS
/******************************************************************************
**		File: spi_Referral_ApproachConsentReasonCount_Archive.sql
**		Name: spi_Referral_ApproachConsentReasonCount_Archive
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
**      08/01/2010	ccarroll		Updated from Production
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE

	@ReferralCount		int,
	@ReasonID		int,
	@DMVReasonID	int,
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
	[SourceCodeID] [int] NULL , 
	[OrganizationID] [int] NULL ,
	[ApproachPersonID] [int] NULL,
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
	[SecondaryScreening] [int] NULL Default(0)
	)

CREATE TABLE #_Temp_Referral_ApproachReasonSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ApproachPersonID] [int] NULL,
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
   [SecondaryReferralID] [int] NULL,
   -- 9/20/04 - SAP
   [RegistryStatus][int] NULL
   )

	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_ApproachReasonCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachReasonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralApproachedByPersonID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Call'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)


--Build a TempTable
            --Clean #_Temp_Referral_?Select
               TRUNCATE TABLE  #_Temp_Referral_ApproachReasonSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year

	set @strSelectLine = 'INSERT #_Temp_Referral_ApproachReasonSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, ReferralID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, SecondaryReferralID, RegistryStatus)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID, _ReferralProdArchive.dbo.Referral.ReferralID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, _ReferralProdArchive.dbo.ReferralSecondaryData.ReferralID as SecondaryReferralID,'
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdArchive.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus '
	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdArchive.dbo.ReferralSecondaryData ON _ReferralProdArchive.dbo.ReferralSecondaryData.ReferralID = _ReferralProdArchive.dbo.Referral.ReferralID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdArchive.dbo.RegistryStatus ON _ReferralProdArchive.dbo.Referral.CallId = _ReferralProdArchive.dbo.RegistryStatus.CallId'
	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, _ReferralProdArchive.dbo.Referral.ReferralID'
	--select @strSelectLine+@strSelectLine2

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID,  
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID,
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesNotApproached 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNotApproached

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNotApproached

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID)
	AND		RegistryStatus = 0)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID


--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNotApproached
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID NOT IN(@ReasonID, @DMVReasonID, @DRReasonID) AND RegistryStatus = 0 AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID IN(@DMVReasonID, @DRReasonID)
	OR			RegistryStatus > 0)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(((ReferralBoneApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID IN(@DMVReasonID, @DRReasonID) OR RegistryStatus > 0) AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDMVRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDMVRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDMVRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID = @DMVReasonID
	OR			RegistryStatus = 1)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDMVRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDMVReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID = @DMVReasonID OR RegistryStatus = 1) AND ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralOrganApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralBoneApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralTissueApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralSkinApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesDRRegistered 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralValvesApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesDRRegistered

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesTransApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherDRRegistered


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		(ReferralEyesRschApproachID = @DRReasonID
	OR			RegistryStatus = 2)
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueDRRegistered
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueDRReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralBoneAppropriateID = 1)
	OR		((ReferralTissueApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralTissueAppropriateID = 1)
	OR		((ReferralSkinApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralSkinAppropriateID = 1)
	OR		((ReferralValvesApproachID = @DRReasonID OR RegistryStatus = 2) AND ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesUnknown

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************

	-- ApproachOtherUnknown


--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesFamilyUnavailable 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesFamilyUnavailable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherFamilyUnavailable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueFamilyUnavailable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueFamilyUnavailable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
	
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesCoronerRuleout 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesArrest 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesMedRO 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTRansAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 

	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesTimeLogistics 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID 
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesNeverBrainDead 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBoneHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValvesHighRisk 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachEyesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

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
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralOrganApproachID = @ReasonID
	AND 		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
	
--**************************************************************************************************************************************************************************************
	-- ApproachBoneUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachBoneUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralBoneApproachID = @ReasonID
	AND 		ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralTissueApproachID = @ReasonID
	AND 		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkinUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachSkinUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralSkinApproachID = @ReasonID
	AND 		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachValvesUnapproachable 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		ApproachValvesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralValvesApproachID = @ReasonID
	AND 		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyesUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount

	SET		ApproachEyesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 


			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesTransApproachID = @ReasonID
	AND 		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOtherUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachOtherUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralEyesRschApproachID = @ReasonID
	AND 		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachReasonCount
	SET		ApproachAllTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		((ReferralBoneApproachID = @ReasonID AND ReferralBoneAppropriateID = 1)
	OR		(ReferralTissueApproachID = @ReasonID AND ReferralTissueAppropriateID = 1)
	OR		(ReferralSkinApproachID = @ReasonID AND ReferralSkinAppropriateID = 1)
	OR		(ReferralValvesApproachID = @ReasonID AND ReferralValvesAppropriateID = 1))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

---------------------------------------------End Unapproachable----------------------------------------------------------
--************************************************************************************************************************************************************************************
	-- ApproachRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID, 

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
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID

--************************************************************************************************************************************************************************************
	-- ApproachRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ApproachReasonCount
	SET		SecondaryScreening = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID,
			Count(SecondaryReferralID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachReasonSelect
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ApproachPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND	#_Temp_Referral_ApproachReasonCount.ApproachPersonID = CountTable.ApproachPersonID
	

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_ApproachReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_ApproachPersonReasonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID


	--Update the count statistics
	INSERT INTO Referral_ApproachPersonReasonCount
	SELECT * FROM #_Temp_Referral_ApproachReasonCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID

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
	SELECT 		ReferralCallerOrganizationID, ApproachPersonID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachReasonSelect
	WHERE		ReferralCallerOrganizationID, ApproachPersonID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

*/
GO


