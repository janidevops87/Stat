SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_CMSReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_CMSReport]
GO


CREATE PROCEDURE spi_Referral_CMSReport
   @MonthID	int,
   @YearID	int

AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
/*
 Updated to include use of RegistryStatus table for ver. 7.7.1.  10/13/2004 - SAP

 ccarroll 05/11/2006, ver 8.0 requirement (4.6.3.5) COP Report
   BrainDeath must be evaluated on the following creitera to be considered true:
	1. CallCustomField11 = 'Yes'
	2. ReferralDonorBrainDeathDate <> Null
	3. ReferralDonorBrainDeathTime <> Null

  ccarroll 08/17/2006 ver 8.0 client requiest per Help Desk 3433
   After viewing report, client wishes to not include changes made above.

  ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
   does not permit counting. StatTrac 8.0 Iteration2 release. 
*/
 
DECLARE
   
   @ReferralCount	int,
   @DayLightStartDate   datetime,
   @DayLightEndDate     datetime,

   @strSelectLine	varchar(8000),
   @strSelectLine2	varchar(8000),
   @strTemp		varchar(2000)

Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

--Create the temp table
	CREATE TABLE #_Temp_Referral_CMSReport
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[Deaths] [int] NULL Default(0) ,
	[DeathsReported] [int] NULL Default(0) ,
	[Approached] [int] NULL Default(0) ,
	[Approached_NonDR] [int] NULL Default(0) ,
	[BDMSuitable] [int] NULL Default(0) ,
	[VentedNotification] [int] NULL Default(0) ,
	[Referral_CT] [int] NULL Default(0) ,
	[Approach_Organ_CT] [int] NULL Default(0) ,
	[Consent_Organ_CT] [int] NULL Default(0) ,
	[Recovery_Organ_CT] [int] NULL Default(0), 
	[Recovery_Organ_All_CT] [int] NULL Default(0), 
	[Goals] [varchar] NULL,
	[Actions] [varchar] NULL
	)


CREATE TABLE #_Temp_Referral_CMSReportSelect
   (
   [CallSourceCodeID] [int] NULL ,
   [ReferralCallerOrganizationID] [int] NULL , 
   [ReferralID] [int] NULL , 
   [ReferralTypeID] [int] NULL ,
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
   [ReferralValvesConversionID] [int] NULL ,
   [DonorRegistryType] [int] NULL,
   [ReferralApproachTypeId] [int] NULL,
   [ReferralDonorDeathDate][SmallDateTime] NULL, 
   [CallCustomField11] [varchar] (40) NULL,
   [CallCustomField12] [varchar] (40) NULL,
   [CallCustomField14] [varchar] (40) NULL,
   [ReferralDonorAge] [varchar] (4) NULL,
   [ReferralDonorOnVentilator] [varchar] (20) NULL,
	-- 9/21/04 - SAP
	[RegistryStatus][int] NULL
   )


	--Clean temp table
	DELETE #_Temp_Referral_CMSReport

	--Store TimeZone CASE string
	exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

--drh 10/08/03 - Replaced custom INSERT with our standard INSERT
--Loop through list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_CMSReport (YearID, MonthID, SourceCodeID, OrganizationID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdReport.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Call JOIN _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + ' ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)



--Build a TempTable
            --Clean #_Temp_Referral_?Select
               DELETE #_Temp_Referral_CMSReportSelect
        --Insert Data into #_Temp_Referral_?Select based on month and year
	-- ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
	-- does not permit counting. StatTrac 8.0 Iteration2 release. 
	set @strSelectLine = 'INSERT #_Temp_Referral_CMSReportSelect '
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, DonorRegistryType, ReferralApproachTypeId, ReferralDonorDeathDate, CallCustomField11, CallCustomField12, CallCustomField14, ReferralDonorAge, ReferralDonorOnVentilator, RegistryStatus)'
	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralTypeID,'
	set @strSelectLine = @strSelectLine + ' ReferralOrganAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachOrgan = -1 THEN ReferralOrganApproachID ELSE 0 END AS ReferralOrganApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentOrgan = -1 THEN ReferralOrganConsentID ELSE 0 END AS ReferralOrganConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryOrgan = -1 THEN ReferralOrganConversionID ELSE 0 END AS ReferralOrganConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralBoneAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachBone = -1 THEN ReferralBoneApproachID ELSE 0 END AS ReferralBoneApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentBone = -1 THEN ReferralBoneConsentID ELSE 0 END AS ReferralBoneConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryBone = -1 THEN ReferralBoneConversionID ELSE 0 END AS ReferralBoneConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralTissueAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachTissue = -1 THEN ReferralTissueApproachID ELSE 0 END AS ReferralTissueApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentTissue = -1 THEN ReferralTissueConsentID ELSE 0 END AS ReferralTissueConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryTissue = -1 THEN ReferralTissueConversionID ELSE 0 END AS ReferralTissueConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralSkinAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachSkin = -1 THEN ReferralSkinApproachID ELSE 0 END AS ReferralSkinApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentSkin = -1 THEN ReferralSkinConsentID ELSE 0 END AS ReferralSkinConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoverySkin = -1 THEN ReferralSkinConversionID ELSE 0 END AS ReferralSkinConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralEyesTransAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesTransApproachID ELSE 0 END AS ReferralEyesTransApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesTransConsentID ELSE 0 END AS ReferralEyesTransConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryEyes = -1 THEN ReferralEyesTransConversionID ELSE 0 END AS ReferralEyesTransConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralEyesRschAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesRschApproachID ELSE 0 END AS ReferralEyesRschApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesRschConsentID ELSE 0 END AS ReferralEyesRschConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryEyes = -1 THEN ReferralEyesRschConversionID ELSE 0 END AS ReferralEyesRschConversionID,'
	set @strSelectLine = @strSelectLine + ' ReferralValvesAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachValves = -1 THEN ReferralValvesApproachID ELSE 0 END AS ReferralValvesApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentValves = -1 THEN ReferralValvesConsentID ELSE 0 END AS ReferralValvesConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryValves = -1 THEN ReferralValvesConversionID ELSE 0 END AS ReferralValvesConversionID,'
	set @strSelectLine = @strSelectLine + ' DonorRegistryType,'
	set @strSelectLine = @strSelectLine + ' ReferralApproachTypeId,'
	set @strSelectLine = @strSelectLine + ' ReferralDonorDeathDate,'
	-- ccarroll 08/17/2006, removed per Help Desk 3433
	-- ccarroll 05/11/2006, ver 8.0 requirment (4.6.3.5) COP Report
	-- was:	set @strSelectLine = @strSelectLine + ' CASE WHEN CallCustomField11 LIKE ''Yes'' AND ReferralDonorBrainDeathDate is not Null AND ReferralDonorBrainDeathTime is not Null THEN ''Yes'' ELSE ''No'' END AS CallCustomField11,'

	set @strSelectLine = @strSelectLine + ' CallCustomField11,'

	set @strSelectLine = @strSelectLine + ' CallCustomField12, CallCustomField14, ReferralDonorAge, ReferralDonorOnVentilator,'
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdReport.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'
	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID'
	-- ccarroll 10/18/2006 added join to SourceCode - Iteration2
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.CallCriteria ON _ReferralProdReport.dbo.CallCriteria.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.ServiceLevel ON _ReferralProdReport.dbo.ServiceLevel.ServiceLevelID = _ReferralProdReport.dbo.CallCriteria.ServiceLevelID'

	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdReport.dbo.CallCustomField ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.CallCustomField.CallID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdReport.dbo.RegistryStatus ON _ReferralProdReport.dbo.Referral.CallId = _ReferralProdReport.dbo.RegistryStatus.CallId'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'


	EXEC(@strSelectLine+@strSelectLine2)

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- Deaths
--**************************************************************************************************************************************************************************************

--drh 10/08/03 Commented this section out; will get from orgdeaths table in sps
/*
	UPDATE	#_Temp_Referral_CMSReport
	SET		Deaths = CountTable.ReferralCount
	FROM		
	(
	SELECT 	OrganizationDeaths.SourceCodeID as 'SCID',
			OrganizationDeaths.OrganizationID as 'OrgID', 
			TotalDeaths As 'ReferralCount', 
			YearID, 
			MonthID
	FROM		OrganizationDeaths
	WHERE 	OrganizationDeaths.YearID=@YearID
	AND 		OrganizationDeaths.MonthID=@MonthID
	GROUP BY	OrganizationDeaths.YearID, OrganizationDeaths.MonthID, OrganizationDeaths.SourceCodeID, OrganizationDeaths.OrganizationID, TotalDeaths
	) AS CountTable
	WHERE	SourceCodeID = CountTable.SCID
	AND		OrganizationID = CountTable.OrgID
	AND 		#_Temp_Referral_CMSReport.YearID=CountTable.YearID
	AND 		#_Temp_Referral_CMSReport.MonthID=CountTable.MonthID
*/


/*
	--NOTE: MH did not touch this commented-out section during the "SourceCode" project.

	UPDATE	#_Temp_Referral_CMSReport
	SET		Deaths = Referral_TypeCount.AllTypes
	FROM		Referral_TypeCount
	WHERE	#_Temp_Referral_CMSReport.OrganizationID = Referral_TypeCount.OrganizationID
	AND 		#_Temp_Referral_CMSReport.YearID = Referral_TypeCount.YearID
	AND 		#_Temp_Referral_CMSReport.MonthID = Referral_TypeCount.MonthID
*/
/*
	UPDATE	#_Temp_Referral_CMSReport
	SET		Deaths = CountTable.ReferralCount
	FROM		
	(
	SELECT 	ReferralCallerOrganizationID, 
			Count(ReferralDonorDeathDate) AS 'ReferralCount'
	FROM		#_Temp_Referral_CMSReportSelect
	GROUP BY	ReferralCallerOrganizationID
	) AS CountTable
	WHERE	OrganizationID = CountTable.ReferralCallerOrganizationID
*/

--**************************************************************************************************************************************************************************************
	-- Deaths Reported
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		DeathsReported = CountTable.DeathsReported
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralDonorDeathDate) AS 'DeathsReported'
	FROM		#_Temp_Referral_CMSReportSelect
	WHERE 		ReferralDonorDeathDate IS NOT NULL
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Approached
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Approached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	Referral_TypeCount.SourceCodeID, Referral_TypeCount.OrganizationID,
			Sum(PreRefFamilyApproach + PreRefFacilityApproach + PostRefApproach + RegistryApproach) AS 'ReferralCount',
			Referral_TypeCount.YearID, 
			Referral_TypeCount.MonthID
    	FROM 		Referral_TypeCount
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
	WHERE		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	AND		Referral_TypeCount.SourceCodeID = Referral_ApproachCount.SourceCodeID							--2/13 drh - Added SC to Join
	GROUP BY	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, Referral_TypeCount.SourceCodeID, Referral_TypeCount.OrganizationID	--2/13 drh - Moved SCId from beginning of Group By
	) AS CountTable
	WHERE		#_Temp_Referral_CMSReport.SourceCodeID = CountTable.SourceCodeID
	AND 		#_Temp_Referral_CMSReport.OrganizationID = CountTable.OrganizationID
	AND 		#_Temp_Referral_CMSReport.YearID=CountTable.YearID
	AND 		#_Temp_Referral_CMSReport.MonthID=CountTable.MonthID

--**************************************************************************************************************************************************************************************
	-- Approached NonDR
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		Referral_TypeCount.SourceCodeID, Referral_TypeCount.OrganizationID,
			Sum(A_PostRef_Approached_NonDR + A_PreRef_Approached_NonDR) AS 'ReferralCount',
			Referral_TypeCount.YearID, 
			Referral_TypeCount.MonthID
    	FROM 		Referral_TypeCount
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
	WHERE		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	AND		Referral_TypeCount.SourceCodeID = Referral_ApproachCount.SourceCodeID							--2/13 drh - Added SC to Join
	GROUP BY	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, Referral_TypeCount.SourceCodeID, Referral_TypeCount.OrganizationID	--2/13 drh - Moved SCId from beginning of Group By
	) AS CountTable
	WHERE		#_Temp_Referral_CMSReport.SourceCodeID = CountTable.SourceCodeID
	AND 		#_Temp_Referral_CMSReport.OrganizationID = CountTable.OrganizationID
	AND 		#_Temp_Referral_CMSReport.YearID=CountTable.YearID
	AND 		#_Temp_Referral_CMSReport.MonthID=CountTable.MonthID

--**************************************************************************************************************************************************************************************
	-- Brain Death Medically Suitable Candidate
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		BDMSuitable = CountTable.ReferralCount
	FROM		
	(	
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, Count(CallCustomField12) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 		CallCustomField11='Yes'
--	AND 		CallCustomField14 in ('N/A', 'No')		---This criteria was changed based on help desk ticket 907. 07/19/2005 CAB
	AND 		CallCustomField14 ='No'
	AND 		Convert(int, ReferralDonorAge) !> 70
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	--  VentedNotification Deaths ('Donor On Ventilator')
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		VentedNotification = CountTable.VentedNotification
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralDonorOnVentilator) AS 'VentedNotification'
	FROM		#_Temp_Referral_CMSReportSelect
	WHERE 		ReferralDonorOnVentilator = 'Currently'
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- Referral Clinical Triggers
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Referral_CT = CountTable.ReferralCount
	FROM		
	(	
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, Count(CallCustomField12) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 		CallCustomField12='Yes'
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- Approach Organ and Clinical Triggers
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Approach_Organ_CT = CountTable.ReferralCount
	FROM		
	(	
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralOrganApproachID) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 		CallCustomField11='Yes'
--	AND 		CallCustomField14 in ('N/A', 'No')		---This criteria was changed based on help desk ticket 907. 07/19/2005 CAB
	AND 		CallCustomField14 ='No'
	AND 		Convert(int, ReferralDonorAge) !> 70
	AND 		(ReferralOrganApproachID in (1, 12, 13)
	OR			RegistryStatus > 0)
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Consent Organ and Clinical Triggers
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Consent_Organ_CT = CountTable.ReferralCount
	FROM		
	(	
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralOrganApproachID) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 		CallCustomField11='Yes'
--	AND 		CallCustomField14 in ('N/A', 'No')		---This criteria was changed based on help desk ticket 907. 07/19/2005 CAB
	AND 		CallCustomField14 ='No'
	AND 		Convert(int, ReferralDonorAge) !> 70
	AND 		(ReferralOrganConsentID in (1, 7, 8)
	OR			RegistryStatus > 0)
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Recovery Organ and Clinical Triggers
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Recovery_Organ_CT = CountTable.ReferralCount
	FROM		
	(	
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralOrganApproachID) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 		CallCustomField11='Yes'
--	AND 		CallCustomField14 in ('N/A', 'No')		---This criteria was changed based on help desk ticket 907. 07/19/2005 CAB
	AND 		CallCustomField14 ='No'
	AND 		Convert(int, ReferralDonorAge) !> 70
	AND 		ReferralOrganConversionID = 1
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID

	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID




--**************************************************************************************************************************************************************************************
	-- Recovery Organ All 
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_CMSReport
	SET		Recovery_Organ_All_CT = CountTable.ReferralCount
	FROM		
	(	
	SELECT	CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralOrganApproachID) AS 'ReferralCount'
	FROM  		#_Temp_Referral_CMSReportSelect
	WHERE 	ReferralOrganConversionID = 1
	GROUP BY	CallSourceCodeID, ReferralCallerOrganizationID

	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID





--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_AppropriateReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_CMSReport
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics

	INSERT INTO Referral_CMSReport
	SELECT * FROM #_Temp_Referral_CMSReport
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

	DROP TABLE #_Temp_Referral_CMSReport
	DROP TABLE #_Temp_Referral_CMSReportSelect





GO


