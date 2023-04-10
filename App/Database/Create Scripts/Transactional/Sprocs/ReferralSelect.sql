IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ReferralSelect')
BEGIN
	PRINT 'Dropping Procedure ReferralSelect';
	DROP Procedure ReferralSelect;
END
GO

PRINT 'Creating Procedure ReferralSelect';
GO
CREATE Procedure [dbo].[ReferralSelect]
(
		@ReferralID int = null output,
		@CallID int = null
)
AS
/******************************************************************************
**	File: ReferralSelect.sql
**	Name: ReferralSelect
**	Desc: Selects multiple rows of Referral Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
**	05/28/2020		Mike Berenson		Added fields for e-referral
**	04/09/2021		Mike Berenson		Added fields from SelectReferral.sql
**	05/05/2021		Mike Berenson		Added ArithAbort and IsNull call on ReferralDCDPotential
**	05/06/2021		Mike Berenson		Removed OrderBy statement
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET ARITHABORT ON;

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
	Referral.ReferralDonorRecNumberSearchable,
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
	ISNULL(Referral.ReferralDCDPotential, -2) AS ReferralDCDPotential,
	Referral.ReferralPendingCase,
	Referral.ReferralPendingCaseCoordinator,
	Referral.ReferralPendingCaseComment,
	Organization.OrganizationID,
	Organization.OrganizationName,
	Organization.OrganizationNotes,
	Referral.Hiv,
	Referral.Aids,
	Referral.HepB,
	Referral.HepC,
	Referral.Ivda,
	Referral.IdentityUnknown,
	Referral.AgeEstimated,
	Referral.WeightEstimated,
	Referral.PastMedicalHistory,
	Referral.AdmittingDiagnosis,
	Referral.LastStatEmployeeID,
	Referral.AuditLogTypeID,
	IsNull(Referral.IsERferralCase,0) AS IsERferralCase
FROM 
	dbo.Referral 
JOIN
	Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID
WHERE 
	(@ReferralID IS NULL OR Referral.ReferralID = @ReferralID)
	AND (@CallID IS NULL OR Referral.CallID = @CallID);
GO

GRANT EXEC ON ReferralSelect TO PUBLIC;
GO
