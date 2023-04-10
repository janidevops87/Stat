IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralOutcome')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralOutcome'
		DROP  Procedure  sps_rpt_ReferralOutcome
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralOutcome'
GO


CREATE Procedure sps_rpt_ReferralOutcome
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		
	@CauseOfDeath				int = Null,

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	--@SourceCodeID				int = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,
	@Race						varchar(20) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null,
	@FS_Link					int = Null,
	@Type_Outcome				varchar(50) = Null,
	@ApproachPersonID			int = Null,
	@ReferralCallerOrgID		int = Null,
	@ReferralCallerPersonID		int	= Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralOutcome.sql
**		Name: sps_rpt_ReferralOutcome
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 11/27/2007
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
**		02/03/2021	James Gerberich		Replaced derived @RefRegistryStatusType table variable with
**											dbo.RegistryStatusType reference table
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

IF  IsNull(@CallID, 0) <> 0 
BEGIN
	SET @ReferralStartDateTime	= Null
	SET @ReferralEndDateTime	= Null
	SET @CardiacStartDateTime	= Null
	SET @CardiacEndDateTime		= Null
	SET	@PatientFirstName		= Null
	SET @PatientLastName		= Null
	SET @MedicalRecordNumber	= Null
	SET @ReferralType			= Null		
	SET @SourceCodeName			= Null
	SET @CoordinatorID			= Null
	SET	@LowerAgeLimit			= Null
	SET	@UpperAgeLimit			= Null
	SET	@Gender					= Null

	--IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
	--	BEGIN /* production database */
	--		SET @Source_DB = 1
	--	END
	--ELSE
	--	BEGIN /* Archive database */
	--		SET @Source_DB = 2
	--	END
END
--ELSE
	--BEGIN
	--/* determine if date range is in Archive db */
	--DECLARE @maxTableDate DATETIME
	--SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

	--	IF (ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 1
	--		END 

	--	IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
	--		AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) < @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 2
	--		END 

	--	IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
	--		AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) > @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 3
	--		END 
	--END
	
	
IF  @ReferralType = 0 
BEGIN
	SET @ReferralType	= Null
END

IF  @CauseOfDeath = 0 
BEGIN
	SET @CauseOfDeath	= Null
END
/* Allow wildcard search using asteric [*]  */
IF @PatientFirstName IS NOT Null
	BEGIN
		SET @PatientFirstName = REPLACE(@PatientFirstName,'*','%')
	END
IF @PatientLastName IS NOT Null
	BEGIN
		SET @PatientLastName = REPLACE(@PatientLastName,'*','%')
	END

IF @MedicalRecordNumber IS NOT Null
	BEGIN
		SET @MedicalRecordNumber = REPLACE(@MedicalRecordNumber,'*','%')
	END

IF (object_id ('tempdb.dbo.#_Temp_Referral_Outcome') is not null)
BEGIN
	DROP TABLE 	#_Temp_Referral_Outcome
END	


CREATE TABLE #_Temp_Referral_Outcome
   (
	[CallID][int] NULL, 
	[CallNumber] [varchar] (500) NULL,
	[PreliminaryRefType] [varchar] (500) null,
	[ReferralTypeID][int] NULL,
	[BasedOnDT] [datetime] Null,
	[ReferralFacility] [varchar] (500) null,
	[HospitalUnit] [varchar] (500) null,
	[Floor] [varchar] (500) null,
	[ReferralPersonID] [Int] Null,
	[ReferralPerson] [varchar] (500) null,
	[InitialApproachType] [varchar] (500) null,
	[InitialConsent] [varchar] (500) null,

	[ReferralApproachedByPersonID] [int] null,

	[InitialApproacher] [varchar] (500) null,
	[FinalApproachType] [varchar] (500) null,
	[FinalApproachOutcome] [varchar] (500) null,
	[FinalApproacher] [varchar] (500) null,
	[PatientName] [varchar] (500) null,
	[PatientGender] [varchar] (500) null, 
	[PatientAge] [varchar] (500) null, 
	[PatientRace] [varchar] (500) null, 
	[MedicalRecordNumber] [varchar] (500) null, 
	[RegistryStatus] [varchar] (500) null,
	[CauseOfDeath] [varchar] (500) null,
	[CardiacDeathDateTime] [varchar] (500) null,
	[ReferralDonorDeathDate] [smalldatetime] null,
	[AppropriateOrgan] [varchar] (500) null, 
	[ApproachOrgan] [varchar] (500) null, 
	[ConsentOrgan] [varchar] (500) null, 
	[RecoveryOrgan] [varchar] (500) null,
	[AppropriateBone] [varchar] (500) null, 
	[ApproachBone] [varchar] (500) null, 
	[ConsentBone] [varchar] (500) null, 
	[RecoveryBone] [varchar] (500) null,
    [AppropriateTissue] [varchar] (500) null, 
	[ApproachTissue] [varchar] (500) null, 
	[ConsentTissue] [varchar] (500) null, 
	[RecoveryTissue] [varchar] (500) null, 
	[AppropriateSkin] [varchar] (500) null, 
	[ApproachSkin] [varchar] (500) null, 
	[ConsentSkin] [varchar] (500) null, 
	[RecoverySkin] [varchar] (500) null, 
	[AppropriateValve] [varchar] (500) null, 
	[ApproachValve] [varchar] (500) null, 
	[ConsentValve] [varchar] (500) null, 
	[RecoveryValve] [varchar] (500) null, 
	[AppropriateEyes] [varchar] (500) null, 
	[ApproachEyes] [varchar] (500) null, 
	[ConsentEyes] [varchar] (500) null, 
	[RecoveryEyes] [varchar] (500) null, 
	[AppropriateOther] [varchar] (500) null,
	[ApproachOther] [varchar] (500) null,
	[ConsentOther] [varchar] (500) null,
	[RecoveryOther] [varchar] (500) null,
	[PatientLastName] [varchar] (500) null,
	[PatientFirstName] [varchar] (500) null,
	[ReferralCallerOrganizationID] [int] null,
	[SourceCodeID] [int] null,
	[SourceCodeName] [varchar] (500) null,
	
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
	[FSCaseBillFamUnavailUserID][int] NULL ,
	[FSCaseBillCryoFormUserID][int] NULL ,
	[FSCaseBillApproachCount][int] NULL ,
	[FSCaseBillMedSocCount][int] NULL ,
	[FSCaseBillCryoFormCount][int] NULL,
	[RegistryStatusID][int] NULL
	)
	
	TRUNCATE TABLE #_Temp_Referral_Outcome
      

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #_Temp_Referral_Outcome 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralOutcome_Select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 
	--						@CauseOfDeath, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 
	--						@Race,

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT, 

	--						@FS_Link, 
	--						@Type_Outcome, 
	--						@ApproachPersonID, 
	--						@ReferralCallerOrgID,
	--						@ReferralCallerPersonID

	--				/* run in production database */
	--				INSERT #_Temp_Referral_Outcome 
	--					EXEC sps_rpt_ReferralOutcome_Select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 
	--						@CauseOfDeath, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 
	--						@Race,

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT, 

	--						@FS_Link, 
	--						@Type_Outcome, 
	--						@ApproachPersonID, 
	--						@ReferralCallerOrgID,
	--						@ReferralCallerPersonID
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #_Temp_Referral_Outcome 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralOutcome_Select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 
	--						@CauseOfDeath, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 
	--						@Race,

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT, 

	--						@FS_Link, 
	--						@Type_Outcome, 
	--						@ApproachPersonID, 
	--						@ReferralCallerOrgID,
	--						@ReferralCallerPersonID
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #_Temp_Referral_Outcome 
				EXEC sps_rpt_ReferralOutcome_Select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

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
							@Race,

							@UserOrgID, 
							@UserID, 
							@DisplayMT, 

							@FS_Link, 
							@Type_Outcome, 
							@ApproachPersonID, 
							@ReferralCallerOrgID,
							@ReferralCallerPersonID
			--END


-- Not from Billable...stand alone
if @FS_Link = 0 SELECT   * 	FROM	#_Temp_Referral_Outcome
-- SecondaryOTE
if @FS_Link = 1 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
-- SecondaryTissue
if @FS_Link = 2 SELECT   *
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)	
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 	
-- SecondaryTE 	
if @FS_Link = 3 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND 	( ReferralBoneAppropriateID = 1 
	OR 	ReferralTissueAppropriateID = 1
	OR 	ReferralSkinAppropriateID = 1
	OR 	ReferralValvesAppropriateID = 1) 	
-- SecondaryEye	
if @FS_Link = 4 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID =1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1
-- SecondaryOtherEye
if @FS_Link = 5 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(ReferralTypeID = 4 OR ReferralTypeID = 3)
	AND	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND ReferralOrganAppropriateID <>1  
	AND ReferralEyesTransAppropriateID = 1	
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1		
-- SecondaryOther
if @FS_Link = 6 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID <>1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	
-- SecondaryROTotal
if @FS_Link = 7 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillSecondaryUserID IS NOT NULL AND FSCaseBillSecondaryUserID <> 0)
	AND	(ReferralOrganAppropriateID <> 1
	AND	ReferralBoneAppropriateID <> 1 
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesTransAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID <> 1)
-- FamilyUnavailableOTE	
if @FS_Link = 8 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (ReferralOrganApproachID = 1)
	AND ((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
    OR ((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
    --AND ( ReferralOrganApproachID = 3 
	AND	(ReferralBoneApproachID = 3
	OR 	ReferralTissueApproachID = 3
	OR 	ReferralValvesApproachID = 3
	OR 	ReferralEyesTransApproachID = 3
	OR 	ReferralEyesRschApproachID = 3))) 
-- FamilyUnavailableTissue
if @FS_Link = 9 SELECT   *
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
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1)  	
-- FamilyUnavailableTE	
if @FS_Link = 10 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)	
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3
	OR	 	ReferralEyesRschApproachID = 3)))
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1)
-- FamilyUnavailableEye	
if @FS_Link = 11 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where ((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR	 	ReferralEyesRschApproachID = 3)))
	AND ReferralOrganApproachID <>1  
	AND ReferralEyesTransApproachID =1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1	
-- FamilyUnavailableOtherEye
if @FS_Link = 12 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3))) 
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID = 1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	
-- FamilyUnavailableOther
if @FS_Link = 13 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
	OR		((FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND 	(ReferralOrganAppropriateID = 3  
	OR	 	ReferralBoneApproachID = 3 
	OR 		ReferralTissueApproachID = 3
	OR 		ReferralSkinApproachID = 3
	OR 		ReferralValvesApproachID = 3 
	OR 		ReferralEyesTransApproachID = 3)))
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1	
-- FamilyUnavailableROTotal
if @FS_Link = 14 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	((FSCaseBillFamUnavailUserID IS NOT NULL AND FSCaseBillFamUnavailUserID <> 0)
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
-- FamilyApproachOTE
if @FS_Link = 15 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (ReferralOrganApproachID = 1)
    AND (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)	
	AND	(ReferralBoneApproachID <> 3
	OR 	ReferralTissueApproachID <> 3
	OR 	ReferralValvesApproachID <> 3
	OR 	ReferralSkinApproachID <> 3
	OR 	ReferralEyesTransApproachID <> 3
	OR 	ReferralEyesRschApproachID <> 3) 
-- FamilyApproachTissue
if @FS_Link = 16 SELECT   *
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND 	( ReferralBoneApproachID = 1 
	OR 	ReferralTissueApproachID = 1
	OR 	ReferralSkinApproachID = 1
	OR 	ReferralValvesApproachID = 1) 	 	
-- FamilyApproachTE 	
if @FS_Link = 17 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3	
	AND	 	ReferralEyesRschApproachID <> 3)
    AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND 	( ReferralBoneApproachID = 1 
	OR 		ReferralTissueApproachID = 1
	OR 		ReferralSkinApproachID = 1
	OR 		ReferralValvesApproachID = 1)  	
-- FamilyApproachEye	
if @FS_Link = 18 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesRschApproachID <> 3)
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID =1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID <> 1			
-- FamilyApproachOtherEye
if @FS_Link = 19 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3)
	AND 	ReferralOrganAppropriateID <>1  
	AND 	ReferralEyesTransAppropriateID = 1
	AND	ReferralBoneAppropriateID <> 1
	AND	ReferralTissueAppropriateID <> 1
	AND	ReferralSkinAppropriateID <> 1
	AND	ReferralValvesAppropriateID <> 1
	AND	ReferralEyesRschAppropriateID = 1	
-- FamilyApproachOther
if @FS_Link = 20 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
	AND 	(ReferralOrganApproachID <> 3
	AND	 	ReferralBoneApproachID <> 3  
	AND		ReferralTissueApproachID <> 3
	AND		ReferralSkinApproachID <> 3
	AND		ReferralValvesApproachID <> 3
	AND	 	ReferralEyesTransApproachID <> 3)	
	AND 	ReferralOrganApproachID <>1  
	AND 	ReferralEyesTransApproachID <>1
	AND	ReferralBoneApproachID <> 1
	AND	ReferralTissueApproachID <> 1
	AND	ReferralSkinApproachID <> 1
	AND	ReferralValvesApproachID <> 1
	AND	ReferralEyesRschApproachID = 1
-- FamilyApproachROTotal
if @FS_Link = 21 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillApproachUserID IS NOT NULL AND FSCaseBillApproachUserID <> 0)
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

-- MedSocOTE
if @FS_Link = 29 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND     ReferralOrganConsentID = 1
-- MedSocTissue
if @FS_Link = 30 SELECT   *
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1)	
-- MedSocTE 	
if @FS_Link = 31 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1)  	
-- MedSocEye	
if @FS_Link = 32 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
-- MedSocOtherEye
if @FS_Link = 33 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	 (FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1		
-- MedSocOther
if @FS_Link = 34 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	
-- MedSocROTotal
if @FS_Link = 35 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillMedSocUserID IS NOT NULL AND FSCaseBillMedSocUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)

-- CryolifeFormOTE
if @FS_Link = 43 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND		ReferralOrganConsentID = 1
-- CryolifeFormTissue
if @FS_Link = 44 SELECT   *
	FROM	#_Temp_Referral_Outcome
	WHERE 	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID <>1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1) 	
-- CryolifeFormTE 	
if @FS_Link = 45 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND 	( ReferralBoneConsentID = 1 
	OR 	ReferralTissueConsentID = 1
	OR 	ReferralSkinConsentID = 1
	OR 	ReferralValvesConsentID = 1)	
-- CryolifeFormEye	
if @FS_Link = 46 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where (FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1  
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1	
-- CryolifeFormOtherEye
if @FS_Link = 47 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID =1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1		
-- CryolifeFormOther
if @FS_Link = 48 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND 	ReferralOrganConsentID <>1 
	AND 	ReferralEyesTransConsentID <>1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesRschConsentID = 1	
-- CryolifeFormROTotal
if @FS_Link = 49 SELECT   *
	FROM	#_Temp_Referral_Outcome
	Where	(FSCaseBillCryoFormUserID IS NOT NULL AND FSCaseBillCryoFormUserID <> 0)
	AND	(ReferralOrganConsentID <> 1
	AND	ReferralBoneConsentID <> 1
	AND	ReferralTissueConsentID <> 1
	AND	ReferralSkinConsentID <> 1
	AND	ReferralValvesConsentID <> 1
	AND	ReferralEyesTransConsentID <> 1
	AND	ReferralEyesRschConsentID <> 1)


/* OutcomeByCategory Report Options 
FS_Link option key
	[(1)Registry, (2)Ruleout (3)Total Registry (4)Total Ruleout]
	[(0)Appropriate, (1)Approach, (2)Consent, (3)Recovery]
	[(0-6)Column ordinal] 
*/

/* Appropriate */
if @FS_Link = 100 /* Sender: Organ Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralOrganAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry'  ELSE RegistryType END = @Type_Outcome

if @FS_Link = 101 /* Sender: Bone Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralBoneAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType  END = @Type_Outcome

if @FS_Link = 102 /* Sender: Soft_Tissue Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralTissueAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType  END = @Type_Outcome

if @FS_Link = 103 /* Sender: Skin Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralSkinAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType  END = @Type_Outcome

if @FS_Link = 104 /* Sender: Valves Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralValvesAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 105 /* Sender: Eyes Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesTransAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 106 /* Sender: Other Appropriate column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesRschAppropriateID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

/* Approach */
if @FS_Link = 110 /* Sender: Organ Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralOrganApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 111 /* Sender: Bone Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralBoneApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 112 /* Sender: Soft_Tissue Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralTissueApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 113 /* Sender: Skin Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralSkinApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 114 /* Sender: Valves Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralValvesApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 115 /* Sender: Eyes Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesTransApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 116 /* Sender: Other Approach column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesRschApproachID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome


/* Consent */
if @FS_Link = 120 /* Sender: Organ Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralOrganConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 121 /* Sender: Bone Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralBoneConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 122 /* Sender: Soft_Tissue Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralTissueConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 123 /* Sender: Skin Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralSkinConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 124 /* Sender: Valves Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralValvesConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 125 /* Sender: Eyes Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesTransConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 126 /* Sender: Other Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesRschConsentID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome


/* Recovery */
if @FS_Link = 130 /* Sender: Organ Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralOrganConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 131 /* Sender: Bone Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralBoneConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 132 /* Sender: Recovery Consent column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralTissueConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 133 /* Sender: Skin Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralSkinConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 134 /* Sender: Valves Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralValvesConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 135 /* Sender: Eyes Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesTransConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome

if @FS_Link = 136 /* Sender: Other Recovery column */
SELECT   *
	FROM	#_Temp_Referral_Outcome
	LEFT JOIN RegistryStatusType AS RefRegistryStatusType ON RegistryStatusID = RefRegistryStatusType.ID
	WHERE
			ReferralEyesRschConversionID = 1
		AND CASE WHEN RegistryStatusID IN (-1, 3, 5) THEN 'Not on Registry' ELSE RegistryType END = @Type_Outcome


/* Grouping Code 2 - Disposition ruleout reason - Appropriate */
if @FS_Link = 200 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = TempReferralOutcome.ReferralOrganAppropriateID 
	WHERE
			ReferralOrganAppropriateID > 1
			AND AppropOrgan.AppropriateName = @Type_Outcome

if @FS_Link = 201 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = TempReferralOutcome.ReferralBoneAppropriateID 
	WHERE
			ReferralBoneAppropriateID > 1
			AND AppropBone.AppropriateName = @Type_Outcome
			
			
if @FS_Link = 202 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = TempReferralOutcome.ReferralTissueAppropriateID 
	WHERE
			ReferralTissueAppropriateID > 1
			AND AppropTissue.AppropriateName = @Type_Outcome

			
if @FS_Link = 203 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = TempReferralOutcome.ReferralSkinAppropriateID 
	WHERE
			ReferralSkinAppropriateID > 1
			AND AppropSkin.AppropriateName = @Type_Outcome

			
if @FS_Link = 204 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = TempReferralOutcome.ReferralValvesAppropriateID 
	WHERE
			ReferralValvesAppropriateID > 1
			AND AppropValve.AppropriateName = @Type_Outcome

			
if @FS_Link = 205 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = TempReferralOutcome.ReferralEyesTransAppropriateID 
	WHERE
			ReferralEyesTransAppropriateID > 1
			AND AppropEyes.AppropriateName = @Type_Outcome

			
if @FS_Link = 206 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = TempReferralOutcome.ReferralEyesRschAppropriateID 
	WHERE
			ReferralEyesRschAppropriateID > 1
			AND AppropRsch.AppropriateName = @Type_Outcome

/* Approach */
if @FS_Link = 210 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = TempReferralOutcome.ReferralOrganApproachID 
	WHERE
			ReferralOrganApproachID > 1
			AND ApproaOrgan.ApproachName = @Type_Outcome
			
if @FS_Link = 211 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = TempReferralOutcome.ReferralBoneApproachID 
	WHERE
			ReferralBoneApproachID > 1
			AND ApproaBone.ApproachName = @Type_Outcome
			
if @FS_Link = 212 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = TempReferralOutcome.ReferralTissueApproachID 
	WHERE
			ReferralTissueApproachID > 1
			AND ApproaTissue.ApproachName = @Type_Outcome
			
if @FS_Link = 213 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = TempReferralOutcome.ReferralSkinApproachID 
	WHERE
			ReferralSkinApproachID > 1
			AND ApproaSkin.ApproachName = @Type_Outcome

if @FS_Link = 214 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = TempReferralOutcome.ReferralValvesApproachID 
	WHERE
			ReferralValvesApproachID > 1
			AND ApproaValve.ApproachName = @Type_Outcome
			
if @FS_Link = 215 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = TempReferralOutcome.ReferralEyesTransApproachID 
	WHERE
			ReferralEyesTransApproachID > 1
			AND ApproaEyes.ApproachName = @Type_Outcome

if @FS_Link = 216 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = TempReferralOutcome.ReferralEyesRschApproachID 
	WHERE
			ReferralEyesRschApproachID > 1
			AND ApproaRsch.ApproachName = @Type_Outcome



/* Consent */
if @FS_Link = 220 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = TempReferralOutcome.ReferralOrganConsentID 
	WHERE
			ReferralOrganConsentID > 1
			AND ConsentOrgan.ConsentName = @Type_Outcome
			
if @FS_Link = 221 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = TempReferralOutcome.ReferralBoneConsentID 
	WHERE
			ReferralBoneConsentID > 1
			AND ConsentBone.ConsentName = @Type_Outcome
			
if @FS_Link = 222 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = TempReferralOutcome.ReferralTissueConsentID 
	WHERE
			ReferralTissueConsentID > 1
			AND ConsentTissue.ConsentName = @Type_Outcome
			
if @FS_Link = 223 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = TempReferralOutcome.ReferralSkinConsentID 
	WHERE
			ReferralSkinConsentID > 1
			AND ConsentSkin.ConsentName = @Type_Outcome

if @FS_Link = 224 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = TempReferralOutcome.ReferralValvesConsentID 
	WHERE
			ReferralValvesConsentID > 1
			AND ConsentValve.ConsentName = @Type_Outcome
			
if @FS_Link = 225 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = TempReferralOutcome.ReferralEyesTransConsentID 
	WHERE
			ReferralEyesTransConsentID > 1
			AND ConsentEyes.ConsentName = @Type_Outcome

if @FS_Link = 226 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = TempReferralOutcome.ReferralEyesRschConsentID 
	WHERE
			ReferralEyesRschConsentID > 1
			AND ConsentRsch.ConsentName = @Type_Outcome



/* Conversion */
if @FS_Link = 230 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = TempReferralOutcome.ReferralOrganConversionID 
	WHERE
			ReferralOrganConversionID > 1
			AND RecoveryOrgan.ConversionName = @Type_Outcome
			
if @FS_Link = 231 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = TempReferralOutcome.ReferralBoneConversionID 
	WHERE
			ReferralBoneConversionID > 1
			AND RecoveryBone.ConversionName = @Type_Outcome
			
if @FS_Link = 232 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = TempReferralOutcome.ReferralTissueConversionID 
	WHERE
			ReferralTissueConversionID > 1
			AND RecoveryTissue.ConversionName = @Type_Outcome
			
if @FS_Link = 233 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = TempReferralOutcome.ReferralSkinConversionID 
	WHERE
			ReferralSkinConversionID > 1
			AND RecoverySkin.ConversionName = @Type_Outcome

if @FS_Link = 234 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = TempReferralOutcome.ReferralValvesConversionID 
	WHERE
			ReferralValvesConversionID > 1
			AND RecoveryValve.ConversionName = @Type_Outcome
			
if @FS_Link = 235 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = TempReferralOutcome.ReferralEyesTransConversionID 
	WHERE
			ReferralEyesTransConversionID > 1
			AND RecoveryEyes.ConversionName = @Type_Outcome

if @FS_Link = 236 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = TempReferralOutcome.ReferralEyesRschConversionID 
	WHERE
			ReferralEyesRschConversionID > 1
			AND RecoveryRsch.ConversionName = @Type_Outcome
			


/*** Totals ***/
/* FS_Link option key
	[(1)Registry, (2)Ruleout (3)Total Registry (4)Total Ruleout]
	[(0)Appropriate, (1)Approach, (2)Consent, (3)Recovery]
	[(0-6)Column ordinal] */
	
/* Total Registry Approapriate */
if @FS_Link = 300 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 301 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 302 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 303 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 304 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 305 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 306 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschAppropriateID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		



/* Total Registry Approach */
if @FS_Link = 310 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 311 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 312 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 313 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 314 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 315 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 316 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschApproachID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		



/* Total Registry Consent */
if @FS_Link = 320 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 321 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 322 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 323 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 324 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 325 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 326 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschConsentID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		


/* Total Registry Conversion */
if @FS_Link = 330 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 331 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 332 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 333 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 334 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		
			
if @FS_Link = 335 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		

if @FS_Link = 336 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschConversionID = 1
	AND		CASE WHEN RegistryStatusID = -1 THEN 3 ELSE RegistryStatusID END IN (SELECT ID FROM RegistryStatusType)		



/* Total Ruleout Approapriate */
if @FS_Link = 400 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganAppropriateID > 1

if @FS_Link = 401 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneAppropriateID > 1
			
if @FS_Link = 402 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueAppropriateID > 1
			
if @FS_Link = 403 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinAppropriateID > 1

if @FS_Link = 404 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesAppropriateID > 1
			
if @FS_Link = 405 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransAppropriateID > 1

if @FS_Link = 406 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschAppropriateID > 1

/* Total Ruleout Approach */
if @FS_Link = 410 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganApproachID > 1

if @FS_Link = 411 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneApproachID > 1
			
if @FS_Link = 412 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueApproachID > 1
			
if @FS_Link = 413 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinApproachID > 1

if @FS_Link = 414 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesApproachID > 1
			
if @FS_Link = 415 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransApproachID > 1

if @FS_Link = 416 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschApproachID > 1



/* Total Ruleout Consent */
if @FS_Link = 420 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganConsentID > 1

if @FS_Link = 421 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneConsentID > 1
			
if @FS_Link = 422 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueConsentID > 1
			
if @FS_Link = 423 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinConsentID > 1

if @FS_Link = 424 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesConsentID > 1
			
if @FS_Link = 425 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransConsentID > 1

if @FS_Link = 426 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschConsentID > 1



/* Total Ruleout Conversion */
if @FS_Link = 430 /* Sender: Organ column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralOrganConversionID > 1

if @FS_Link = 431 /* Sender: Bone column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralBoneConversionID > 1
			
if @FS_Link = 432 /* Sender: Tissue column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralTissueConversionID > 1
			
if @FS_Link = 433 /* Sender: Skin column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralSkinConversionID > 1

if @FS_Link = 434 /* Sender: Valves column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralValvesConversionID > 1
			
if @FS_Link = 435 /* Sender: Eyes column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesTransConversionID > 1

if @FS_Link = 436 /* Sender: Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralEyesRschConversionID > 1

/* InitialApproacherSummary */
if @FS_Link = 500 /* Sender: InitialApproacherSummary.TotalReferrals  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE
			ReferralApproachedByPersonID = IsNull(@ApproachPersonID, ReferralApproachedByPersonID)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)


if @FS_Link = 510 /* Sender: InitialApproacherSummary.InitialPreReferral  column */
SELECT   *
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
		AND	ReferralApproachedByPersonID = IsNull(@ApproachPersonID, ReferralApproachedByPersonID)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND	ReferralApproachedByPersonID Not IN (-1, 0)  /* Exclude Non Approached */


if @FS_Link = 520 /* Sender: InitialApproacherSummary.UnknownNotApproached  column */
SELECT   *
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

		AND ISNULL(ReferralApproachTypeID, -1) IN(1, 7) --(1)Not Approached (7)Unknown
		AND ReferralApproachedByPersonID IN (-1, 0) 
--		AND	ReferralApproachedByPersonID = IsNull(@ApproachPersonID, ReferralApproachedByPersonID)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)


/* ReferralTypeSummaryByFacility */
if @FS_Link = 600 /* Sender: ReferralTypeSummaryByFacility.TotalReferrals  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 601 /* Sender: ReferralTypeSummaryByFacility.OTE  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 602 /* Sender: ReferralTypeSummaryByFacility.Tissue  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
			AND ReferralOrganAppropriateID = 1		/* (1) Yes */
			AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
			AND
				(
				ReferralBoneAppropriateID = 1 OR
				ReferralTissueAppropriateID = 1 OR
				ReferralSkinAppropriateID = 1 OR
				ReferralValvesAppropriateID = 1
				)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 603 /* Sender: ReferralTypeSummaryByFacility.TE  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
			AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
			AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
			AND
				(
				ReferralBoneAppropriateID = 1 OR
				ReferralTissueAppropriateID = 1 OR
				ReferralSkinAppropriateID = 1 OR
				ReferralValvesAppropriateID = 1
				)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 604 /* Sender: ReferralTypeSummaryByFacility.Eye_Only  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID <> 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */
		
if @FS_Link = 605 /* Sender: ReferralTypeSummaryByFacility.Other_Eye  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID = 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 606 /* Sender: ReferralTypeSummaryByFacility.Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID <> 1
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID = 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 607 /* Sender: ReferralTypeSummaryByFacility.Age_RO  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	IsNull(ReferralBoneAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralTissueAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralSkinAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralValvesAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */

if @FS_Link = 608 /* Sender: ReferralTypeSummaryByFacility.Med_RO column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	(IsNull(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			)
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4, 6); /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DlaRegistry */


if @FS_Link = 610 /* Sender: ReferralTypeSummaryByFacility.TotalReferrals  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 611 /* Sender: ReferralTypeSummaryByFacility.OTE  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 612 /* Sender: ReferralTypeSummaryByFacility.Tissue  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
			AND ReferralOrganAppropriateID = 1		/* (1) Yes */
			AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
			AND
				(
				ReferralBoneAppropriateID = 1 OR
				ReferralTissueAppropriateID = 1 OR
				ReferralSkinAppropriateID = 1 OR
				ReferralValvesAppropriateID = 1
				)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 613 /* Sender: ReferralTypeSummaryByFacility.TE  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
			AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
			AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
			AND
				(
				ReferralBoneAppropriateID = 1 OR
				ReferralTissueAppropriateID = 1 OR
				ReferralSkinAppropriateID = 1 OR
				ReferralValvesAppropriateID = 1
				)
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 614 /* Sender: ReferralTypeSummaryByFacility.Eye_Only  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID <> 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
		
if @FS_Link = 615 /* Sender: ReferralTypeSummaryByFacility.Other_Eye  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID = 1
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID = 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 616 /* Sender: ReferralTypeSummaryByFacility.Other column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
		AND ReferralEyesTransAppropriateID <> 1
		AND	ReferralBoneAppropriateID <> 1
		AND ReferralTissueAppropriateID <> 1
		AND ReferralSkinAppropriateID <> 1
		AND ReferralValvesAppropriateID <> 1
		AND ReferralEyesRschAppropriateID = 1
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 617 /* Sender: ReferralTypeSummaryByFacility.Age_RO  column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	IsNull(ReferralBoneAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralTissueAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralSkinAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralValvesAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */

if @FS_Link = 618 /* Sender: ReferralTypeSummaryByFacility.Med_RO column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	(IsNull(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			)
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
		AND ReferralCallerOrganizationID = IsNull(@ReferralCallerOrgID, ReferralCallerOrganizationID)
		--AND ISNULL(RegistryStatusID, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */


if @FS_Link = 700 /* Sender: ReferralFacilityCompliance.TotalCTOD column */
SELECT   *
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralDonorDeathDate Is Not Null

If @FS_Link = 800 /*Sender: Race Demographics.TotalReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
		AND	PatientRace		=	ISNULL(@Race, PatientRace)

If @FS_Link = 801 /*Sender: Race Demographics.TotalRegisteredReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
		AND	PatientRace		=	ISNULL(@Race, PatientRace)
		AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);

If @FS_Link = 900 /*Sender: Age Demographics.TotalReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)

If @FS_Link = 901 /*Sender: Age Demographics.TotalRegisteredReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	PatientGender	=	ISNULL(@Gender, PatientGender)
		AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);

If @FS_Link = 1000 /*Sender: Referral Statistics by Caller.TotalReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
		AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)

If @FS_Link = 1001 /*Sender: Referral Statistics by Caller.TotalRegisteredReferrals column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
		AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
		AND	ISNULL(RegistryStatusID, -1)	IN	(1,2,4,6);

If @FS_Link = 1002 /*Sender: Referral Statistics by Caller.AgeRO column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
		AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
		AND IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	IsNull(ReferralBoneAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralTissueAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralSkinAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralValvesAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */

If @FS_Link = 1003 /*Sender: Referral Statistics by Caller.MedRO column */
SELECT	*
	FROM	#_Temp_Referral_Outcome TempReferralOutcome
	WHERE	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrgID,ReferralCallerOrganizationID)
		AND	ReferralPersonID = ISNULL(@ReferralCallerPersonID,ReferralPersonID)
		AND	IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
		AND	(IsNull(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
			 OR IsNull(ReferralEyesTransAppropriateID, -1) IN (3, 4)/* (3)High Risk (4)Med RO */
			)
		AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */

GO