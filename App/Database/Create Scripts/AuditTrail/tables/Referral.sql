/******************************************************************************
**	File: Referral.sql
**	Name: Referral
**	Desc: Create table and add default columns for the table Referral
**	Auth: ccarroll
**	Date: 9/2/2011
**	Revisions:	Date		Name			Description
**				6/25/2019	Mike Berenson	Sync up with what's in production
**				6/25/2019	Mike Berenson	Add new column: ReferralDonorRecordNumberSearchable
**				09/23/2020	James Gerberich	Added several new fields. VS 69249 & 70919
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Referral]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
/* Create Referral If not exists */	

	CREATE TABLE [dbo].[Referral](
		[ReferralID] [int] NOT NULL,
		[CallID] [int] NULL,
		[ReferralCallerPhoneID] [int] NULL,
		[ReferralCallerExtension] [varchar](10) NULL,
		[ReferralCallerOrganizationID] [int] NULL,
		[ReferralCallerSubLocationID] [int] NULL,
		[ReferralCallerSubLocationLevel] [varchar](4) NULL,
		[ReferralCallerPersonID] [int] NULL,
		[ReferralDonorName] [varchar](80) NULL,
		[ReferralDonorRecNumber] [varchar](30) NULL,
		[ReferralDonorAge] [varchar](4) NULL,
		[ReferralDonorAgeUnit] [varchar](10) NULL,
		[ReferralDonorRaceID] [int] NULL,
		[ReferralDonorGender] [char](1) NULL,
		[ReferralDonorWeight] [varchar](7) NULL,
		[ReferralDonorAdmitDate] [smalldatetime] NULL,
		[ReferralDonorAdmitTime] [varchar](10) NULL,
		[ReferralDonorDeathDate] [smalldatetime] NULL,
		[ReferralDonorDeathTime] [varchar](10) NULL,
		[ReferralDonorCauseOfDeathID] [int] NULL,
		[ReferralDonorOnVentilator] [varchar](20) NULL,
		[ReferralDonorDead] [varchar](4) NULL,
		[ReferralTypeID] [int] NULL,
		[ReferralApproachTypeID] [int] NULL,
		[ReferralApproachedByPersonID] [int] NULL,
		[ReferralApproachNOK] [varchar](50) NULL,
		[ReferralApproachRelation] [varchar](50) NULL,
		[ReferralOrganAppropriateID] [int] NULL,
		[ReferralOrganApproachID] [int] NULL,
		[ReferralOrganConsentID] [int] NULL,
		[ReferralOrganConversionID] [int] NULL,
		[ReferralBoneAppropriateID] [int] NULL,
		[ReferralBoneApproachID] [int] NULL,
		[ReferralBoneConsentID] [int] NULL,
		[ReferralBoneConversionID] [int] NULL,
		[ReferralTissueAppropriateID] [int] NULL,
		[ReferralTissueApproachID] [int] NULL,
		[ReferralTissueConsentID] [int] NULL,
		[ReferralTissueConversionID] [int] NULL,
		[ReferralSkinAppropriateID] [int] NULL,
		[ReferralSkinApproachID] [int] NULL,
		[ReferralSkinConsentID] [int] NULL,
		[ReferralSkinConversionID] [int] NULL,
		[ReferralEyesTransAppropriateID] [int] NULL,
		[ReferralEyesTransApproachID] [int] NULL,
		[ReferralEyesTransConsentID] [int] NULL,
		[ReferralEyesTransConversionID] [int] NULL,
		[ReferralEyesRschAppropriateID] [int] NULL,
		[ReferralEyesRschApproachID] [int] NULL,
		[ReferralEyesRschConsentID] [int] NULL,
		[ReferralEyesRschConversionID] [int] NULL,
		[ReferralValvesAppropriateID] [int] NULL,
		[ReferralValvesApproachID] [int] NULL,
		[ReferralValvesConsentID] [int] NULL,
		[ReferralValvesConversionID] [int] NULL,
		[ReferralNotesCase] [varchar](400) NULL,
		[ReferralNotesPrevious] [varchar](255) NULL,
		[ReferralVerifiedOptions] [smallint] NULL,
		[ReferralCoronersCase] [smallint] NULL,
		[Inactive] [smallint] NULL,
		[ReferralCallerLevelID] [int] NULL,
		[LastModified] [datetime] NULL,
		[UnusedField1] [smallint] NULL,
		[ReferralDonorFirstName] [varchar](40) NULL,
		[ReferralDonorLastName] [varchar](40) NULL,
		[ReferralOrganDispositionID] [int] NULL,
		[ReferralBoneDispositionID] [int] NULL,
		[ReferralTissueDispositionID] [int] NULL,
		[ReferralSkinDispositionID] [int] NULL,
		[ReferralValvesDispositionID] [int] NULL,
		[ReferralEyesDispositionID] [int] NULL,
		[ReferralRschDispositionID] [int] NULL,
		[ReferralAllTissueDispositionID] [int] NULL,
		[ReferralPronouncingMD] [int] NULL,
		[UnusedField3] [int] NULL,
		[ReferralNOKPhone] [varchar](14) NULL,
		[ReferralAttendingMD] [int] NULL,
		[ReferralGeneralConsent] [smallint] NULL,
		[ReferralNOKAddress] [varchar](255) NULL,
		[ReferralCoronerName] [varchar](80) NULL,
		[ReferralCoronerPhone] [varchar](14) NULL,
		[ReferralCoronerOrganization] [varchar](80) NULL,
		[ReferralCoronerNote] [varchar](255) NULL,
		[ReferralApproachTime] [numeric](7, 0) NULL,
		[ReferralConsentTime] [numeric](7, 0) NULL,
		[Unused] [smalldatetime] NULL,
		[ReferralDOA] [smallint] NULL,
		[ReferralDOB] [datetime] NULL,
		[ReferralDonorSSN] [varchar](11) NULL,
		[UpdatedFlag] [smallint] NULL,
		[ReferralExtubated] [varchar](15) NULL,
		[DonorRegistryType] [smallint] NULL,
		[DonorRegId] [int] NULL,
		[DonorDMVId] [int] NULL,
		[DonorDMVTable] [varchar](255) NULL,
		[DonorIntentDone] [smallint] NULL,
		[DonorFaxSent] [smallint] NULL,
		[DonorDSNID] [smallint] NULL,
		[ReferralDonorHeartBeat] [int] NULL,
		[ReferralCoronerOrgID] [int] NULL,
		[CurrentReferralTypeId] [int] NULL,
		[ReferralDonorBrainDeathDate] [smalldatetime] NULL,
		[ReferralDonorBrainDeathTime] [varchar](10) NULL,
		[ReferralPronouncingMDPhone] [varchar](14) NULL,
		[ReferralAttendingMDPhone] [varchar](14) NULL,
		[ReferralDOB_ILB] [smallint] NULL,
		[ReferralDonorSpecificCOD] [varchar](250) NULL,
		[ReferralDonorNameMI] [varchar](2) NULL,
		[ReferralNOKID] [int] NULL,
		[ReferralQAReviewComplete] [smallint] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL,
		[ReferralDonorLSADate] [smalldatetime] NULL,
		[ReferralDonorLSATime] [nvarchar](10) NULL,
		[ReferralDCDPotential] [smallint] NULL,
		[ReferralPendingCase] [smallint] NULL,
		[ReferralPendingCaseCoordinator] [smallint] NULL,
		[ReferralPendingCaseComment] [varchar](50) NULL,
		[ReferralPendingCaseLastModified] [datetime] NULL,
		[ReferralDonorRecNumberSearchable] [varchar](30) NULL,
		[Hiv] [int] NULL,
		[Aids] [int] NULL,
		[HepB] [int] NULL,
		[HepC] [int] NULL,
		[Ivda] [int] NULL,
		[IdentityUnknown] [int] NULL,
		[AgeEstimated] [int] NULL,
		[WeightEstimated] [int] NULL,
		[PastMedicalHistory] [varchar](950) NULL,
		[AdmittingDiagnosis] [varchar](950) NULL,
		[IsERferralCase] [bit] NULL
	) ON [PRIMARY];
END		

-- check if ReferralDonorRecNumberSearchable Exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'ReferralDonorRecNumberSearchable'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column ReferralDonorRecNumberSearchable';
	ALTER TABLE Referral
		ADD ReferralDonorRecNumberSearchable varchar(30) NULL;
END	

IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND (
			syscolumns.name = 'Hiv'
		OR	syscolumns.name = 'Aids'
		OR	syscolumns.name = 'HepB'
		OR	syscolumns.name = 'HepC'
		OR	syscolumns.name = 'Ivda'
		OR	syscolumns.name = 'IdentityUnknown'
		OR	syscolumns.name = 'AgeEstimated'
		OR	syscolumns.name = 'WeightEstimated'
		OR	syscolumns.name = 'PastMedicalHistory'
		OR	syscolumns.name = 'AdmittingDiagnosis'
		)
	)
BEGIN
	PRINT 'ALTERING TABLE Referral adding donor disease and info columns';
	ALTER TABLE Referral
		ADD 
			Hiv int NULL,
			Aids int NULL,
			HepB int NULL,
			HepC int NULL,
			Ivda int NULL,
			IdentityUnknown int NULL,
			AgeEstimated int NULL,
			WeightEstimated int NULL,
			PastMedicalHistory varchar(950) NULL,
			AdmittingDiagnosis varchar(950) NULL;
END

IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'IsERferralCase'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column IsERferralCase';
	ALTER TABLE Referral
		ADD IsERferralCase bit;
END	
