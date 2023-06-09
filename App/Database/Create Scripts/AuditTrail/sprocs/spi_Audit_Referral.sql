SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Referral]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Referral]
GO

create procedure [dbo].[spi_Audit_Referral] 
	@ReferralID int,
	@CallID int,
	@ReferralCallerPhoneID int,
	@ReferralCallerExtension varchar(10),
	@ReferralCallerOrganizationID int,
	@ReferralCallerSubLocationID int,
	@ReferralCallerSubLocationLevel varchar(4),
	@ReferralCallerPersonID int,
	@ReferralDonorName varchar(80),
	@ReferralDonorRecNumber varchar(30),
	@ReferralDonorAge varchar(4),
	@ReferralDonorAgeUnit varchar(10),
	@ReferralDonorRaceID int,
	@ReferralDonorGender char(1),
	@ReferralDonorWeight varchar(7),
	@ReferralDonorAdmitDate smalldatetime,
	@ReferralDonorAdmitTime varchar(10),
	@ReferralDonorDeathDate smalldatetime,
	@ReferralDonorDeathTime varchar(10),
	@ReferralDonorCauseOfDeathID int,
	@ReferralDonorOnVentilator varchar(20),
	@ReferralDonorDead varchar(4),
	@ReferralTypeID int,
	@ReferralApproachTypeID int,
	@ReferralApproachedByPersonID int,
	@ReferralApproachNOK varchar(50),
	@ReferralApproachRelation varchar(50),
	@ReferralOrganAppropriateID int,
	@ReferralOrganApproachID int,
	@ReferralOrganConsentID int,
	@ReferralOrganConversionID int,
	@ReferralBoneAppropriateID int,
	@ReferralBoneApproachID int,
	@ReferralBoneConsentID int,
	@ReferralBoneConversionID int,
	@ReferralTissueAppropriateID int,
	@ReferralTissueApproachID int,
	@ReferralTissueConsentID int,
	@ReferralTissueConversionID int,
	@ReferralSkinAppropriateID int,
	@ReferralSkinApproachID int,
	@ReferralSkinConsentID int,
	@ReferralSkinConversionID int,
	@ReferralEyesTransAppropriateID int,
	@ReferralEyesTransApproachID int,
	@ReferralEyesTransConsentID int,
	@ReferralEyesTransConversionID int,
	@ReferralEyesRschAppropriateID int,
	@ReferralEyesRschApproachID int,
	@ReferralEyesRschConsentID int,
	@ReferralEyesRschConversionID int,
	@ReferralValvesAppropriateID int,
	@ReferralValvesApproachID int,
	@ReferralValvesConsentID int,
	@ReferralValvesConversionID int,
	@ReferralNotesCase varchar(400),
	@ReferralNotesPrevious varchar(255),
	@ReferralVerifiedOptions smallint,
	@ReferralCoronersCase smallint,
	@Inactive smallint,
	@ReferralCallerLevelID int,
	@LastModified datetime,
	@UnusedField1 smallint,
	@ReferralDonorFirstName varchar(40),
	@ReferralDonorLastName varchar(40),
	@ReferralOrganDispositionID int,
	@ReferralBoneDispositionID int,
	@ReferralTissueDispositionID int,
	@ReferralSkinDispositionID int,
	@ReferralValvesDispositionID int,
	@ReferralEyesDispositionID int,
	@ReferralRschDispositionID int,
	@ReferralAllTissueDispositionID int,
	@ReferralPronouncingMD int,
	@UnusedField3 int,
	@ReferralNOKPhone varchar(14),
	@ReferralAttendingMD int,
	@ReferralGeneralConsent smallint,
	@ReferralNOKAddress varchar(255),
	@ReferralCoronerName varchar(80),
	@ReferralCoronerPhone varchar(14),
	@ReferralCoronerOrganization varchar(80),
	@ReferralCoronerNote varchar(255),
	@ReferralApproachTime numeric(7,0),
	@ReferralConsentTime numeric(7,0),
	@Unused smalldatetime,
	@ReferralDOA smallint,
	@ReferralDOB datetime,
	@ReferralDonorSSN varchar(11),
	@UpdatedFlag smallint,
	@ReferralExtubated varchar(15),
	@DonorRegistryType smallint,
	@DonorRegId int,
	@DonorDMVId int,
	@DonorDMVTable varchar(255),
	@DonorIntentDone smallint,
	@DonorFaxSent smallint,
	@DonorDSNID smallint,
	@ReferralDonorHeartBeat int,
	@ReferralCoronerOrgID int,
	@CurrentReferralTypeId int,
	@ReferralDonorBrainDeathDate smalldatetime,
	@ReferralDonorBrainDeathTime varchar(10),
	@ReferralPronouncingMDPhone varchar(14),
	@ReferralAttendingMDPhone varchar(14),
	@ReferralDOB_ILB smallint,
	@ReferralDonorSpecificCOD varchar(250),
	@ReferralDonorNameMI varchar(2),
	@ReferralNOKID int,
	@ReferralQAReviewComplete smallint,
	@LastStatEmployeeID int,
	@AuditLogTypeID int,
	@ReferralDonorLSADate smalldatetime,
	@ReferralDonorLSATime varchar(10),
	@ReferralDCDPotential smallint,
	@ReferralPendingCase smallint,
	@ReferralPendingCaseCoordinator smallint,
	@ReferralPendingCaseComment varchar(50),
	@ReferralPendingCaseLastModified datetime,
	@ReferralDonorRecNumberSearchable VARCHAR(30),
	@Hiv int,
	@Aids int,
	@HepB int,
	@HepC int,
	@Ivda int,
	@IdentityUnknown int,
	@AgeEstimated int,
	@WeightEstimated int,
	@PastMedicalHistory varchar(950),
	@AdmittingDiagnosis varchar(950),
	@IsERferralCase bit
AS
BEGIN
/* ccarroll 10/06/2011 Add LSA fields CCRST151 */

insert into 
	"Referral"
	( 
		"ReferralID",
		"CallID",
		"ReferralCallerPhoneID",
		"ReferralCallerExtension",
		"ReferralCallerOrganizationID",
		"ReferralCallerSubLocationID",
		"ReferralCallerSubLocationLevel",
		"ReferralCallerPersonID",
		"ReferralDonorName",
		"ReferralDonorRecNumber",
		"ReferralDonorAge",
		"ReferralDonorAgeUnit",
		"ReferralDonorRaceID",
		"ReferralDonorGender",
		"ReferralDonorWeight",
		"ReferralDonorAdmitDate",
		"ReferralDonorAdmitTime",
		"ReferralDonorDeathDate",
		"ReferralDonorDeathTime",
		"ReferralDonorCauseOfDeathID",
		"ReferralDonorOnVentilator",
		"ReferralDonorDead",
		"ReferralTypeID",
		"ReferralApproachTypeID",
		"ReferralApproachedByPersonID",
		"ReferralApproachNOK",
		"ReferralApproachRelation",
		"ReferralOrganAppropriateID",
		"ReferralOrganApproachID",
		"ReferralOrganConsentID",
		"ReferralOrganConversionID",
		"ReferralBoneAppropriateID",
		"ReferralBoneApproachID",
		"ReferralBoneConsentID",
		"ReferralBoneConversionID",
		"ReferralTissueAppropriateID",
		"ReferralTissueApproachID",
		"ReferralTissueConsentID",
		"ReferralTissueConversionID",
		"ReferralSkinAppropriateID",
		"ReferralSkinApproachID",
		"ReferralSkinConsentID",
		"ReferralSkinConversionID",
		"ReferralEyesTransAppropriateID",
		"ReferralEyesTransApproachID",
		"ReferralEyesTransConsentID",
		"ReferralEyesTransConversionID",
		"ReferralEyesRschAppropriateID",
		"ReferralEyesRschApproachID",
		"ReferralEyesRschConsentID",
		"ReferralEyesRschConversionID",
		"ReferralValvesAppropriateID",
		"ReferralValvesApproachID",
		"ReferralValvesConsentID",
		"ReferralValvesConversionID",
		"ReferralNotesCase",
		"ReferralNotesPrevious",
		"ReferralVerifiedOptions",
		"ReferralCoronersCase",
		"Inactive",
		"ReferralCallerLevelID",
		"LastModified",
		"UnusedField1",
		"ReferralDonorFirstName",
		"ReferralDonorLastName",
		"ReferralOrganDispositionID",
		"ReferralBoneDispositionID",
		"ReferralTissueDispositionID",
		"ReferralSkinDispositionID",
		"ReferralValvesDispositionID",
		"ReferralEyesDispositionID",
		"ReferralRschDispositionID",
		"ReferralAllTissueDispositionID",
		"ReferralPronouncingMD",
		"UnusedField3",
		"ReferralNOKPhone",
		"ReferralAttendingMD",
		"ReferralGeneralConsent",
		"ReferralNOKAddress",
		"ReferralCoronerName",
		"ReferralCoronerPhone",
		"ReferralCoronerOrganization",
		"ReferralCoronerNote",
		"ReferralApproachTime",
		"ReferralConsentTime",
		"Unused",
		"ReferralDOA",
		"ReferralDOB",
		"ReferralDonorSSN",
		"UpdatedFlag",
		"ReferralExtubated",
		"DonorRegistryType",
		"DonorRegId",
		"DonorDMVId",
		"DonorDMVTable",
		"DonorIntentDone",
		"DonorFaxSent",
		"DonorDSNID",
		"ReferralDonorHeartBeat",
		"ReferralCoronerOrgID",
		"CurrentReferralTypeId",
		"ReferralDonorBrainDeathDate",
		"ReferralDonorBrainDeathTime",
		"ReferralPronouncingMDPhone",
		"ReferralAttendingMDPhone",
		"ReferralDOB_ILB",
		"ReferralDonorSpecificCOD",
		"ReferralDonorNameMI",
		"ReferralNOKID",
		"ReferralQAReviewComplete",
		"LastStatEmployeeID",
		"AuditLogTypeID",
		"ReferralDonorLSADate",
		"ReferralDonorLSATime",
		"ReferralDCDPotential",
		"ReferralPendingCase",
		"ReferralPendingCaseCoordinator",
		"ReferralPendingCaseComment",
		"ReferralPendingCaseLastModified",
		"ReferralDonorRecNumberSearchable",
		"Hiv",
		"Aids",
		"HepB",
		"HepC",
		"Ivda",
		"IdentityUnknown",
		"AgeEstimated",
		"WeightEstimated",
		"PastMedicalHistory",
		"AdmittingDiagnosis",
		"IsERferralCase"
	)

values 
	( 
		@ReferralID,
		@CallID,
		@ReferralCallerPhoneID,
		@ReferralCallerExtension,
		@ReferralCallerOrganizationID,
		@ReferralCallerSubLocationID,
		@ReferralCallerSubLocationLevel,
		@ReferralCallerPersonID,
		@ReferralDonorName,
		@ReferralDonorRecNumber,
		@ReferralDonorAge,
		@ReferralDonorAgeUnit,
		@ReferralDonorRaceID,
		@ReferralDonorGender,
		@ReferralDonorWeight,		
		@ReferralDonorAdmitDate,
		@ReferralDonorAdmitTime,
		@ReferralDonorDeathDate,
		@ReferralDonorDeathTime,
		@ReferralDonorCauseOfDeathID,
		@ReferralDonorOnVentilator,
		@ReferralDonorDead,
		@ReferralTypeID,
		@ReferralApproachTypeID,
		@ReferralApproachedByPersonID,
		@ReferralApproachNOK,
		@ReferralApproachRelation,
		@ReferralOrganAppropriateID,
		@ReferralOrganApproachID,
		@ReferralOrganConsentID,
		@ReferralOrganConversionID,
		@ReferralBoneAppropriateID,
		@ReferralBoneApproachID,
		@ReferralBoneConsentID,
		@ReferralBoneConversionID,
		@ReferralTissueAppropriateID,
		@ReferralTissueApproachID,
		@ReferralTissueConsentID,
		@ReferralTissueConversionID,
		@ReferralSkinAppropriateID,
		@ReferralSkinApproachID,
		@ReferralSkinConsentID,
		@ReferralSkinConversionID,
		@ReferralEyesTransAppropriateID,
		@ReferralEyesTransApproachID,
		@ReferralEyesTransConsentID,
		@ReferralEyesTransConversionID,
		@ReferralEyesRschAppropriateID,
		@ReferralEyesRschApproachID,
		@ReferralEyesRschConsentID,
		@ReferralEyesRschConversionID,
		@ReferralValvesAppropriateID,
		@ReferralValvesApproachID,
		@ReferralValvesConsentID,
		@ReferralValvesConversionID,
		@ReferralNotesCase,
		@ReferralNotesPrevious,
		@ReferralVerifiedOptions,
		@ReferralCoronersCase,
		@Inactive,
		@ReferralCallerLevelID,
		@LastModified,
		@UnusedField1,
		@ReferralDonorFirstName,
		@ReferralDonorLastName,
		@ReferralOrganDispositionID,
		@ReferralBoneDispositionID,
		@ReferralTissueDispositionID,
		@ReferralSkinDispositionID,
		@ReferralValvesDispositionID,
		@ReferralEyesDispositionID,
		@ReferralRschDispositionID,
		@ReferralAllTissueDispositionID,
		@ReferralPronouncingMD,
		@UnusedField3,
		@ReferralNOKPhone,
		@ReferralAttendingMD,
		@ReferralGeneralConsent,
		@ReferralNOKAddress,
		@ReferralCoronerName,
		@ReferralCoronerPhone,
		@ReferralCoronerOrganization,
		@ReferralCoronerNote,
		@ReferralApproachTime,
		@ReferralConsentTime,
		@Unused,
		@ReferralDOA,
		@ReferralDOB,
		@ReferralDonorSSN,
		@UpdatedFlag,
		@ReferralExtubated,
		@DonorRegistryType,
		@DonorRegId,
		@DonorDMVId,
		@DonorDMVTable,
		@DonorIntentDone,
		@DonorFaxSent,
		@DonorDSNID,
		@ReferralDonorHeartBeat,
		@ReferralCoronerOrgID,
		@CurrentReferralTypeId,
		@ReferralDonorBrainDeathDate,
		@ReferralDonorBrainDeathTime,
		@ReferralPronouncingMDPhone,
		@ReferralAttendingMDPhone,
		@ReferralDOB_ILB,
		@ReferralDonorSpecificCOD,
		@ReferralDonorNameMI,
		@ReferralNOKID,
		@ReferralQAReviewComplete,
		@LastStatEmployeeID,
		@AuditLogTypeID,
		@ReferralDonorLSADate,
		@ReferralDonorLSATime,
		@ReferralDCDPotential,
		@ReferralPendingCase,
		@ReferralPendingCaseCoordinator,
		@ReferralPendingCaseComment,
		@ReferralPendingCaseLastModified,
		@ReferralDonorRecNumberSearchable,
		@Hiv,
		@Aids,
		@HepB,
		@HepC,
		@Ivda,
		@IdentityUnknown,
		@AgeEstimated,
		@WeightEstimated,
		@PastMedicalHistory,
		@AdmittingDiagnosis,
		@IsERferralCase
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

