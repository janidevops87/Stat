IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectReferral')
BEGIN
	PRINT 'Dropping Procedure SelectReferral';
	PRINT GETDATE();
	DROP Procedure SelectReferral;
END
GO

PRINT 'Creating Procedure SelectReferral';
PRINT GETDATE();
GO
CREATE Procedure [dbo].[SelectReferral]
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: SelectReferral.sql
**	Name: SelectReferral
**	Desc: Selects multiple rows of Referral Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
**	09/06/2011		ccarroll			Added LSA Date Time CCRST151	
**	01/22/2018		Mike Berenson		Added ReferralDCDPotential
**	10/02/2018		Serge Hurko			#61346 - Add new fields to StatTrac Referral Event Log
**	05/28/2020		Mike Berenson		Added fields for e-referral
*******************************************************************************/
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT
		Referral.ReferralID,
		Referral.CallID,
		Referral.ReferralCallerPhoneID,
		Referral.ReferralCallerExtension,
		Referral.ReferralCallerOrganizationID,
		Referral.ReferralCallerSubLocationID,
		Referral.ReferralCallerSubLocationLevel,
		Referral.ReferralCallerPersonID,
		Referral.ReferralDonorName,
		Referral.ReferralDonorRecNumber,
		Referral.ReferralDonorAge,
		Referral.ReferralDonorAgeUnit,
		Referral.ReferralDonorRaceID,
		Referral.ReferralDonorGender,
		Referral.ReferralDonorWeight,
		Referral.ReferralDonorAdmitDate,
		Referral.ReferralDonorAdmitTime,
		Referral.ReferralDonorDeathDate,
		Referral.ReferralDonorDeathTime,
		Referral.ReferralDonorLSADate,
		Referral.ReferralDonorLSATime,
		Referral.ReferralDonorCauseOfDeathID,
		Referral.ReferralDonorOnVentilator,
		Referral.ReferralDonorDead,
		Referral.ReferralTypeID,
		Referral.ReferralApproachTypeID,
		Referral.ReferralApproachedByPersonID,
		Referral.ReferralApproachNOK,
		Referral.ReferralApproachRelation,
		Referral.ReferralOrganAppropriateID,
		Referral.ReferralOrganApproachID,
		Referral.ReferralOrganConsentID,
		Referral.ReferralOrganConversionID,
		Referral.ReferralBoneAppropriateID,
		Referral.ReferralBoneApproachID,
		Referral.ReferralBoneConsentID,
		Referral.ReferralBoneConversionID,
		Referral.ReferralTissueAppropriateID,
		Referral.ReferralTissueApproachID,
		Referral.ReferralTissueConsentID,
		Referral.ReferralTissueConversionID,
		Referral.ReferralSkinAppropriateID,
		Referral.ReferralSkinApproachID,
		Referral.ReferralSkinConsentID,
		Referral.ReferralSkinConversionID,
		Referral.ReferralEyesTransAppropriateID,
		Referral.ReferralEyesTransApproachID,
		Referral.ReferralEyesTransConsentID,
		Referral.ReferralEyesTransConversionID,
		Referral.ReferralEyesRschAppropriateID,
		Referral.ReferralEyesRschApproachID,
		Referral.ReferralEyesRschConsentID,
		Referral.ReferralEyesRschConversionID,
		Referral.ReferralValvesAppropriateID,
		Referral.ReferralValvesApproachID,
		Referral.ReferralValvesConsentID,
		Referral.ReferralValvesConversionID,
		Referral.ReferralNotesCase,
		Referral.ReferralNotesPrevious,
		Referral.ReferralVerifiedOptions,
		Referral.ReferralCoronersCase,
		Referral.Inactive,
		Referral.ReferralCallerLevelID,
		Referral.LastModified,
		Referral.UnusedField1,
		Referral.ReferralDonorFirstName,
		Referral.ReferralDonorLastName,
		Referral.ReferralOrganDispositionID,
		Referral.ReferralBoneDispositionID,
		Referral.ReferralTissueDispositionID,
		Referral.ReferralSkinDispositionID,
		Referral.ReferralValvesDispositionID,
		Referral.ReferralEyesDispositionID,
		Referral.ReferralRschDispositionID,
		Referral.ReferralAllTissueDispositionID,
		Referral.ReferralPronouncingMD,
		Referral.UnusedField3,
		Referral.ReferralNOKPhone,
		Referral.ReferralAttendingMD,
		Referral.ReferralGeneralConsent,
		Referral.ReferralNOKAddress,
		Referral.ReferralCoronerName,
		Referral.ReferralCoronerPhone,
		Referral.ReferralCoronerOrganization,
		Referral.ReferralCoronerNote,
		Referral.ReferralApproachTime,
		Referral.ReferralConsentTime,
		Referral.Unused,
		Referral.ReferralDOA,
		Referral.ReferralDOB,
		Referral.ReferralDonorSSN,
		Referral.UpdatedFlag,
		Referral.ReferralExtubated,
		Referral.DonorRegistryType,
		Referral.DonorRegId,
		Referral.DonorDMVId,
		Referral.DonorDMVTable,
		Referral.DonorIntentDone,
		Referral.DonorFaxSent,
		Referral.DonorDSNID,
		Referral.ReferralDonorHeartBeat,
		Referral.ReferralCoronerOrgID,
		Referral.CurrentReferralTypeId,
		Referral.ReferralDonorBrainDeathDate,
		Referral.ReferralDonorBrainDeathTime,
		Referral.ReferralPronouncingMDPhone,
		Referral.ReferralAttendingMDPhone,
		Referral.ReferralDOB_ILB,
		Referral.ReferralDonorSpecificCOD,
		Referral.ReferralDonorNameMI,
		Referral.ReferralNOKID,
		Referral.ReferralQAReviewComplete,
		Referral.LastStatEmployeeID,
		Referral.AuditLogTypeID,
		ISNULL(Referral.ReferralDCDPotential, -2) AS ReferralDCDPotential,
		Referral.ReferralPendingCase,
		Referral.ReferralPendingCaseCoordinator,
		Referral.ReferralPendingCaseComment,
		Referral.ReferralPendingCaseLastModified,
		Organization.OrganizationID,
		Organization.OrganizationName,
		Organization.OrganizationNotes,
		Hiv,
		Aids,
		HepB,
		HepC,
		Ivda,
		IdentityUnknown,
		AgeEstimated,
		WeightEstimated,
		PastMedicalHistory,
		AdmittingDiagnosis,
		ISNULL(IsERferralCase,0) AS IsERferralCase
	FROM 
		dbo.Referral 
	JOIN
		Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID
	WHERE 
		(
		@CallID IS NULL
		OR
		Referral.CallID = @CallID
		);
GO

GRANT EXEC ON SelectReferral TO PUBLIC;
GO
