IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ReferralOutcomeReport')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ReferralOutcomeReport';
	DROP Procedure sps_rpt_ReferralOutcomeReport;
END
GO 

PRINT 'Creating Procedure sps_rpt_ReferralOutcomeReport';
GO
CREATE Procedure [dbo].[sps_rpt_ReferralOutcomeReport]
	@CallID						INT				= NULL,
	@DateType					INT				= 1,	-- 2 = CardiacDateTime (Referral.ReferralDonorDeathDate), 1 = ReferralDateTime(Call.CallDateTime)
	@StartDateTime				SMALLDATETIME	= NULL,
	@EndDateTime				SMALLDATETIME	= NULL,
	
	@PatientFirstName			VARCHAR(40)		= NULL,
	@PatientLastName			VARCHAR(40)		= NULL,
	@MedicalRecordNumber		VARCHAR(30)		= NULL,
	@ReferralType				INT				= NULL,		
	@CauseOfDeath				INT				= NULL,

	@ReportGroupID				INT				= NULL,
	@OrganizationID				INT				= NULL,
	@SourceCodeName				VARCHAR(10)		= NULL,
	@CoordinatorID				INT				= NULL,
	@LowerAgeLimit				INT				= NULL,
	@UpperAgeLimit				INT				= NULL,
	@Gender						VARCHAR(1)		= NULL,
	@Race						VARCHAR(20)		= NULL,

	@UserOrgID					INT				= NULL,
	@DisplayMT					INT				= NULL,
	@FS_Link					INT				= NULL,
	@Type_Outcome				VARCHAR(50)		= NULL,
	@ApproachPersonID			INT				= NULL,
	@ReferralCallerOrgID		INT				= NULL,
	@ReferralCallerPersonID		INT				= NULL

AS
/******************************************************************************
**		File: sps_rpt_ReferralOutcomeReport.sql
**		Name: sps_rpt_ReferralOutcomeReport
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   ReferralOutcome.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: Mike Berenson
**		Date: 10/12/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/27/2007	ccarroll			Initial release
**		04/07/2008	Bret				Added @listTable and adjusted DeathDateConversion	
**		04/29/2008	Jim			        Replace @listTable with dbo.fn_rpt_ReferralDateTimeConversion
**		08/25/2008	ccarroll			Added section for OutcomeByCcategory report (FS_Link 100-400)
**		09/18/2008	ccarroll			Added section for InitialApproacherSummary report (FS_Link 500)
**		09/23/2008	ccarroll			Added section for ReferralTypeSummaryByFacility report (FS_Link 600)
**		09/25/2008	ccarroll			Added selection for Archive data
**		10/22/2008	ccarroll			Added section for ReferralFacilityCompliance report (FS_Link 700)
**		04/19/2010	James Gerberich		Added section for RaceDemographics report (FS_Link 800, @Race)
**		04/20/2010	James Gerberich		Added section for Age Demographics report (FS_Link 900)
**		04/20/2010	James Gerberich		Added Section for Referral Statistics by Caller report (FS_Link 1000)
**											and added ReferralFacilityID and ReferralPersonID fields and parameters
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**      12/12/2016  Mike Berenson		Added DLA Registry
**		06/22/2020	Mike Berenson		Added to source control
**		06/22/2020	Mike Berenson		Formatted to meet coding standards
**		06/22/2020	Mike Berenson		Refactored for improved maintenance & performance
**		06/24/2020	Mike Berenson		Refactored - round 2
**		10/12/2020	Mike Berenson		Created new file (ReferralOutcomeReport.sql from ReferralOutcome.sql)
**		10/19/2020	Mike Berenson		Changed start & end date types (to match types in tables)
**		01/29/2021	James Gerberich		Added Timely calculation and additional FS_Link logic for
**											Timely Referral report.
**		02/04/2021	James Gerberich		Added FS_Link Logic for Initial Approacher Summary total referrals
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

IF @CallID IS NOT NULL
BEGIN
	SELECT
		@StartDateTime			= NULL,
		@EndDateTime			= NULL,
		@PatientFirstName		= NULL,
		@PatientLastName		= NULL,
		@MedicalRecordNumber	= NULL,
		@ReferralType			= NULL,
		@SourceCodeName			= NULL,
		@CoordinatorID			= NULL,
		@LowerAgeLimit			= NULL,
		@UpperAgeLimit			= NULL,
		@Gender					= NULL;
END	

SELECT 	
	@ReferralType = CASE WHEN @ReferralType = 0 THEN NULL ELSE @ReferralType END,
	@CauseOfDeath = CASE WHEN @CauseOfDeath = 0 THEN NULL ELSE @CauseOfDeath END;

/* Allow wildcard search using asteric [*]  */
SELECT
	@PatientFirstName = CASE WHEN @PatientFirstName IS NOT NULL THEN REPLACE(@PatientFirstName,'*','%') END,
	@PatientLastName = CASE WHEN @PatientLastName IS NOT NULL THEN REPLACE(@PatientLastName,'*','%') END,
	@MedicalRecordNumber = CASE WHEN @MedicalRecordNumber IS NOT NULL THEN REPLACE(@MedicalRecordNumber,'*','%') END;

DROP TABLE IF EXISTS #_Temp_Referral_Outcome;

CREATE TABLE #_Temp_Referral_Outcome
   (
	[CallID][INT] NULL, 
	[PreliminaryRefType] [VARCHAR] (500) NULL,
	[ReferralTypeID][INT] NULL,
	[BasedOnDT] [datetime] NULL,
	[Timely] [INT] NULL,
	[ReferralFacility] [VARCHAR] (500) NULL,
	[HospitalUnit] [VARCHAR] (500) NULL,
	[Floor] [VARCHAR] (500) NULL,
	[ReferralPersonID] [INT] NULL,
	[ReferralPerson] [VARCHAR] (500) NULL,
	[InitialApproachType] [VARCHAR] (500) NULL,
	[InitialConsent] [VARCHAR] (500) NULL,
	[ReferralApproachedByPersonID] [INT] NULL,
	[InitialApproacher] [VARCHAR] (500) NULL,
	[FinalApproachType] [VARCHAR] (500) NULL,
	[FinalApproachOutcome] [VARCHAR] (500) NULL,
	[FinalApproacher] [VARCHAR] (500) NULL,
	[PatientName] [VARCHAR] (500) NULL,
	[PatientGender] [VARCHAR] (500) NULL, 
	[PatientAge] [VARCHAR] (500) NULL, 
	[PatientRace] [VARCHAR] (500) NULL, 
	[MedicalRecordNumber] [VARCHAR] (500) NULL, 
	[RegistryStatus] [VARCHAR] (500) NULL,
	[CauseOfDeath] [VARCHAR] (500) NULL,
	[CardiacDeathDateTime] [VARCHAR] (500) NULL,
	[ReferralDonorDeathDate] [smalldatetime] NULL,
	[AppropriateOrgan] [VARCHAR] (500) NULL, 
	[ApproachOrgan] [VARCHAR] (500) NULL, 
	[ConsentOrgan] [VARCHAR] (500) NULL, 
	[RecoveryOrgan] [VARCHAR] (500) NULL,
	[AppropriateBone] [VARCHAR] (500) NULL, 
	[ApproachBone] [VARCHAR] (500) NULL, 
	[ConsentBone] [VARCHAR] (500) NULL, 
	[RecoveryBone] [VARCHAR] (500) NULL,
    [AppropriateTissue] [VARCHAR] (500) NULL, 
	[ApproachTissue] [VARCHAR] (500) NULL, 
	[ConsentTissue] [VARCHAR] (500) NULL, 
	[RecoveryTissue] [VARCHAR] (500) NULL, 
	[AppropriateSkin] [VARCHAR] (500) NULL, 
	[ApproachSkin] [VARCHAR] (500) NULL, 
	[ConsentSkin] [VARCHAR] (500) NULL, 
	[RecoverySkin] [VARCHAR] (500) NULL, 
	[AppropriateValve] [VARCHAR] (500) NULL, 
	[ApproachValve] [VARCHAR] (500) NULL, 
	[ConsentValve] [VARCHAR] (500) NULL, 
	[RecoveryValve] [VARCHAR] (500) NULL, 
	[AppropriateEyes] [VARCHAR] (500) NULL, 
	[ApproachEyes] [VARCHAR] (500) NULL, 
	[ConsentEyes] [VARCHAR] (500) NULL, 
	[RecoveryEyes] [VARCHAR] (500) NULL, 
	[AppropriateOther] [VARCHAR] (500) NULL,
	[ApproachOther] [VARCHAR] (500) NULL,
	[ConsentOther] [VARCHAR] (500) NULL,
	[RecoveryOther] [VARCHAR] (500) NULL,
	[PatientLastName] [VARCHAR] (500) NULL,
	[PatientFirstName] [VARCHAR] (500) NULL,
	[ReferralCallerOrganizationID] [INT] NULL,
	[SourceCodeID] [INT] NULL,
	[SourceCodeName] [VARCHAR] (500) NULL,	
	[ReferralGeneralConsent] [SMALLINT] NULL ,
	[ReferralApproachTypeID] [INT] NULL ,
	[ReferralOrganAppropriateID] [INT] NULL ,
	[ReferralOrganApproachID] [INT] NULL ,
	[ReferralOrganConsentID] [INT] NULL ,
	[ReferralOrganConversionID] [INT] NULL ,
	[ReferralBoneAppropriateID] [INT] NULL ,
	[ReferralBoneApproachID] [INT] NULL ,
	[ReferralBoneConsentID] [INT] NULL ,
	[ReferralBoneConversionID] [INT] NULL ,
	[ReferralTissueAppropriateID] [INT] NULL ,
	[ReferralTissueApproachID] [INT] NULL ,
	[ReferralTissueConsentID] [INT] NULL ,
	[ReferralTissueConversionID] [INT] NULL ,
	[ReferralSkinAppropriateID] [INT] NULL ,
	[ReferralSkinApproachID] [INT] NULL ,
	[ReferralSkinConsentID] [INT] NULL ,
	[ReferralSkinConversionID] [INT] NULL ,
	[ReferralEyesTransAppropriateID] [INT] NULL ,
	[ReferralEyesTransApproachID] [INT] NULL ,
	[ReferralEyesTransConsentID] [INT] NULL ,
	[ReferralEyesTransConversionID] [INT] NULL ,
	[ReferralEyesRschAppropriateID] [INT] NULL ,
	[ReferralEyesRschApproachID] [INT] NULL ,
	[ReferralEyesRschConsentID] [INT] NULL ,
	[ReferralEyesRschConversionID] [INT] NULL ,
	[ReferralValvesAppropriateID] [INT] NULL ,
	[ReferralValvesApproachID] [INT] NULL ,
	[ReferralValvesConsentID] [INT] NULL ,
	[ReferralValvesConversionID] [INT] NULL, 
	[FSCaseBillSecondaryUserID][INT] NULL ,
	[FSCaseBillApproachUserID][INT] NULL ,
	[FSCaseBillMedSocUserID][INT] NULL ,
	[FSCaseBillFamUnavailUserID][INT] NULL ,
	[FSCaseBillCryoFormUserID][INT] NULL ,
	[FSCaseBillApproachCount][INT] NULL ,
	[FSCaseBillMedSocCount][INT] NULL ,
	[FSCaseBillCryoFormCount][INT] NULL,
	[RegistryStatusID][INT] NULL
	);
      
INSERT #_Temp_Referral_Outcome 
EXEC sps_rpt_ReferralOutcomeReport_Select
			@CallID,
			@DateType,
			@StartDateTime,
			@EndDateTime, 

			@PatientFirstName,
			@PatientLastName,
			@MedicalRecordNumber,
			@ReferralType, 
			@CauseOfDeath, 

			@ReportGroupID, 
			@OrganizationID, 
			@SourceCodeName, 
			@CoordinatorID, 
			@LowerAgeLimit, 
			@UpperAgeLimit, 
			@Gender, 

			@UserOrgID, 
			@DisplayMT




-- NOT from Billable...stand alone
IF @FS_Link = 0
BEGIN
SELECT	*
FROM	#_Temp_Referral_Outcome;
END

-- SecondaryOTE
ELSE IF @FS_Link = 1 
BEGIN
SELECT	*
FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0);
END

-- SecondaryTissue
-- SecondaryTE 	
ELSE IF @FS_Link = 2
BEGIN
SELECT	*
FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	
	AND 	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID <> 1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1);
END

-- SecondaryTE 	
ELSE IF @FS_Link = 3 
BEGIN
SELECT	*
FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND 	(ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1);
END

-- SecondaryEye	
ELSE IF @FS_Link = 4 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1;
END

-- SecondaryOtherEye
ELSE IF @FS_Link = 5 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(ReferralTypeID = 4 OR ReferralTypeID = 3)
	AND	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND ReferralOrganAppropriateID <> 1  
	AND ReferralEyesTransAppropriateID = 1	
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1;
END

-- SecondaryOther
ELSE IF @FS_Link = 6 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1;
END

-- SecondaryROTotal
ELSE IF @FS_Link = 7 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND	(ReferralOrganAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1 
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesTransAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1);
END

-- FamilyUnavailableOTE	
ELSE IF @FS_Link = 8 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (ReferralOrganApproachID = 1)
	AND ((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	OR ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	--AND ( ReferralOrganApproachID = 3 
	AND	(ReferralBoneApproachID = 3
	OR 	ReferralTissueApproachID = 3
	OR 	ReferralValvesApproachID = 3
	OR 	ReferralEyesTransApproachID = 3
	OR 	ReferralEyesRschApproachID = 3)));
END

-- FamilyUnavailableTissue
ELSE IF @FS_Link = 9 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE 	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR      ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID = 3
	OR	 	ReferralBoneApproachID = 3  
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3
	OR	 	ReferralEyesTransApproachID = 3	
	OR	 	ReferralEyesRschApproachID = 3)))
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID <> 1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1);
END

-- FamilyUnavailableTE	
ELSE IF @FS_Link = 10 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3
	OR	 	ReferralEyesRschApproachID = 3)))
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID = 1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1);
END

-- FamilyUnavailableEye	
ELSE IF @FS_Link = 11 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE ((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR	 	ReferralEyesRschApproachID = 3)))
	AND ReferralOrganApproachID <> 1  
	AND ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1;
END

-- FamilyUnavailableOtherEye
ELSE IF @FS_Link = 12 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3))) 
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1;
END

-- FamilyUnavailableOther
ELSE IF @FS_Link = 13 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3)))
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID <> 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1;
END

-- FamilyUnavailableROTotal
ELSE IF @FS_Link = 14 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
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
	AND	ReferralEyesRschApproachID <> 1);
END

-- FamilyApproachOTE
ELSE IF @FS_Link = 15 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (ReferralOrganApproachID = 1)
	AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND	(ReferralBoneApproachID <> 3
	OR 	ReferralTissueApproachID <> 3
	OR 	ReferralValvesApproachID <> 3
	OR 	ReferralSkinApproachID <> 3
	OR 	ReferralEyesTransApproachID <> 3
	OR 	ReferralEyesRschApproachID <> 3);
END

-- FamilyApproachTissue
ELSE IF @FS_Link = 16 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID <> 1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1);
END

-- FamilyApproachTE 	
ELSE IF @FS_Link = 17 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID = 1
	AND 	( ReferralBoneApproachID = 1 
	OR 		ReferralTissueApproachID = 1
	OR 		ReferralSkinApproachID = 1
	OR 		ReferralValvesApproachID = 1);
END
-- FamilyApproachEye	
ELSE IF @FS_Link = 18 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesRschApproachID <> 3)
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1;
END

-- FamilyApproachOtherEye
ELSE IF @FS_Link = 19 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3)
	AND 	ReferralOrganAppropriateID <> 1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1;
END

-- FamilyApproachOther
ELSE IF @FS_Link = 20 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3)	
	AND 	ReferralOrganApproachID <> 1  
	AND 	ReferralEyesTransApproachID <> 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1;
END

-- FamilyApproachROTotal
ELSE IF @FS_Link = 21 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
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
	AND	ReferralEyesRschApproachID <> 1);
END

-- MedSocOTE
ELSE IF @FS_Link = 29 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND     ReferralOrganConsentID = 1;
END

-- MedSocTissue
ELSE IF @FS_Link = 30 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID <> 1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1);
END

-- MedSocTE 	
ELSE IF @FS_Link = 31 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID = 1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1);
END

-- MedSocEye	
ELSE IF @FS_Link = 32 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID = 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1;
END

-- MedSocOtherEye
ELSE IF @FS_Link = 33 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	 (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <> 1 
	AND 	ReferralEyesTransConsentID = 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1;
END

-- MedSocOther
ELSE IF @FS_Link = 34 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <> 1 
	AND 	ReferralEyesTransConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1;
END

-- MedSocROTotal
ELSE IF @FS_Link = 35 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1);
END

-- CryolifeFormOTE
ELSE IF @FS_Link = 43 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND		ReferralOrganConsentID = 1;
END

-- CryolifeFormTissue
ELSE IF @FS_Link = 44 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID <> 1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1);
END

-- CryolifeFormTE 	
ELSE IF @FS_Link = 45 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID = 1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1);
END

-- CryolifeFormEye	
ELSE IF @FS_Link = 46 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <> 1  
	AND 	ReferralEyesTransConsentID = 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1;
END

-- CryolifeFormOtherEye
ELSE IF @FS_Link = 47 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <> 1 
	AND 	ReferralEyesTransConsentID = 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1;
END

-- CryolifeFormOther
ELSE IF @FS_Link = 48 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <> 1 
	AND 	ReferralEyesTransConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1;
END

-- CryolifeFormROTotal
ELSE IF @FS_Link = 49 
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome
	WHERE	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1);
END

/* OutcomeByCategory Report Options 
FS_Link option key
	[(1)Registry, (2)Ruleout (3)Total Registry (4)Total Ruleout]
	[(0)Appropriate, (1)Approach, (2)Consent, (3)Recovery]
	[(0-6)Column ordinal] 
*/

-- Appropriate, Approach, Consent & Recovery
ELSE IF @FS_Link >= 100 AND @FS_Link <= 136
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome AS tro
		LEFT JOIN RegistryStatusType rst ON tro.RegistryStatusID = rst.ID
	WHERE
		CASE WHEN tro.RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE rst.RegistryType END = @Type_Outcome
		AND	(
				(	@FS_Link = 100 AND ReferralOrganAppropriateID = 1)		-- Sender: Organ Appropriate column
				OR (@FS_Link = 101 AND ReferralBoneAppropriateID = 1)		-- Sender: Bone Appropriate column
				OR (@FS_Link = 102 AND ReferralTissueAppropriateID = 1)		-- Sender: Soft_Tissue Appropriate column
				OR (@FS_Link = 103 AND ReferralSkinAppropriateID = 1)		-- Sender: Skin Appropriate column
				OR (@FS_Link = 104 AND ReferralValvesAppropriateID = 1)		-- Sender: Valves Appropriate column
				OR (@FS_Link = 105 AND ReferralEyesTransAppropriateID = 1)	-- Sender: Eyes Appropriate column
				OR (@FS_Link = 106 AND ReferralEyesRschAppropriateID = 1)	-- Sender: Other Appropriate column
				OR (@FS_Link = 110 AND ReferralOrganApproachID = 1)			-- Sender: Organ Approach column
				OR (@FS_Link = 111 AND ReferralBoneApproachID = 1)			-- Sender: Bone Approach column
				OR (@FS_Link = 112 AND ReferralTissueApproachID = 1)		-- Sender: Soft_Tissue Approach column
				OR (@FS_Link = 113 AND ReferralSkinApproachID = 1)			-- Sender: Skin Approach column
				OR (@FS_Link = 114 AND ReferralValvesApproachID = 1)		-- Sender: Valves Approach column
				OR (@FS_Link = 115 AND ReferralEyesTransApproachID = 1)		-- Sender: Eyes Approach column
				OR (@FS_Link = 116 AND ReferralEyesRschApproachID = 1)		-- Sender: Other Approach column
				OR (@FS_Link = 120 AND ReferralOrganConsentID = 1)			-- Sender: Organ Consent column
				OR (@FS_Link = 121 AND ReferralBoneConsentID = 1)			-- Sender: Bone Consent column
				OR (@FS_Link = 122 AND ReferralTissueConsentID = 1)			-- Sender: Soft_Tissue Consent column
				OR (@FS_Link = 123 AND ReferralSkinConsentID = 1)			-- Sender: Skin Consent column
				OR (@FS_Link = 124 AND ReferralValvesConsentID = 1)			-- Sender: Valves Consent column
				OR (@FS_Link = 125 AND ReferralEyesTransConsentID = 1)		-- Sender: Eyes Consent column
				OR (@FS_Link = 126 AND ReferralEyesRschConsentID = 1)		-- Sender: Other Consent column
				OR (@FS_Link = 130 AND ReferralOrganConversionID = 1)		-- Sender: Organ Recovery column
				OR (@FS_Link = 131 AND ReferralBoneConversionID = 1)		-- Sender: Bone Recovery column
				OR (@FS_Link = 132 AND ReferralTissueConversionID = 1)		-- Sender: Recovery Consent column
				OR (@FS_Link = 133 AND ReferralSkinConversionID = 1)		-- Sender: Skin Recovery column
				OR (@FS_Link = 134 AND ReferralValvesConversionID = 1)		-- Sender: Valves Recovery column
				OR (@FS_Link = 135 AND ReferralEyesTransConversionID = 1)	-- Sender: Eyes Recovery column
				OR (@FS_Link = 136 AND ReferralEyesRschConversionID = 1)	-- Sender: Other Recovery column
			);
END

/* Grouping Code 2 - Disposition ruleout reason - Appropriate, Approach, Consent & Recovery */
ELSE IF @FS_Link >= 200 AND @FS_Link <= 236
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
		LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = TempReferralOutcome.ReferralOrganAppropriateID
		LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = TempReferralOutcome.ReferralBoneAppropriateID
		LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = TempReferralOutcome.ReferralTissueAppropriateID 
		LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = TempReferralOutcome.ReferralSkinAppropriateID 
		LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = TempReferralOutcome.ReferralValvesAppropriateID 
		LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = TempReferralOutcome.ReferralEyesTransAppropriateID 
		LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = TempReferralOutcome.ReferralEyesRschAppropriateID 
		LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = TempReferralOutcome.ReferralOrganApproachID 
		LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = TempReferralOutcome.ReferralBoneApproachID 
		LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = TempReferralOutcome.ReferralTissueApproachID 
		LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = TempReferralOutcome.ReferralSkinApproachID 
		LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = TempReferralOutcome.ReferralValvesApproachID 
		LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = TempReferralOutcome.ReferralEyesTransApproachID 
		LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = TempReferralOutcome.ReferralEyesRschApproachID 
		LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = TempReferralOutcome.ReferralOrganConsentID 
		LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = TempReferralOutcome.ReferralBoneConsentID 
		LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = TempReferralOutcome.ReferralTissueConsentID 
		LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = TempReferralOutcome.ReferralSkinConsentID 
		LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = TempReferralOutcome.ReferralValvesConsentID 
		LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = TempReferralOutcome.ReferralEyesTransConsentID 
		LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = TempReferralOutcome.ReferralEyesRschConsentID 
		LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = TempReferralOutcome.ReferralOrganConversionID
		LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = TempReferralOutcome.ReferralBoneConversionID
		LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = TempReferralOutcome.ReferralTissueConversionID 
		LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = TempReferralOutcome.ReferralSkinConversionID 
		LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = TempReferralOutcome.ReferralValvesConversionID 
		LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = TempReferralOutcome.ReferralEyesTransConversionID 
		LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = TempReferralOutcome.ReferralEyesRschConversionID 
	WHERE
		(
			(	@FS_Link = 200	AND ReferralOrganAppropriateID > 1		AND AppropOrgan.AppropriateName = @Type_Outcome)	-- Sender: Organ column
			OR (@FS_Link = 201	AND ReferralBoneAppropriateID > 1		AND AppropBone.AppropriateName = @Type_Outcome)		-- Sender: Bone column
			OR (@FS_Link = 202	AND ReferralTissueAppropriateID > 1		AND AppropTissue.AppropriateName = @Type_Outcome)	-- Sender: Tissue column
			OR (@FS_Link = 203	AND ReferralSkinAppropriateID > 1		AND AppropSkin.AppropriateName = @Type_Outcome)		-- Sender: Skin column
			OR (@FS_Link = 204	AND ReferralValvesAppropriateID > 1		AND AppropValve.AppropriateName = @Type_Outcome)	-- Sender: Valves column
			OR (@FS_Link = 205	AND ReferralEyesTransAppropriateID > 1	AND AppropEyes.AppropriateName = @Type_Outcome)		-- Sender: Eyes column
			OR (@FS_Link = 206	AND ReferralEyesRschAppropriateID > 1	AND AppropRsch.AppropriateName = @Type_Outcome)		-- Sender: Other column
			OR (@FS_Link = 210	AND ReferralOrganApproachID > 1			AND ApproaOrgan.ApproachName = @Type_Outcome)		-- Sender: Organ column
			OR (@FS_Link = 211	AND ReferralBoneApproachID > 1			AND ApproaBone.ApproachName = @Type_Outcome)		-- Sender: Bone column
			OR (@FS_Link = 212	AND ReferralTissueApproachID > 1		AND ApproaTissue.ApproachName = @Type_Outcome)		-- Sender: Tissue column
			OR (@FS_Link = 213	AND ReferralSkinApproachID > 1			AND ApproaSkin.ApproachName = @Type_Outcome)		-- Sender: Skin column
			OR (@FS_Link = 214	AND ReferralValvesApproachID > 1		AND ApproaValve.ApproachName = @Type_Outcome)		-- Sender: Valves column
			OR (@FS_Link = 215	AND ReferralEyesTransApproachID > 1		AND ApproaEyes.ApproachName = @Type_Outcome)		-- Sender: Eyes column
			OR (@FS_Link = 216	AND ReferralEyesRschApproachID > 1		AND ApproaRsch.ApproachName = @Type_Outcome)		-- Sender: Other column
			OR (@FS_Link = 220	AND ReferralOrganConsentID > 1			AND ConsentOrgan.ConsentName = @Type_Outcome)		-- Sender: Organ column
			OR (@FS_Link = 221	AND ReferralBoneConsentID > 1			AND ConsentBone.ConsentName = @Type_Outcome)		-- Sender: Bone column
			OR (@FS_Link = 222	AND ReferralTissueConsentID > 1			AND ConsentTissue.ConsentName = @Type_Outcome)		-- Sender: Tissue column
			OR (@FS_Link = 223	AND ReferralSkinConsentID > 1			AND ConsentSkin.ConsentName = @Type_Outcome)		-- Sender: Skin column
			OR (@FS_Link = 224	AND ReferralValvesConsentID > 1			AND ConsentValve.ConsentName = @Type_Outcome)		-- Sender: Valves column
			OR (@FS_Link = 225	AND ReferralEyesTransConsentID > 1		AND ConsentEyes.ConsentName = @Type_Outcome)		-- Sender: Eyes column
			OR (@FS_Link = 226	AND ReferralEyesRschConsentID > 1		AND ConsentRsch.ConsentName = @Type_Outcome)		-- Sender: Other column
			OR (@FS_Link = 230	AND ReferralOrganConversionID > 1		AND RecoveryOrgan.ConversionName = @Type_Outcome)	-- Sender: Organ column
			OR (@FS_Link = 231	AND ReferralBoneConversionID > 1		AND RecoveryBone.ConversionName = @Type_Outcome)	-- Sender: Bone column
			OR (@FS_Link = 232	AND ReferralTissueConversionID > 1		AND RecoveryTissue.ConversionName = @Type_Outcome)	-- Sender: Tissue column
			OR (@FS_Link = 233	AND ReferralSkinConversionID > 1		AND RecoverySkin.ConversionName = @Type_Outcome)	-- Sender: Skin column
			OR (@FS_Link = 234	AND ReferralValvesConversionID > 1		AND RecoveryValve.ConversionName = @Type_Outcome)	-- Sender: Valves column
			OR (@FS_Link = 235	AND ReferralEyesTransConversionID > 1	AND RecoveryEyes.ConversionName = @Type_Outcome)	-- Sender: Eyes column
			OR (@FS_Link = 236	AND ReferralEyesRschConversionID > 1	AND RecoveryRsch.ConversionName = @Type_Outcome)	-- Sender: Other column
		);
END


/*** Totals ***/
/* FS_Link option key
	[(1)Registry, (2)Ruleout (3)Total Registry (4)Total Ruleout]
	[(0)Appropriate, (1)Approach, (2)Consent, (3)Recovery]
	[(0-6)Column ordinal] */
	
/* Total Registry Appropriate, Approach, Consent & Recovery */
ELSE IF @FS_Link >= 300 AND @FS_Link <= 336
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)
			AND (
					(	@FS_Link = 300 AND ReferralOrganAppropriateID = 1)		-- Sender: Organ column
					OR (@FS_Link = 301 AND ReferralBoneAppropriateID = 1)		-- Sender: Bone column
					OR (@FS_Link = 302 AND ReferralTissueAppropriateID = 1)		-- Sender: Tissue column
					OR (@FS_Link = 303 AND ReferralSkinAppropriateID = 1)		-- Sender: Skin column
					OR (@FS_Link = 304 AND ReferralValvesAppropriateID = 1)		-- Sender: Valves column
					OR (@FS_Link = 305 AND ReferralEyesTransAppropriateID = 1)	-- Sender: Eyes column
					OR (@FS_Link = 306 AND ReferralEyesRschAppropriateID = 1)	-- Sender: Other column
					OR (@FS_Link = 310 AND ReferralOrganApproachID = 1)			-- Sender: Organ column
					OR (@FS_Link = 311 AND ReferralBoneApproachID = 1)			-- Sender: Bone column
					OR (@FS_Link = 312 AND ReferralTissueApproachID = 1)		-- Sender: Tissue column
					OR (@FS_Link = 313 AND ReferralSkinApproachID = 1)			-- Sender: Skin column
					OR (@FS_Link = 314 AND ReferralValvesApproachID = 1)		-- Sender: Valves column
					OR (@FS_Link = 315 AND ReferralEyesTransApproachID = 1)		-- Sender: Eyes column
					OR (@FS_Link = 316 AND ReferralEyesRschApproachID = 1)		-- Sender: Other column
					OR (@FS_Link = 320 AND ReferralOrganConsentID = 1)			-- Sender: Organ column
					OR (@FS_Link = 321 AND ReferralBoneConsentID = 1)			-- Sender: Bone column
					OR (@FS_Link = 322 AND ReferralTissueConsentID = 1)			-- Sender: Tissue column
					OR (@FS_Link = 323 AND ReferralSkinConsentID = 1)			-- Sender: Skin column
					OR (@FS_Link = 324 AND ReferralValvesConsentID = 1)			-- Sender: Valves column
					OR (@FS_Link = 325 AND ReferralEyesTransConsentID = 1)		-- Sender: Eyes column
					OR (@FS_Link = 326 AND ReferralEyesRschConsentID = 1)		-- Sender: Other column
					OR (@FS_Link = 330 AND ReferralOrganConversionID = 1)		-- Sender: Organ column
					OR (@FS_Link = 331 AND ReferralBoneConversionID = 1)		-- Sender: Bone column
					OR (@FS_Link = 332 AND ReferralTissueConversionID = 1)		-- Sender: Tissue column
					OR (@FS_Link = 333 AND ReferralSkinConversionID = 1)		-- Sender: Skin column
					OR (@FS_Link = 334 AND ReferralValvesConversionID = 1)		-- Sender: Valves column
					OR (@FS_Link = 335 AND ReferralEyesTransConversionID = 1)	-- Sender: Eyes column
					OR (@FS_Link = 336 AND ReferralEyesRschConversionID = 1)	-- Sender: Other column
				);
END

/* Total Ruleout Appropriate, Approach, Consent & Recovery */
ELSE IF @FS_Link >= 400 AND @FS_Link <= 436
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			(
				(	@FS_Link = 400 AND ReferralOrganAppropriateID > 1)		-- Sender: Organ column
				OR (@FS_Link = 401 AND ReferralBoneAppropriateID > 1)		-- Sender: Bone column
				OR (@FS_Link = 402 AND ReferralTissueAppropriateID > 1)		-- Sender: Tissue column
				OR (@FS_Link = 403 AND ReferralSkinAppropriateID > 1)		-- Sender: Skin column
				OR (@FS_Link = 404 AND ReferralValvesAppropriateID > 1)		-- Sender: Valves column
				OR (@FS_Link = 405 AND ReferralEyesTransAppropriateID > 1)	-- Sender: Eyes column
				OR (@FS_Link = 406 AND ReferralEyesRschAppropriateID > 1)	-- Sender: Other column
				OR (@FS_Link = 410 AND ReferralOrganApproachID > 1)			-- Sender: Organ column
				OR (@FS_Link = 411 AND ReferralBoneApproachID > 1)			-- Sender: Bone column
				OR (@FS_Link = 412 AND ReferralTissueApproachID > 1)		-- Sender: Tissue column
				OR (@FS_Link = 413 AND ReferralSkinApproachID > 1)			-- Sender: Skin column
				OR (@FS_Link = 414 AND ReferralValvesApproachID > 1)		-- Sender: Valves column
				OR (@FS_Link = 415 AND ReferralEyesTransApproachID > 1)		-- Sender: Eyes column
				OR (@FS_Link = 416 AND ReferralEyesRschApproachID > 1)		-- Sender: Other column
				OR (@FS_Link = 420 AND ReferralOrganConsentID > 1)			-- Sender: Organ column
				OR (@FS_Link = 421 AND ReferralBoneConsentID > 1)			-- Sender: Bone column
				OR (@FS_Link = 422 AND ReferralTissueConsentID > 1)			-- Sender: Tissue column
				OR (@FS_Link = 423 AND ReferralSkinConsentID > 1)			-- Sender: Skin column
				OR (@FS_Link = 424 AND ReferralValvesConsentID > 1)			-- Sender: Valves column
				OR (@FS_Link = 425 AND ReferralEyesTransConsentID > 1)		-- Sender: Eyes column
				OR (@FS_Link = 426 AND ReferralEyesRschConsentID > 1)		-- Sender: Other column
				OR (@FS_Link = 430 AND ReferralOrganConversionID > 1)		-- Sender: Organ column
				OR (@FS_Link = 430 AND ReferralOrganConversionID > 1)		-- Sender: Organ column
				OR (@FS_Link = 431 AND ReferralBoneConversionID > 1)		-- Sender: Bone column
				OR (@FS_Link = 432 AND ReferralTissueConversionID > 1)		-- Sender: Tissue column
				OR (@FS_Link = 433 AND ReferralSkinConversionID > 1)		-- Sender: Skin column
				OR (@FS_Link = 434 AND ReferralValvesConversionID > 1)		-- Sender: Valves column
				OR (@FS_Link = 435 AND ReferralEyesTransConversionID > 1)	-- Sender: Eyes column
				OR (@FS_Link = 436 AND ReferralEyesRschConversionID > 1)	-- Sender: Other column
			);
END

/* InitialApproacherSummary */
ELSE IF @FS_Link = 500 /* Sender: InitialApproacherSummary.TotalReferrals  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralApproachedByPersonID = ISNULL(@ApproachPersonID, ReferralApproachedByPersonID)
		AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 510 /* Sender: InitialApproacherSummary.InitialPreReferral  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			(
			ReferralOrganApproachID = 1 OR
			ReferralBoneApproachID = 1 OR
			ReferralTissueApproachID = 1 OR
			ReferralSkinApproachID = 1 OR
			ReferralValvesApproachID = 1 OR
			ReferralEyesTransApproachID = 1 OR
			ReferralEyesRschApproachID = 1
			)
		AND ISNULL(ReferralApproachTypeID, -1) IN(2, 3) --(2)Pre-RefCoupled (3)Pre-RefDeCoupled
		AND	ReferralApproachedByPersonID = ISNULL(@ApproachPersonID, ReferralApproachedByPersonID)
		AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND	ReferralApproachedByPersonID NOT IN (-1, 0);
END

/* Exclude Non Approached */
ELSE IF @FS_Link = 520 /* Sender: InitialApproacherSummary.UnknownNotApproached  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
		(
		ReferralOrganAppropriateID = 1 OR
		ReferralBoneAppropriateID = 1 OR
		ReferralTissueAppropriateID = 1 OR
		ReferralSkinAppropriateID = 1 OR
		ReferralValvesAppropriateID = 1 OR
		ReferralEyesTransAppropriateID = 1 OR
		ReferralEyesRschAppropriateID = 1
		)

	AND ISNULL(ReferralApproachTypeID, -1) IN(1, 7) --(1)NOT Approached (7)Unknown
	AND ReferralApproachedByPersonID IN (-1, 0) 
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 530 /* Sender: InitialApproacherSummary.TotalReferrals  grand total */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE 
			(
				ReferralApproachedByPersonID = ISNULL(@ApproachPersonID, ReferralApproachedByPersonID)
			AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
			AND	ReferralApproachedByPersonID NOT IN (-1, 0)
			)
		OR	(
				(
					ReferralApproachedByPersonID IS NULL
				AND	ReferralApproachTypeID IN (1, 7) --Not Approached, Unknown
				)
			OR	(
					ReferralApproachedByPersonID = 0
				AND	ReferralApproachTypeID = -1
				)
			AND	(
					ReferralOrganAppropriateID <> 1 
				OR	ReferralBoneAppropriateID <> 1 
				OR	ReferralTissueAppropriateID <> 1 
				OR	ReferralSkinAppropriateID <> 1 
				OR	ReferralValvesAppropriateID <> 1 
				OR	ReferralEyesTransAppropriateID <> 1 
				OR	ReferralEyesRschAppropriateID <> 1
				)
			);
END

/* ReferralTypeSummaryByFacility */
ELSE IF @FS_Link = 600 /* Sender: ReferralTypeSummaryByFacility.TotalReferrals  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 601 /* Sender: ReferralTypeSummaryByFacility.OTE  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 602 /* Sender: ReferralTypeSummaryByFacility.Tissue  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
		AND ReferralOrganAppropriateID = 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND
			(
			ReferralBoneAppropriateID = 1 OR
			ReferralTissueAppropriateID = 1 OR
			ReferralSkinAppropriateID = 1 OR
			ReferralValvesAppropriateID = 1
			)
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 603 /* Sender: ReferralTypeSummaryByFacility.TE  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND
			(
			ReferralBoneAppropriateID = 1 OR
			ReferralTissueAppropriateID = 1 OR
			ReferralSkinAppropriateID = 1 OR
			ReferralValvesAppropriateID = 1
			)
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 604 /* Sender: ReferralTypeSummaryByFacility.Eye_Only  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID <> 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

		
ELSE IF @FS_Link = 605 /* Sender: ReferralTypeSummaryByFacility.Other_Eye  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID = 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 606 /* Sender: ReferralTypeSummaryByFacility.Other column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID = 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 607 /* Sender: ReferralTypeSummaryByFacility.Age_RO  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	ISNULL(ReferralBoneAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralTissueAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralSkinAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralValvesAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 608 /* Sender: ReferralTypeSummaryByFacility.Med_RO column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	(ISNULL(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
		)
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID)
	AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
END

ELSE IF @FS_Link = 610 /* Sender: ReferralTypeSummaryByFacility.TotalReferrals  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 611 /* Sender: ReferralTypeSummaryByFacility.OTE  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 612 /* Sender: ReferralTypeSummaryByFacility.Tissue  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
		AND ReferralOrganAppropriateID = 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND
			(
			ReferralBoneAppropriateID = 1 OR
			ReferralTissueAppropriateID = 1 OR
			ReferralSkinAppropriateID = 1 OR
			ReferralValvesAppropriateID = 1
			)
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 613 /* Sender: ReferralTypeSummaryByFacility.TE  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND
			(
			ReferralBoneAppropriateID = 1 OR
			ReferralTissueAppropriateID = 1 OR
			ReferralSkinAppropriateID = 1 OR
			ReferralValvesAppropriateID = 1
			)
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 614 /* Sender: ReferralTypeSummaryByFacility.Eye_Only  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID <> 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 615 /* Sender: ReferralTypeSummaryByFacility.Other_Eye  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID = 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 616 /* Sender: ReferralTypeSummaryByFacility.Other column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
	AND ReferralEyesTransAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1
	AND ReferralTissueAppropriateID <> 1
	AND ReferralSkinAppropriateID <> 1
	AND ReferralValvesAppropriateID <> 1
	AND ReferralEyesRschAppropriateID = 1
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 617 /* Sender: ReferralTypeSummaryByFacility.Age_RO  column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	ISNULL(ReferralBoneAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralTissueAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralSkinAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralValvesAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 618 /* Sender: ReferralTypeSummaryByFacility.Med_RO column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	(ISNULL(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
		)
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
	AND ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID, ReferralCallerOrganizationID);
END

ELSE IF @FS_Link = 700 /* Sender: ReferralFacilityCompliance.TotalCTOD column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate IS NOT NULL;
END

ELSE IF @FS_Link = 800 /*Sender: Race Demographics.TotalReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
	AND	PatientRace		=	ISNULL(@Race, PatientRace);
END

ELSE IF @FS_Link = 801 /*Sender: Race Demographics.TotalRegisteredReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
	AND	PatientRace		=	ISNULL(@Race, PatientRace)
	AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);
END

ELSE IF @FS_Link = 900 /*Sender: Age Demographics.TotalReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender);
END

ELSE IF @FS_Link = 901 /*Sender: Age Demographics.TotalRegisteredReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
	AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);
END

ELSE IF @FS_Link = 1000 /*Sender: Referral Statistics by Caller.TotalReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
		AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID);
END

ELSE IF @FS_Link = 1001 /*Sender: Referral Statistics by Caller.TotalRegisteredReferrals column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
	AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
	AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);
END

ELSE IF @FS_Link = 1002 /*Sender: Referral Statistics by Caller.AgeRO column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
	AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
	AND ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	ISNULL(ReferralBoneAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralTissueAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralSkinAppropriateID, -1) NOT IN (3, 4)		/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralValvesAppropriateID, -1) NOT IN (3, 4)	/* (3)High Risk (4)Med RO */
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1;			/* (1) Yes */
END

ELSE IF @FS_Link = 1003 /*Sender: Referral Statistics by Caller.MedRO column */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
	AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
	AND	ISNULL(ReferralTypeID, 0) = 4 /* (4)Ruleout */
	AND	(ISNULL(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			OR ISNULL(ReferralEyesTransAppropriateID, -1) IN (3, 4)/* (3)High Risk (4)Med RO */
		)
	AND ISNULL(ReferralEyesRschAppropriateID, -1) <> 1;			/* (1) Yes */
END	

ELSE IF @FS_Link = 2001 /* Sender: HospitalReportTime.0-1 row */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate IS NOT NULL
	AND	Timely >= -48072000
	AND	Timely <= 59;
END

ELSE IF @FS_Link = 2002 /*  Sender: HospitalReportTime.1-3 row */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate IS NOT NULL
	AND	Timely >= 60
	AND	Timely <= 179;
END

ELSE IF @FS_Link = 2003 /* Sender: HospitalReportTime.3-6 row*/
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate IS NOT NULL
	AND	Timely >= 180
	AND	Timely <= 359;
END

ELSE IF @FS_Link = 2005 /*  Sender: HospitalReportTime.6-> row */
BEGIN
	SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate IS NOT NULL
	AND	Timely >= 360
	AND	Timely <= 48072000;
END


DROP TABLE IF EXISTS #_Temp_Referral_Outcome;
GO

GRANT EXEC ON sps_rpt_ReferralOutcomeReport TO PUBLIC;
GO