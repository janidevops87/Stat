SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ConversionReasonCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ConversionReasonCount_Archive]
GO



CREATE PROCEDURE [dbo].[spi_Referral_ConversionReasonCount_Archive]

	@MonthID	int,
	@YearID		int

AS
/******************************************************************************
**		File: spi_Referral_ConversionReasonCount_Archive.sql
**		Name: spi_Referral_ConversionReasonCount_Archive
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
**		Date: 08/03/2011
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**      08/03/2010	ccarroll		Updated from Production
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
/*Updated w/tzCASE function 04.0700 [ttw]
  Updated to include use of RegistryStatus table for ver. 7.7.1.  10/13/2004 - SAP

  ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
                        does not permit counting. StatTrac 8.0 Iteration2 release. 

  ccarroll 11/20/2006 - added options for StatTrac 8.2 release
			12. Not Pronounced
			13. No Jurisdiction
			14. Did Not Die
			15. Hemodiluted
			16. Team Logistics
			17. Consent Retracted
			18. Declined By Processors
			19. Family Unapproachable

  SP_HELP 
  spi_Referral_ConversionReasonCount 3, 2000 */


DECLARE

	@ReferralCount		int,
	@ReasonID		int,
	@AprchDMVReasonID	int,
	@AprchDRReasonID	int,
	@ConsntDMVReasonID	int,
	@ConsntDRReasonID	int,
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT	
	--Create the temp table
	CREATE TABLE #_Temp_Referral_ConversionReasonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,

	[ConversionOrgan] [int] NULL Default(0) ,
	[ConversionBone] [int] NULL Default(0) ,
	[ConversionTissue] [int] NULL Default(0) ,
	[ConversionSkin] [int] NULL Default(0) ,
	[ConversionValves] [int] NULL Default(0) ,
	[ConversionEyes] [int] NULL Default(0) ,
	[ConversionOther] [int] NULL Default(0) ,
	[ConversionAllTissue] [int] NULL Default(0) ,

	[ConversionOrganNotRecovered] [int] NULL Default(0) ,
	[ConversionBoneNotRecovered] [int] NULL Default(0) ,
	[ConversionTissueNotRecovered] [int] NULL Default(0) ,
	[ConversionSkinNotRecovered] [int] NULL Default(0) ,
	[ConversionValvesNotRecovered] [int] NULL Default(0) ,
	[ConversionEyesNotRecovered] [int] NULL Default(0) ,
	[ConversionOtherNotRecovered] [int] NULL Default(0) ,
	[ConversionAllTissueNotRecovered] [int] NULL Default(0) ,

	[ConversionOrganCoronerRuleout] [int] NULL Default(0),
	[ConversionBoneCoronerRuleout] [int] NULL Default(0) ,
	[ConversionTissueCoronerRuleout] [int] NULL Default(0) ,
	[ConversionSkinCoronerRuleout] [int] NULL Default(0) ,
	[ConversionValvesCoronerRuleout] [int] NULL Default(0) ,
	[ConversionEyesCoronerRuleout] [int] NULL Default(0) ,
	[ConversionOtherCoronerRuleout] [int] NULL Default(0) ,
	[ConversionAllTissueCoronerRuleout] [int] NULL Default(0) ,

	[ConversionOrganArrest] [int] NULL Default(0) ,
	[ConversionBoneArrest] [int] NULL Default(0) ,
	[ConversionTissueArrest] [int] NULL Default(0) ,
	[ConversionSkinArrest] [int] NULL Default(0) ,
	[ConversionValvesArrest] [int] NULL Default(0) ,
	[ConversionEyesArrest] [int] NULL Default(0) ,
	[ConversionOtherArrest] [int] NULL Default(0) ,
	[ConversionAllTissueArrest] [int] NULL Default(0) ,

	[ConversionOrganNeverBrainDead] [int] NULL Default(0) ,
	[ConversionBoneNeverBrainDead] [int] NULL Default(0) ,
	[ConversionTissueNeverBrainDead] [int] NULL Default(0) ,
	[ConversionSkinNeverBrainDead] [int] NULL Default(0) ,
	[ConversionValvesNeverBrainDead] [int] NULL Default(0) ,
	[ConversionEyesNeverBrainDead] [int] NULL Default(0) ,
	[ConversionOtherNeverBrainDead] [int] NULL Default(0) ,
	[ConversionAllTissueNeverBrainDead] [int] NULL Default(0) ,

	[ConversionOrganMedRO] [int] NULL Default(0) ,
	[ConversionBoneMedRO] [int] NULL Default(0) ,
	[ConversionTissueMedRO] [int] NULL Default(0) ,
	[ConversionSkinMedRO] [int] NULL Default(0) ,
	[ConversionValvesMedRO] [int] NULL Default(0) ,
	[ConversionEyesMedRO] [int] NULL Default(0) ,
	[ConversionOtherMedRO] [int] NULL Default(0) ,
	[ConversionAllTissueMedRO] [int] NULL Default(0) ,

	[ConversionOrganHighRisk] [int] NULL Default(0) ,
	[ConversionBoneHighRisk] [int] NULL Default(0) ,
	[ConversionTissueHighRisk] [int] NULL Default(0) ,
	[ConversionSkinHighRisk] [int] NULL Default(0) ,
	[ConversionValvesHighRisk] [int] NULL Default(0) ,
	[ConversionEyesHighRisk] [int] NULL Default(0) ,
	[ConversionOtherHighRisk] [int] NULL Default(0) ,
	[ConversionAllTissueHighRisk] [int] NULL Default(0) ,

	[ConversionOrganTimeLogistics] [int] NULL Default(0) ,
	[ConversionBoneTimeLogistics] [int] NULL Default(0) ,
	[ConversionTissueTimeLogistics] [int] NULL Default(0) ,
	[ConversionSkinTimeLogistics] [int] NULL Default(0) ,
	[ConversionValvesTimeLogistics] [int] NULL Default(0) ,
	[ConversionEyesTimeLogistics] [int] NULL Default(0) ,
	[ConversionOtherTimeLogistics] [int] NULL Default(0) ,
	[ConversionAllTissueTimeLogistics] [int] NULL Default(0) ,

	[ConversionOrganHeartTxable] [int] NULL Default(0) ,
	[ConversionBoneHeartTxable] [int] NULL Default(0) ,
	[ConversionTissueHeartTxable] [int] NULL Default(0) ,
	[ConversionSkinHeartTxable] [int] NULL Default(0) ,
	[ConversionValvesHeartTxable] [int] NULL Default(0) ,
	[ConversionEyesHeartTxable] [int] NULL Default(0) ,
	[ConversionOtherHeartTxable] [int] NULL Default(0) ,
	[ConversionAllTissueHeartTxable] [int] NULL Default(0) ,

	[ConversionOrganUnknown] [int] NULL Default(0) ,
	[ConversionBoneUnknown] [int] NULL Default(0) ,
	[ConversionTissueUnknown] [int] NULL Default(0) ,
	[ConversionSkinUnknown] [int] NULL Default(0) ,
	[ConversionValvesUnknown] [int] NULL Default(0) ,
	[ConversionEyesUnknown] [int] NULL Default(0) ,
	[ConversionOtherUnknown] [int] NULL Default(0) ,
	[ConversionAllTissueUnknown] [int] NULL Default(0) ,
	[AppropriateRO] [int] NULL  ,

	--drh 10/31/01
	[RegConversionOrgan] [int] NULL Default(0) ,
	[RegConversionBone] [int] NULL Default(0) ,
	[RegConversionTissue] [int] NULL Default(0) ,
	[RegConversionSkin] [int] NULL Default(0) ,
	[RegConversionValves] [int] NULL Default(0) ,
	[RegConversionEyes] [int] NULL Default(0) ,
	[RegConversionOther] [int] NULL Default(0) ,
	[RegConversionAllTissue] [int] NULL Default(0) ,

	[RegConversionOrganNotRecovered] [int] NULL Default(0) ,
	[RegConversionBoneNotRecovered] [int] NULL Default(0) ,
	[RegConversionTissueNotRecovered] [int] NULL Default(0) ,
	[RegConversionSkinNotRecovered] [int] NULL Default(0) ,
	[RegConversionValvesNotRecovered] [int] NULL Default(0) ,
	[RegConversionEyesNotRecovered] [int] NULL Default(0) ,
	[RegConversionOtherNotRecovered] [int] NULL Default(0) ,
	[RegConversionAllTissueNotRecovered] [int] NULL Default(0) ,

	[RegConversionOrganCoronerRuleout] [int] NULL Default(0),
	[RegConversionBoneCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionTissueCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionSkinCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionValvesCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionEyesCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionOtherCoronerRuleout] [int] NULL Default(0) ,
	[RegConversionAllTissueCoronerRuleout] [int] NULL Default(0) ,

	[RegConversionOrganArrest] [int] NULL Default(0) ,
	[RegConversionBoneArrest] [int] NULL Default(0) ,
	[RegConversionTissueArrest] [int] NULL Default(0) ,
	[RegConversionSkinArrest] [int] NULL Default(0) ,
	[RegConversionValvesArrest] [int] NULL Default(0) ,
	[RegConversionEyesArrest] [int] NULL Default(0) ,
	[RegConversionOtherArrest] [int] NULL Default(0) ,
	[RegConversionAllTissueArrest] [int] NULL Default(0) ,

	[RegConversionOrganNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionBoneNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionTissueNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionSkinNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionValvesNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionEyesNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionOtherNeverBrainDead] [int] NULL Default(0) ,
	[RegConversionAllTissueNeverBrainDead] [int] NULL Default(0) ,

	[RegConversionOrganMedRO] [int] NULL Default(0) ,
	[RegConversionBoneMedRO] [int] NULL Default(0) ,
	[RegConversionTissueMedRO] [int] NULL Default(0) ,
	[RegConversionSkinMedRO] [int] NULL Default(0) ,
	[RegConversionValvesMedRO] [int] NULL Default(0) ,
	[RegConversionEyesMedRO] [int] NULL Default(0) ,
	[RegConversionOtherMedRO] [int] NULL Default(0) ,
	[RegConversionAllTissueMedRO] [int] NULL Default(0) ,

	[RegConversionOrganHighRisk] [int] NULL Default(0) ,
	[RegConversionBoneHighRisk] [int] NULL Default(0) ,
	[RegConversionTissueHighRisk] [int] NULL Default(0) ,
	[RegConversionSkinHighRisk] [int] NULL Default(0) ,
	[RegConversionValvesHighRisk] [int] NULL Default(0) ,
	[RegConversionEyesHighRisk] [int] NULL Default(0) ,
	[RegConversionOtherHighRisk] [int] NULL Default(0) ,
	[RegConversionAllTissueHighRisk] [int] NULL Default(0) ,

	[RegConversionOrganTimeLogistics] [int] NULL Default(0) ,
	[RegConversionBoneTimeLogistics] [int] NULL Default(0) ,
	[RegConversionTissueTimeLogistics] [int] NULL Default(0) ,
	[RegConversionSkinTimeLogistics] [int] NULL Default(0) ,
	[RegConversionValvesTimeLogistics] [int] NULL Default(0) ,
	[RegConversionEyesTimeLogistics] [int] NULL Default(0) ,
	[RegConversionOtherTimeLogistics] [int] NULL Default(0) ,
	[RegConversionAllTissueTimeLogistics] [int] NULL Default(0) ,

	[RegConversionOrganHeartTxable] [int] NULL Default(0) ,
	[RegConversionBoneHeartTxable] [int] NULL Default(0) ,
	[RegConversionTissueHeartTxable] [int] NULL Default(0) ,
	[RegConversionSkinHeartTxable] [int] NULL Default(0) ,
	[RegConversionValvesHeartTxable] [int] NULL Default(0) ,
	[RegConversionEyesHeartTxable] [int] NULL Default(0) ,
	[RegConversionOtherHeartTxable] [int] NULL Default(0) ,
	[RegConversionAllTissueHeartTxable] [int] NULL Default(0) ,

	[RegConversionOrganUnknown] [int] NULL Default(0) ,
	[RegConversionBoneUnknown] [int] NULL Default(0) ,
	[RegConversionTissueUnknown] [int] NULL Default(0) ,
	[RegConversionSkinUnknown] [int] NULL Default(0) ,
	[RegConversionValvesUnknown] [int] NULL Default(0) ,
	[RegConversionEyesUnknown] [int] NULL Default(0) ,
	[RegConversionOtherUnknown] [int] NULL Default(0) ,
	[RegConversionAllTissueUnknown] [int] NULL Default(0) ,

	[ConversionOrganFamilyRO] [int] NULL Default(0) ,
	[ConversionBoneFamilyRO] [int] NULL Default(0) ,
	[ConversionTissueFamilyRO] [int] NULL Default(0) ,
	[ConversionSkinFamilyRO] [int] NULL Default(0) ,
	[ConversionValvesFamilyRO] [int] NULL Default(0) ,
	[ConversionEyesFamilyRO] [int] NULL Default(0) ,
	[ConversionOtherFamilyRO] [int] NULL Default(0) ,
	[ConversionAllTissueFamilyRO] [int] NULL Default(0) ,

	[RegConversionOrganFamilyRO] [int] NULL Default(0) ,
	[RegConversionBoneFamilyRO] [int] NULL Default(0) ,
	[RegConversionTissueFamilyRO] [int] NULL Default(0) ,
	[RegConversionSkinFamilyRO] [int] NULL Default(0) ,
	[RegConversionValvesFamilyRO] [int] NULL Default(0) ,
	[RegConversionEyesFamilyRO] [int] NULL Default(0) ,
	[RegConversionOtherFamilyRO] [int] NULL Default(0) ,
	[RegConversionAllTissueFamilyRO] [int] NULL Default(0),

	--drh 2/19/02
	[RegConversionAllTypes] [int] NULL Default(0),

	[ConversionOrganCNR] [int] NULL Default(0) ,
	[ConversionBoneCNR] [int] NULL Default(0) ,
	[ConversionTissueCNR] [int] NULL Default(0) ,
	[ConversionSkinCNR] [int] NULL Default(0) ,
	[ConversionValvesCNR] [int] NULL Default(0) ,
	[ConversionEyesCNR] [int] NULL Default(0) ,
	[ConversionOtherCNR] [int] NULL Default(0) ,
	[ConversionAllTissueCNR] [int] NULL Default(0) ,

	[RegConversionOrganCNR] [int] NULL Default(0) ,
	[RegConversionBoneCNR] [int] NULL Default(0) ,
	[RegConversionTissueCNR] [int] NULL Default(0) ,
	[RegConversionSkinCNR] [int] NULL Default(0) ,
	[RegConversionValvesCNR] [int] NULL Default(0) ,
	[RegConversionEyesCNR] [int] NULL Default(0) ,
	[RegConversionOtherCNR] [int] NULL Default(0) ,
	[RegConversionAllTissueCNR] [int] NULL Default(0),

	--ccarroll added conversion options StatTrac 8.2 release 
	[ConversionOrganNotPronounced] [int] NULL Default(0) ,
	[ConversionBoneNotPronounced] [int] NULL Default(0) ,
	[ConversionTissueNotPronounced] [int] NULL Default(0) ,
	[ConversionSkinNotPronounced] [int] NULL Default(0) ,
	[ConversionValvesNotPronounced] [int] NULL Default(0) ,
	[ConversionEyesNotPronounced] [int] NULL Default(0) ,
	[ConversionOtherNotPronounced] [int] NULL Default(0) ,
	[ConversionAllTissueNotPronounced] [int] NULL Default(0) ,

	[ConversionOrganNoJurisdiction] [int] NULL Default(0) ,
	[ConversionBoneNoJurisdiction] [int] NULL Default(0) ,
	[ConversionTissueNoJurisdiction] [int] NULL Default(0) ,
	[ConversionSkinNoJurisdiction] [int] NULL Default(0) ,
	[ConversionValvesNoJurisdiction] [int] NULL Default(0) ,
	[ConversionEyesNoJurisdiction] [int] NULL Default(0) ,
	[ConversionOtherNoJurisdiction] [int] NULL Default(0) ,
	[ConversionAllTissueNoJurisdiction] [int] NULL Default(0) ,

	[ConversionOrganDidNotDie] [int] NULL Default(0) ,
	[ConversionBoneDidNotDie] [int] NULL Default(0) ,
	[ConversionTissueDidNotDie] [int] NULL Default(0) ,
	[ConversionSkinDidNotDie] [int] NULL Default(0) ,
	[ConversionValvesDidNotDie] [int] NULL Default(0) ,
	[ConversionEyesDidNotDie] [int] NULL Default(0) ,
	[ConversionOtherDidNotDie] [int] NULL Default(0) ,
	[ConversionAllTissueDidNotDie] [int] NULL Default(0) ,

	[ConversionOrganHemodiluted] [int] NULL Default(0) ,
	[ConversionBoneHemodiluted] [int] NULL Default(0) ,
	[ConversionTissueHemodiluted] [int] NULL Default(0) ,
	[ConversionSkinHemodiluted] [int] NULL Default(0) ,
	[ConversionValvesHemodiluted] [int] NULL Default(0) ,
	[ConversionEyesHemodiluted] [int] NULL Default(0) ,
	[ConversionOtherHemodiluted] [int] NULL Default(0) ,
	[ConversionAllTissueHemodiluted] [int] NULL Default(0) ,

	[ConversionOrganTeamLogistics] [int] NULL Default(0) ,
	[ConversionBoneTeamLogistics] [int] NULL Default(0) ,
	[ConversionTissueTeamLogistics] [int] NULL Default(0) ,
	[ConversionSkinTeamLogistics] [int] NULL Default(0) ,
	[ConversionValvesTeamLogistics] [int] NULL Default(0) ,
	[ConversionEyesTeamLogistics] [int] NULL Default(0) ,
	[ConversionOtherTeamLogistics] [int] NULL Default(0) ,
	[ConversionAllTissueTeamLogistics] [int] NULL Default(0) ,

	[ConversionOrganConsentRetracted] [int] NULL Default(0) ,
	[ConversionBoneConsentRetracted] [int] NULL Default(0) ,
	[ConversionTissueConsentRetracted] [int] NULL Default(0) ,
	[ConversionSkinConsentRetracted] [int] NULL Default(0) ,
	[ConversionValvesConsentRetracted] [int] NULL Default(0) ,
	[ConversionEyesConsentRetracted] [int] NULL Default(0) ,
	[ConversionOtherConsentRetracted] [int] NULL Default(0) ,
	[ConversionAllTissueConsentRetracted] [int] NULL Default(0) ,

	[ConversionOrganDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionBoneDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionTissueDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionSkinDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionValvesDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionEyesDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionOtherDeclinedByProcessors] [int] NULL Default(0) ,
	[ConversionAllTissueDeclinedByProcessors] [int] NULL Default(0) ,

	[ConversionOrganUnapproachable] [int] NULL Default(0) ,
	[ConversionBoneUnapproachable] [int] NULL Default(0) ,
	[ConversionTissueUnapproachable] [int] NULL Default(0) ,
	[ConversionSkinUnapproachable] [int] NULL Default(0) ,
	[ConversionValvesUnapproachable] [int] NULL Default(0) ,
	[ConversionEyesUnapproachable] [int] NULL Default(0) ,
	[ConversionOtherUnapproachable] [int] NULL Default(0) ,
	[ConversionAllTissueUnapproachable] [int] NULL Default(0) ,

	-- Registry 
	[RegConversionOrganNotPronounced] [int] NULL Default(0) ,
	[RegConversionBoneNotPronounced] [int] NULL Default(0) ,
	[RegConversionTissueNotPronounced] [int] NULL Default(0) ,
	[RegConversionSkinNotPronounced] [int] NULL Default(0) ,
	[RegConversionValvesNotPronounced] [int] NULL Default(0) ,
	[RegConversionEyesNotPronounced] [int] NULL Default(0) ,
	[RegConversionOtherNotPronounced] [int] NULL Default(0) ,
	[RegConversionAllTissueNotPronounced] [int] NULL Default(0) ,

	[RegConversionOrganNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionBoneNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionTissueNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionSkinNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionValvesNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionEyesNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionOtherNoJurisdiction] [int] NULL Default(0) ,
	[RegConversionAllTissueNoJurisdiction] [int] NULL Default(0) ,

	[RegConversionOrganDidNotDie] [int] NULL Default(0) ,
	[RegConversionBoneDidNotDie] [int] NULL Default(0) ,
	[RegConversionTissueDidNotDie] [int] NULL Default(0) ,
	[RegConversionSkinDidNotDie] [int] NULL Default(0) ,
	[RegConversionValvesDidNotDie] [int] NULL Default(0) ,
	[RegConversionEyesDidNotDie] [int] NULL Default(0) ,
	[RegConversionOtherDidNotDie] [int] NULL Default(0) ,
	[RegConversionAllTissueDidNotDie] [int] NULL Default(0) ,

	[RegConversionOrganHemodiluted] [int] NULL Default(0) ,
	[RegConversionBoneHemodiluted] [int] NULL Default(0) ,
	[RegConversionTissueHemodiluted] [int] NULL Default(0) ,
	[RegConversionSkinHemodiluted] [int] NULL Default(0) ,
	[RegConversionValvesHemodiluted] [int] NULL Default(0) ,
	[RegConversionEyesHemodiluted] [int] NULL Default(0) ,
	[RegConversionOtherHemodiluted] [int] NULL Default(0) ,
	[RegConversionAllTissueHemodiluted] [int] NULL Default(0) ,

	[RegConversionOrganTeamLogistics] [int] NULL Default(0) ,
	[RegConversionBoneTeamLogistics] [int] NULL Default(0) ,
	[RegConversionTissueTeamLogistics] [int] NULL Default(0) ,
	[RegConversionSkinTeamLogistics] [int] NULL Default(0) ,
	[RegConversionValvesTeamLogistics] [int] NULL Default(0) ,
	[RegConversionEyesTeamLogistics] [int] NULL Default(0) ,
	[RegConversionOtherTeamLogistics] [int] NULL Default(0) ,
	[RegConversionAllTissueTeamLogistics] [int] NULL Default(0) ,

	[RegConversionOrganConsentRetracted] [int] NULL Default(0) ,
	[RegConversionBoneConsentRetracted] [int] NULL Default(0) ,
	[RegConversionTissueConsentRetracted] [int] NULL Default(0) ,
	[RegConversionSkinConsentRetracted] [int] NULL Default(0) ,
	[RegConversionValvesConsentRetracted] [int] NULL Default(0) ,
	[RegConversionEyesConsentRetracted] [int] NULL Default(0) ,
	[RegConversionOtherConsentRetracted] [int] NULL Default(0) ,
	[RegConversionAllTissueConsentRetracted] [int] NULL Default(0) ,

	[RegConversionOrganDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionBoneDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionTissueDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionSkinDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionValvesDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionEyesDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionOtherDeclinedByProcessors] [int] NULL Default(0) ,
	[RegConversionAllTissueDeclinedByProcessors] [int] NULL Default(0) ,

	[RegConversionOrganUnapproachable] [int] NULL Default(0) ,
	[RegConversionBoneUnapproachable] [int] NULL Default(0) ,
	[RegConversionTissueUnapproachable] [int] NULL Default(0) ,
	[RegConversionSkinUnapproachable] [int] NULL Default(0) ,
	[RegConversionValvesUnapproachable] [int] NULL Default(0) ,
	[RegConversionEyesUnapproachable] [int] NULL Default(0) ,
	[RegConversionOtherUnapproachable] [int] NULL Default(0) ,
	[RegConversionAllTissueUnapproachable] [int] NULL Default(0) 

	)
CREATE TABLE #_Temp_Referral_ConversionReasonSelect
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
	-- 9/20/04 - SAP
	[RegistryStatus][int] NULL
   )

	--Clean temp table
	TRUNCATE TABLE   #_Temp_Referral_ConversionReasonCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ConversionReasonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

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
               TRUNCATE TABLE   #_Temp_Referral_ConversionReasonSelect

	-- ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
	-- does not permit counting. StatTrac 8.0 Iteration2 release. 

        --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_ConversionReasonSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, RegistryStatus)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, '
	set @strSelectLine = @strSelectLine + ' ReferralOrganAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachOrgan = -1 THEN ReferralOrganApproachID ELSE 0 END AS ReferralOrganApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentOrgan = -1 THEN ReferralOrganConsentID ELSE 0 END AS ReferralOrganConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryOrgan = -1 THEN ReferralOrganConversionID ELSE 0 END AS ReferralOrganConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralBoneAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachBone = -1 THEN ReferralBoneApproachID ELSE 0 END AS ReferralBoneApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentBone = -1 THEN ReferralBoneConsentID ELSE 0 END AS ReferralBoneConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryBone = -1 THEN ReferralBoneConversionID ELSE 0 END AS ReferralBoneConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralTissueAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachTissue = -1 THEN ReferralTissueApproachID ELSE 0 END AS ReferralTissueApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentTissue = -1 THEN ReferralTissueConsentID ELSE 0 END AS ReferralTissueConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryTissue = -1 THEN ReferralTissueConversionID ELSE 0 END AS ReferralTissueConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralSkinAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachSkin = -1 THEN ReferralSkinApproachID ELSE 0 END AS ReferralSkinApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentSkin = -1 THEN ReferralSkinConsentID ELSE 0 END AS ReferralSkinConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoverySkin = -1 THEN ReferralSkinConversionID ELSE 0 END AS ReferralSkinConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralEyesTransAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesTransApproachID ELSE 0 END AS ReferralEyesTransApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesTransConsentID ELSE 0 END AS ReferralEyesTransConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryEyes = -1 THEN ReferralEyesTransConversionID ELSE 0 END AS ReferralEyesTransConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralEyesRschAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesRschApproachID ELSE 0 END AS ReferralEyesRschApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesRschConsentID ELSE 0 END AS ReferralEyesRschConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryEyes = -1 THEN ReferralEyesRschConversionID ELSE 0 END AS ReferralEyesRschConversionID, '
	set @strSelectLine = @strSelectLine + ' ReferralValvesAppropriateID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachValves = -1 THEN ReferralValvesApproachID ELSE 0 END AS ReferralValvesApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentValves = -1 THEN ReferralValvesConsentID ELSE 0 END AS ReferralValvesConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelRecoveryValves = -1 THEN ReferralValvesConversionID ELSE 0 END AS ReferralValvesConversionID, '
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdArchive.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'

	-- ccarroll 10/16/2006 added join to service level - StatTrac 80 Iteration2
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.CallCriteria ON _ReferralProdArchive.dbo.CallCriteria.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.ServiceLevel ON _ReferralProdArchive.dbo.ServiceLevel.ServiceLevelID = _ReferralProdArchive.dbo.CallCriteria.ServiceLevelID'

	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdArchive.dbo.RegistryStatus ON _ReferralProdArchive.dbo.Referral.CallId = _ReferralProdArchive.dbo.RegistryStatus.CallId'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

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
	-- ConversionOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	        ReferralBoneConversionID = @ReasonID
	AND	   	ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOther

--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End Conversion-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
---------------------------------Begin NotRecovered----------------------------------------------------

SET @ReasonID = 1
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- ConversionOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID <> @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	        ReferralBoneConversionID <> @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID <> @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID <> @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValves 

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID <> @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID <> @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID <> @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------End Not Recovered-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--------------------------------Begin CoronerRuleout--------------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- ConversionOrganCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- ConversionBoneCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesCoronerRuleout 
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End CoronerRuleout-------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin Arrest--------------------------------------------------------------

	SET @ReasonID = 3
--**************************************************************************************************************************************************************************************
	-- ConversionOrganArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesArrest 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID

	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End Arrest-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
------------------------------------------------Begin NeverBrainDead----------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- ConversionOrganNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionBoneNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesNeverBrainDead 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
---------------------------------------------End NeverBrainDead----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin MedRO--------------------------------------------------------------
	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- ConversionOrganMedRO
--**************************************************************************************************************************************************************************************


	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesMedRO 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))	
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

----------------------------------------------End MedRO-----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin HighRisk----------------------------------------------------------
	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- ConversionOrganHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable


	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ConversionValvesHighRisk 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End HighRisk----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--------------------------------Begin TimeLogistics-------------------------------------------------------

	SET @ReasonID = 7
--**************************************************************************************************************************************************************************************
	-- ConversionOrganTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionBoneTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesTimeLogistics 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------------------End TimeLogistics----------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin HeartTxable----------------------------------------------------------

	SET @ReasonID = 8
--**************************************************************************************************************************************************************************************
	-- ConversionOrganHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- ConversionBoneHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionSkinHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesHeartTxable 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionEyesHeartTxable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesHeartTxable = CountTable.ReferralCount

	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherHeartTxable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueHeartTxable = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

-------------------------------------------------End HeartTxable-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin Unknown-----------------------------------------------------------------

	SET @ReasonID = 9
--**************************************************************************************************************************************************************************************
	-- ConversionOrganUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesUnknown

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherUnknown

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End Unknown----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin FamilyRO-----------------------------------------------------------------

	SET @ReasonID = 10
--**************************************************************************************************************************************************************************************
	-- ConversionOrganFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesFamilyRO 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesFamilyRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherFamilyRO

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End FamilyRO----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin CNR-----------------------------------------------------------------

	SET @ReasonID = 11
--**************************************************************************************************************************************************************************************
	-- ConversionOrganCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesCNR
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesCNR

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherCNR

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueCNR
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End CNR----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------Begin NotPronounced-----------------------------------------------------------------

	SET @ReasonID = 12
--**************************************************************************************************************************************************************************************
	-- ConversionOrganNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesNotPronounced

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherNotPronounced

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End NotPronounced----------------------------------------------------------------
----------------------------------------------------Begin NoJurisdiction-----------------------------------------------------------------

	SET @ReasonID = 13
--**************************************************************************************************************************************************************************************
	-- ConversionOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesNoJurisdiction

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherNoJurisdiction

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End NoJurisdiction----------------------------------------------------------------
----------------------------------------------------Begin DidNotDie-----------------------------------------------------------------

	SET @ReasonID = 14
--**************************************************************************************************************************************************************************************
	-- ConversionOrganDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesDidNotDie

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherDidNotDie

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End DidNotDie----------------------------------------------------------------
----------------------------------------------------Begin Hemodiluted-----------------------------------------------------------------

	SET @ReasonID = 15
--**************************************************************************************************************************************************************************************
	-- ConversionOrganHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesHemodiluted

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherHemodiluted

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End Hemodiluted----------------------------------------------------------------
----------------------------------------------------Begin TeamLogistics-----------------------------------------------------------------

	SET @ReasonID = 16
--**************************************************************************************************************************************************************************************
	-- ConversionOrganTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesTeamLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherTeamLogistics

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End TeamLogistics----------------------------------------------------------------
----------------------------------------------------Begin ConsentRetracted-----------------------------------------------------------------

	SET @ReasonID = 17
--**************************************************************************************************************************************************************************************
	-- ConversionOrganConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesConsentRetracted

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherConsentRetracted

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End ConsentRetracted----------------------------------------------------------------
----------------------------------------------------Begin DeclinedByProcessors-----------------------------------------------------------------

	SET @ReasonID = 18
--**************************************************************************************************************************************************************************************
	-- ConversionOrganDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesDeclinedByProcessors

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherDeclinedByProcessors

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueDeclinedByProcessors
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueDeclinedByProcessors = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End DeclinedByProcessors----------------------------------------------------------------
----------------------------------------------------Begin Unapproachable-----------------------------------------------------------------

	SET @ReasonID = 19
--**************************************************************************************************************************************************************************************
	-- ConversionOrganUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionOrganUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		ReferralOrganApproachID = 1
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionBoneUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionBoneUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		ReferralBoneApproachID = 1
	AND		ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		ReferralTissueApproachID = 1
	AND		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionSkinUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionSkinUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		ReferralSkinApproachID = 1
	AND		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- ConversionValvesUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionValvesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		ReferralValvesApproachID = 1
	AND		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- ConversionEyesUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		ConversionEyesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		ReferralEyesTransApproachID = 1
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- ConversionOtherUnapproachable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionOtherUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		ReferralEyesRschApproachID = 1
	AND		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- ConversionAllTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionAllTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		((ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID = 1 AND	ReferralBoneConsentID = 1)  
	OR		(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID = 1 AND	ReferralTissueConsentID = 1)
	OR		(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID = 1 AND	ReferralSkinConsentID = 1)
	OR		(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID = 1 AND	ReferralValvesConsentID = 1))
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End Unapproachable----------------------------------------------------------------


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
SET @AprchDRReasonID = 13
SET @ConsntDMVReasonID = 7
SET @ConsntDRReasonID = 8
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- RegConversionOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBone
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	        ReferralBoneConversionID = @ReasonID
	AND	   	ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralBoneAppropriateID = 1
			AND	ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	
			AND	ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)	
			AND	ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	
			AND	ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	
			AND	ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
	-- Added for v. 7.7.1.  9/20/04 - SAP
OR			(
			(ReferralBoneConversionID = @ReasonID AND ReferralBoneAppropriateID = 1
			AND	ReferralBoneConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND	ReferralTissueConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND	ReferralSkinConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND	ReferralValvesConsentID = 1 AND RegistryStatus > 0))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTypes
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralBoneAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralOrganConversionID = @ReasonID AND ReferralOrganAppropriateID = 1
			AND ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralEyesTransConversionID = @ReasonID AND ReferralEyesTransAppropriateID = 1
			AND ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralEyesRschConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralBoneAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralOrganConversionID = @ReasonID AND ReferralOrganAppropriateID = 1
			AND ReferralOrganConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralEyesTransConversionID = @ReasonID AND ReferralEyesTransAppropriateID = 1
			AND ReferralEyesTransConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralEyesRschConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End RegConversion-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------




---------------------------------Begin RegNotRecovered----------------------------------------------------

SET @ReasonID = 1
	-- update the count stats


--**************************************************************************************************************************************************************************************
	-- RegConversionOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID NOT IN(@ReasonID)
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	        ReferralBoneConversionID NOT IN(@ReasonID)
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID NOT IN(@ReasonID)
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID NOT IN(@ReasonID)
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValves 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID NOT IN(@ReasonID)
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID NOT IN(@ReasonID)
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID NOT IN(@ReasonID)
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueNotRecovered = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID NOT IN(@ReasonID) AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralTissueConversionID NOT IN(@ReasonID) AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralSkinConversionID NOT IN(@ReasonID) AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR		
			(ReferralValvesConversionID NOT IN(@ReasonID) AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
	-- Added for 7.7.1 9/20/04 - SAP
	OR		(
			(ReferralBoneConversionID NOT IN(@ReasonID) AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralTissueConversionID NOT IN(@ReasonID) AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralSkinConversionID NOT IN(@ReasonID) AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
	OR		
			(ReferralValvesConversionID NOT IN(@ReasonID) AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------End RegNot Recovered-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--------------------------------Begin RegCoronerRuleout--------------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesCoronerRuleout 
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherCoronerRuleout

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueCoronerRuleout
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueCoronerRuleout = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegCoronerRuleout-------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin RegArrest--------------------------------------------------------------

	SET @ReasonID = 3

--**************************************************************************************************************************************************************************************
	-- RegConversionOrganArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesArrest 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherArrest

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueArrest
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueArrest = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)	AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegArrest-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
------------------------------------------------Begin RegNeverBrainDead----------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesNeverBrainDead 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 


			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherNeverBrainDead

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount

	SET		RegConversionOtherNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueNeverBrainDead
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueNeverBrainDead = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR		
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		-- 9/20/04 - SAP
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR		
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
---------------------------------------------End RegNeverBrainDead----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin RegMedRO--------------------------------------------------------------
	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesMedRO 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))	
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

----------------------------------------------End RegMedRO-----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Begin RegHighRisk----------------------------------------------------------
	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesHighRisk 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

---------------------------------------------End RegHighRisk----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--------------------------------Begin RegTimeLogistics-------------------------------------------------------

	SET @ReasonID = 7
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConversionBoneTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesTimeLogistics 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherTimeLogistics

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueTimeLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueTimeLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND	ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	AND	ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

------------------------------------------------End RegTimeLogistics----------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin RegHeartTxable----------------------------------------------------------

	SET @ReasonID = 8
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- RegConversionBoneHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesHeartTxable 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesHeartTxable

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount

	SET		RegConversionEyesHeartTxable = CountTable.ReferralCount

	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherHeartTxable

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueHeartTxable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueHeartTxable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


-------------------------------------------------End RegHeartTxable-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin RegUnknown-----------------------------------------------------------------

	SET @ReasonID = 9
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConversionSkinUnknown
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesUnknown 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID



--**************************************************************************************************************************************************************************************
	-- RegConversionEyesUnknown

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherUnknown

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherUnknown = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueUnknown
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueUnknown = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID	AND	ReferralEyesRschAppropriateID = 1
			AND	ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	AND	ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID	AND	ReferralTissueAppropriateID = 1
			AND	ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)	AND	ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID	AND	ReferralSkinAppropriateID = 1
			AND	ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	AND	ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID	AND	ReferralValvesAppropriateID = 1
			AND	ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)  	AND	ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR (
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1 
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0) 
			OR 
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1 
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0) 
			OR 
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1 
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0) 
			OR 
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1 
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--------------------------------------------------------End RegUnknown----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

---------------------------------------Begin RegFamilyRO--------------------------------------------------------------

	SET @ReasonID = 10
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesFamilyRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherFamilyRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueFamilyRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueFamilyRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegFamilyRO-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
---------------------------------------Begin RegCNR--------------------------------------------------------------

	SET @ReasonID = 11
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesCNR
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherCNR = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueCNR
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueCNR = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegCNR-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------Begin RegNotPronounced--------------------------------------------------------------

	SET @ReasonID = 12
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesNotPronounced

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherNotPronounced

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherNotPronounced = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueNotPronounced
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueNotPronounced = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegNotPronounced-----------------------------------------------------------------
---------------------------------------Begin RegNoJurisdiction--------------------------------------------------------------

	SET @ReasonID = 13
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesNoJurisdiction

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherNoJurisdiction

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherNoJurisdiction = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueNoJurisdiction
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueNoJurisdiction = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegNoJurisdiction-----------------------------------------------------------------
---------------------------------------Begin RegDidNotDie--------------------------------------------------------------

	SET @ReasonID = 14
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherDidNotDie

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherDidNotDie = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueDidNotDie
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueDidNotDie = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegDidNotDie-----------------------------------------------------------------
---------------------------------------Begin RegHemodiluted--------------------------------------------------------------

	SET @ReasonID = 15
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherHemodiluted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueHemodiluted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueHemodiluted = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegHemodiluted-----------------------------------------------------------------
---------------------------------------Begin RegTeamLogistics--------------------------------------------------------------

	SET @ReasonID = 16
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherTeamLogistics = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueTeamLogistics
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueTeamLogistics = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegTeamLogistics-----------------------------------------------------------------
---------------------------------------Begin RegConsentRetracted--------------------------------------------------------------

	SET @ReasonID = 17
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherConsentRetracted = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueConsentRetracted
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueConsentRetracted = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegConsentRetracted-----------------------------------------------------------------
---------------------------------------Begin RegDeclinedByprocessors--------------------------------------------------------------

	SET @ReasonID = 18
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesDeclinedByprocessors

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueDeclinedByprocessors
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueDeclinedByprocessors = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegDeclinedByprocessors-----------------------------------------------------------------
---------------------------------------Begin RegUnapproachable--------------------------------------------------------------

	SET @ReasonID = 19
--**************************************************************************************************************************************************************************************
	-- RegConversionOrganUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOrganUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralOrganConversionID = @ReasonID
	AND		ReferralOrganAppropriateID = 1
	AND		((ReferralOrganApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralOrganConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionBoneUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionBoneUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralBoneConversionID = @ReasonID
	AND		ReferralBoneAppropriateID = 1
	AND		((ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralBoneConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralTissueConversionID = @ReasonID
	AND		ReferralTissueAppropriateID = 1
	AND		((ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralTissueConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionSkinUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionSkinUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralSkinConversionID = @ReasonID
	AND		ReferralSkinAppropriateID = 1
	AND		((ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralSkinConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

		
--**************************************************************************************************************************************************************************************
	-- RegConversionValvesUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		RegConversionValvesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralValvesConversionID = @ReasonID
	AND		ReferralValvesAppropriateID = 1
	AND		((ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionEyesUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionEyesUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesTransConversionID = @ReasonID
	AND		ReferralEyesTransAppropriateID = 1
	AND		((ReferralEyesTransApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesTransConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesTransConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionOtherUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionOtherUnapproachable = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE		ReferralEyesRschConversionID = @ReasonID
	AND		ReferralEyesRschAppropriateID = 1
	AND		((ReferralEyesRschApproachID IN(@AprchDMVReasonID, @AprchDRReasonID)
	AND		ReferralEyesRschConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
	OR			(ReferralEyesRschConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- RegConversionAllTissueUnapproachable
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_ConversionReasonCount
	SET		RegConversionAllTissueUnapproachable = CountTable.ReferralCount
	FROM		
	(

	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_ConversionReasonSelect
	WHERE	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralBoneConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralTissueConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralSkinConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID))
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesApproachID IN(@AprchDMVReasonID, @AprchDRReasonID) AND ReferralValvesConsentID IN(@ConsntDMVReasonID, @ConsntDRReasonID)))
		OR	(
			(ReferralBoneConversionID = @ReasonID AND ReferralEyesRschAppropriateID = 1
			AND ReferralBoneConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralTissueConversionID = @ReasonID AND ReferralTissueAppropriateID = 1
			AND ReferralTissueConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralSkinConversionID = @ReasonID AND ReferralSkinAppropriateID = 1
			AND ReferralSkinConsentID = 1 AND RegistryStatus > 0)  
			OR
			(ReferralValvesConversionID = @ReasonID AND ReferralValvesAppropriateID = 1
			AND ReferralValvesConsentID = 1 AND RegistryStatus > 0))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End RegUnapproachable-----------------------------------------------------------------

--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************
	--END REGISTERED 
--**************************************************************************************************************************************************************************************
--**************************************************************************************************************************************************************************************














--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_ConversionReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_ConversionReasonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID


	--Update the count statistics
	INSERT INTO Referral_ConversionReasonCount
	SELECT * FROM #_Temp_Referral_ConversionReasonCount 
	ORDER BY YearID, MonthID, OrganizationID

--Select * from #_Temp_Referral_ConversionReasonCount
	DROP TABLE #_Temp_Referral_ConversionReasonCount
        DROP TABLE #_Temp_Referral_ConversionReasonSelect

/*
--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralConversionedByPersonID,
			Count(ReferralConversionedByPersonID) AS ReferralCount
	FROM		_ReferralProdArchive.dbo.Referral
	JOIN		_ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID
	JOIN		_ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID
	WHERE		DATEPART(yyyy, DATEADD(hour, (CASE WHEN	TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZoneAbbreviation = 'CT' THEN 1 WHEN	TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime)) = @YearID
	AND		DATEPART(m, DATEADD(hour, (CASE WHEN TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZoneAbbreviation = 'CT' THEN 1 WHEN TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime)) = @MonthID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralConversionedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ConversionPersonID = CountTable.ReferralConversionedByPersonID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

--************************************************************************************************************************************************************************************
	-- ConversionRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ConversionReasonCount
	SET		ConversionRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		_ReferralProdArchive.dbo.Referral
	JOIN		_ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID
	JOIN		_ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID
	WHERE		DATEPART(yyyy, DATEADD(hour, (CASE WHEN	TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZoneAbbreviation = 'CT' THEN 1 WHEN	TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime)) = @YearID
	AND		DATEPART(m, DATEADD(hour, (CASE WHEN TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZoneAbbreviation = 'CT' THEN 1 WHEN TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime)) = @MonthID
	AND		(ReferralOrganConversionID <> 1 
	AND		ReferralBoneConversionID <> 1
	AND		ReferralTissueConversionID <> 1
	AND		ReferralSkinConversionID <> 1
	AND		ReferralValvesConversionID <> 1
	AND		ReferralEyesTransConversionID <>1
	AND		ReferralEyesRschConversionID <>1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

	AND		YearID = @YearID
	AND		MonthID = @MonthID
*/




GO


