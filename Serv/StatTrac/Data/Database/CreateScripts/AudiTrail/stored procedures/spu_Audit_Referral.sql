SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Referral]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_Audit_Referral'
		drop procedure [dbo].[spu_Audit_Referral]
	END
GO

	PRINT 'Creating Procedure spu_Audit_Referral'
GO

create procedure [dbo].[spu_Audit_Referral]
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
	@pkc1 int,
	@bitmap binary(15)
	AS
/******************************************************************************
**		File: spu_Audit_Referral.sql
**		Name: spu_Audit_Referral
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		05/15/2008	ccarroll			Added CASE statement for ILB insert values
**		10/06/2011	ccarroll			Added LSA data fields
**		10/24/2011	cacrroll			Changed @c14, @c108 'ILB' size to match table length 
**		02/06/2018	mberenson			Added ReferralDCDPotential
**		02/12/2018	mberenson			Fixed case logic for @ReferralDCDPotential
**		10/03/2018	Serge Hurko			#61346 - Add new fields to StatTrac Referral Event Log
*******************************************************************************/

	DECLARE 
		@lastModifiedFromLookup datetime,
		@lastStatEmployeeIDFromLookup int,
		@auditLogTypeIDFromLookup int,
		@callIDFromLookup int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ReferralID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- ReferralCallerPhoneID
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- ReferralCallerExtension
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- ReferralCallerOrganizationID
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- ReferralCallerSubLocationID
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- ReferralCallerSubLocationLevel
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- ReferralCallerPersonID
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- ReferralDonorName
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- ReferralDonorRecNumber
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- ReferralDonorAge
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- ReferralDonorAgeUnit
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- ReferralDonorRaceID
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- ReferralDonorGender
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- ReferralDonorWeight
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- ReferralDonorAdmitDate
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- ReferralDonorAdmitTime
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- ReferralDonorDeathDate
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- ReferralDonorDeathTime
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- ReferralDonorCauseOfDeathID
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- ReferralDonorOnVentilator
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- ReferralDonorDead
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- ReferralTypeID
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- ReferralApproachTypeID
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- ReferralApproachedByPersonID
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- ReferralApproachNOK
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- ReferralApproachRelation
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- ReferralOrganAppropriateID
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- ReferralOrganApproachID
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- ReferralOrganConsentID
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- ReferralOrganConversionID
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- ReferralBoneAppropriateID
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- ReferralBoneApproachID
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- ReferralBoneConsentID
		AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- ReferralBoneConversionID
		AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- ReferralTissueAppropriateID
		AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- ReferralTissueApproachID
		AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- ReferralTissueConsentID
		AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- ReferralTissueConversionID
		AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- ReferralSkinAppropriateID
		AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- ReferralSkinApproachID
		AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- ReferralSkinConsentID
		AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- ReferralSkinConversionID
		AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- ReferralEyesTransAppropriateID
		AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- ReferralEyesTransApproachID
		AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- ReferralEyesTransConsentID
		AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- ReferralEyesTransConversionID
		AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- ReferralEyesRschAppropriateID
		AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- ReferralEyesRschApproachID
		AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- ReferralEyesRschConsentID
		AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- ReferralEyesRschConversionID
		AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- ReferralValvesAppropriateID
		AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- ReferralValvesApproachID
		AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- ReferralValvesConsentID
		AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- ReferralValvesConversionID
		AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- ReferralNotesCase
		AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- ReferralNotesPrevious
		AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- ReferralVerifiedOptions
		AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- ReferralCoronersCase
		AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- Inactive
		AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- ReferralCallerLevelID
		AND SUBSTRING(@bitmap, 8, 1) & 32 = 32 -- LastModified
		AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- UnusedField1
		AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- ReferralDonorFirstName
		AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- ReferralDonorLastName
		AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- ReferralOrganDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- ReferralBoneDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- ReferralTissueDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- ReferralSkinDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- ReferralValvesDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- ReferralEyesDispositionID
		AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- ReferralRschDispositionID
		AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- ReferralAllTissueDispositionID
		AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- ReferralPronouncingMD
		AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- UnusedField3
		AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- ReferralNOKPhone
		AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- ReferralAttendingMD
		AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- ReferralGeneralConsent
		AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- ReferralNOKAddress
		AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- ReferralCoronerName
		AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- ReferralCoronerPhone
		AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- ReferralCoronerOrganization
		AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- ReferralCoronerNote
		AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- ReferralApproachTime
		AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- ReferralConsentTime
		AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- Unused
		AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- ReferralDOA
		AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- ReferralDOB
		AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- ReferralDonorSSN
		AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- UpdatedFlag
		AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- ReferralExtubated
		AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- DonorRegistryType
		AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- DonorRegId
		AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- DonorDMVId
		AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- DonorDMVTable
		AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- DonorIntentDone
		AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- DonorFaxSent
		AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- DonorDSNID
		AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- ReferralDonorHeartBeat --<####>
		AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- ReferralCoronerOrgID --<####>
		AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- CurrentReferralTypeId
		AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- ReferralDonorBrainDeathDate
		AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- ReferralDonorBrainDeathTime
		AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- ReferralPronouncingMDPhone
		AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- ReferralAttendingMDPhone
		AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- ReferralDOB_ILB
		AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- ReferralDonorSpecificCOD
		AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- ReferralDonorNameMI
		AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- ReferralNOKID
		AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- ReferralQAReviewComplete
		AND SUBSTRING(@bitmap, 14, 1) & 64 <> 64 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 14, 1) & 128 <> 128 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 15, 1) & 1 <> 1 -- ReferralLSADeathDate
		AND SUBSTRING(@bitmap, 15, 1) & 2 <> 2 -- ReferralLSADeathTime
		AND SUBSTRING(@bitmap, 15, 1) & 4 <> 4 -- ReferralDCDPotential
		AND SUBSTRING(@bitmap, 15, 1) & 8 <> 8 -- ReferralPendingCase
		AND SUBSTRING(@bitmap, 15, 1) & 16 <> 16 -- ReferralPendingCaseCoordinator
		AND SUBSTRING(@bitmap, 15, 1) & 32 <> 32 -- ReferralPendingCaseComment
		AND SUBSTRING(@bitmap, 15, 1) & 64 <> 64 -- ReferralPendingCaseLastModified
	   )
BEGIN	   

	SELECT TOP 1
		@lastModifiedFromLookup = LastModified,
		@LastStatEmployeeIDFromLookup = LastStatEmployeeID,
		@auditLogTypeIDFromLookup = ISNULL(@AuditLogTypeID, AuditLogTypeID),
		@callIDFromLookup = CallID
	FROM
		Referral
	WHERE 
		ReferralID = 	@pkc1
	ORDER BY
		LastModified DESC	


	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- ReferralID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- ReferralCallerPhoneID
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- ReferralCallerExtension
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- ReferralCallerOrganizationID
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- ReferralCallerSubLocationID
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- ReferralCallerSubLocationLevel
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- ReferralCallerPersonID
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- ReferralDonorName
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- ReferralDonorRecNumber
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- ReferralDonorAge
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- ReferralDonorAgeUnit
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- ReferralDonorRaceID
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- ReferralDonorGender
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- ReferralDonorWeight
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- ReferralDonorAdmitDate
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- ReferralDonorAdmitTime
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- ReferralDonorDeathDate
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- ReferralDonorDeathTime
	AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- ReferralDonorCauseOfDeathID
	AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- ReferralDonorOnVentilator
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- ReferralDonorDead
	AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- ReferralTypeID
	AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- ReferralApproachTypeID
	AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- ReferralApproachedByPersonID
	AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- ReferralApproachNOK
	AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- ReferralApproachRelation
	AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- ReferralOrganAppropriateID
	AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- ReferralOrganApproachID
	AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- ReferralOrganConsentID
	AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- ReferralOrganConversionID
	AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- ReferralBoneAppropriateID
	AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- ReferralBoneApproachID
	AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- ReferralBoneConsentID
	AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- ReferralBoneConversionID
	AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- ReferralTissueAppropriateID
	AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- ReferralTissueApproachID
	AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- ReferralTissueConsentID
	AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- ReferralTissueConversionID
	AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- ReferralSkinAppropriateID
	AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- ReferralSkinApproachID
	AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- ReferralSkinConsentID
	AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- ReferralSkinConversionID
	AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- ReferralEyesTransAppropriateID
	AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- ReferralEyesTransApproachID
	AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- ReferralEyesTransConsentID
	AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- ReferralEyesTransConversionID
	AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- ReferralEyesRschAppropriateID
	AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- ReferralEyesRschApproachID
	AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- ReferralEyesRschConsentID
	AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- ReferralEyesRschConversionID
	AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- ReferralValvesAppropriateID
	AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- ReferralValvesApproachID
	AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- ReferralValvesConsentID
	AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- ReferralValvesConversionID
	AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- ReferralNotesCase
	AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- ReferralNotesPrevious
	AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- ReferralVerifiedOptions
	AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- ReferralCoronersCase
	AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- Inactive
	AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- ReferralCallerLevelID
	AND SUBSTRING(@bitmap, 8, 1) & 32 = 32 -- LastModified
	AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- UnusedField1
	AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- ReferralDonorFirstName
	AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- ReferralDonorLastName
	AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- ReferralOrganDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- ReferralBoneDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- ReferralTissueDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- ReferralSkinDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- ReferralValvesDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- ReferralEyesDispositionID
	AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- ReferralRschDispositionID
	AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- ReferralAllTissueDispositionID
	AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- ReferralPronouncingMD
	AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- UnusedField3
	AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- ReferralNOKPhone
	AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- ReferralAttendingMD
	AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- ReferralGeneralConsent
	AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- ReferralNOKAddress
	AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- ReferralCoronerName
	AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- ReferralCoronerPhone
	AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- ReferralCoronerOrganization
	AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- ReferralCoronerNote
	AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- ReferralApproachTime
	AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- ReferralConsentTime
	AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- Unused
	AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- ReferralDOA
	AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- ReferralDOB
	AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- ReferralDonorSSN
	AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- UpdatedFlag
	AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- ReferralExtubated
	AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- DonorRegistryType
	AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- DonorRegId
	AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- DonorDMVId
	AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- DonorDMVTable
	AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- DonorIntentDone
	AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- DonorFaxSent
	AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- DonorDSNID
	AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- ReferralDonorHeartBeat --<13, 1, 4>
	AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- ReferralCoronerOrgID  --<13, 1, 8>
	AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- CurrentReferralTypeId
	AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- ReferralDonorBrainDeathDate
	AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- ReferralDonorBrainDeathTime
	AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- ReferralPronouncingMDPhone
	AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- ReferralAttendingMDPhone
	AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- ReferralDOB_ILB
	AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- ReferralDonorSpecificCOD
	AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- ReferralDonorNameMI
	AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- ReferralNOKID
	AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- ReferralQAReviewComplete
	AND SUBSTRING(@bitmap, 14, 1) & 64 = 64 -- LastStatEmployeeID
	-- AND SUBSTRING(@bitmap, 14, 1) & 128 <> 128 -- AuditLogTypeID
	AND IsNull(@auditLogTypeIDFromLookup, 2) IN (2, 3, 4) --Review, Modify, Delete
	AND SUBSTRING(@bitmap, 15, 1) & 1 <> 1 -- ReferralLSADeathDate
	AND SUBSTRING(@bitmap, 15, 1) & 2 <> 2 -- ReferralLSADeathTime	
	AND SUBSTRING(@bitmap, 15, 1) & 4 <> 4 -- ReferralDCDPotential	
	AND SUBSTRING(@bitmap, 15, 1) & 8 <> 8 -- ReferralPendingCase
	AND SUBSTRING(@bitmap, 15, 1) & 16 <> 16 -- ReferralPendingCaseCoordinator
	AND SUBSTRING(@bitmap, 15, 1) & 32 <> 32 -- ReferralPendingCaseComment
	AND SUBSTRING(@bitmap, 15, 1) & 64 <> 64 -- ReferralPendingCaseLastModified
	)
BEGIN 	/* Only LastModified Changed. Check for Deleted record */
		IF  @auditLogTypeIDFromLookup <> 4
			BEGIN
				SET @auditLogTypeIDFromLookup = 2	-- Review
			END
		ELSE
			BEGIN
				SET @auditLogTypeIDFromLookup = 4	-- Deleted
			END
END


insert into 
	Referral
	(
		ReferralID,
		CallID, 
		ReferralCallerPhoneID,
		ReferralCallerExtension, 
		ReferralCallerOrganizationID, 
		ReferralCallerSubLocationID, 
		ReferralCallerSubLocationLevel, 
		ReferralCallerPersonID, 
		ReferralDonorName, 
		ReferralDonorRecNumber, 
		ReferralDonorAge, 
		ReferralDonorAgeUnit, 
		ReferralDonorRaceID, 
		ReferralDonorGender, 
		ReferralDonorWeight, 
		ReferralDonorAdmitDate, 
		ReferralDonorAdmitTime, 
		ReferralDonorDeathDate, 
		ReferralDonorDeathTime, 
		ReferralDonorCauseOfDeathID, 
		ReferralDonorOnVentilator, 
		ReferralDonorDead, 
		ReferralTypeID, 
		ReferralApproachTypeID, 
		ReferralApproachedByPersonID, 
		ReferralApproachNOK, 
		ReferralApproachRelation, 
		ReferralOrganAppropriateID, 
		ReferralOrganApproachID, 
		ReferralOrganConsentID, 
		ReferralOrganConversionID, 
		ReferralBoneAppropriateID, 
		ReferralBoneApproachID, 
		ReferralBoneConsentID, 
		ReferralBoneConversionID, 
		ReferralTissueAppropriateID, 
		ReferralTissueApproachID, 
		ReferralTissueConsentID, 
		ReferralTissueConversionID, 
		ReferralSkinAppropriateID, 
		ReferralSkinApproachID, 
		ReferralSkinConsentID, 
		ReferralSkinConversionID, 
		ReferralEyesTransAppropriateID, 
		ReferralEyesTransApproachID, 
		ReferralEyesTransConsentID, 
		ReferralEyesTransConversionID, 
		ReferralEyesRschAppropriateID, 
		ReferralEyesRschApproachID, 
		ReferralEyesRschConsentID, 
		ReferralEyesRschConversionID, 
		ReferralValvesAppropriateID, 
		ReferralValvesApproachID, 
		ReferralValvesConsentID, 
		ReferralValvesConversionID, 
		ReferralNotesCase, 
		ReferralNotesPrevious, 
		ReferralVerifiedOptions, 
		ReferralCoronersCase, 
		Inactive, 
		ReferralCallerLevelID, 
		LastModified, 
		UnusedField1, 
		ReferralDonorFirstName, 
		ReferralDonorLastName, 
		ReferralOrganDispositionID, 
		ReferralBoneDispositionID, 
		ReferralTissueDispositionID, 
		ReferralSkinDispositionID, 
		ReferralValvesDispositionID, 
		ReferralEyesDispositionID, 
		ReferralRschDispositionID, 
		ReferralAllTissueDispositionID, 
		ReferralPronouncingMD, 
		UnusedField3, 
		ReferralNOKPhone, 
		ReferralAttendingMD, 
		ReferralGeneralConsent, 
		ReferralNOKAddress, 
		ReferralCoronerName, 
		ReferralCoronerPhone, 
		ReferralCoronerOrganization, 
		ReferralCoronerNote, 
		ReferralApproachTime, 
		ReferralConsentTime, 
		Unused, 
		ReferralDOA, 
		ReferralDOB, 
		ReferralDonorSSN, 
		UpdatedFlag, 
		ReferralExtubated, 
		DonorRegistryType, 
		DonorRegId, 
		DonorDMVId, 
		DonorDMVTable, 
		DonorIntentDone, 
		DonorFaxSent, 
		DonorDSNID, 
		ReferralDonorHeartBeat, --<13, 1, 4>
		ReferralCoronerOrgID, --<13, 1, 8>
		CurrentReferralTypeId, 
		ReferralDonorBrainDeathDate, 
		ReferralDonorBrainDeathTime, 
		ReferralPronouncingMDPhone, 
		ReferralAttendingMDPhone, 
		ReferralDOB_ILB, 
		ReferralDonorSpecificCOD, 
		ReferralDonorNameMI, 
		ReferralNOKID, 
		ReferralQAReviewComplete, 
		LastStatEmployeeID, 
		AuditLogTypeID, 
		ReferralDonorLSADate, 
		ReferralDonorLSATime, 
		ReferralDCDPotential,
		ReferralPendingCase,
		ReferralPendingCaseCoordinator,
		ReferralPendingCaseComment,
		ReferralPendingCaseLastModified
	)
		
values 
	( 
		@pkc1,
		@callIDFromLookup,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@ReferralCallerPhoneID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCallerPhoneID END,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@ReferralCallerExtension, '') = '' THEN 'ILB' ELSE @ReferralCallerExtension END,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@ReferralCallerOrganizationID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCallerOrganizationID END,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@ReferralCallerSubLocationID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCallerSubLocationID END,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@ReferralCallerSubLocationLevel, '') = '' THEN 'ILB' ELSE @ReferralCallerSubLocationLevel END,
		CASE WHEN SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@ReferralCallerPersonID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCallerPersonID END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@ReferralDonorName, '') = '' THEN 'ILB' ELSE @ReferralDonorName END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@ReferralDonorRecNumber, '') = '' THEN 'ILB' ELSE @ReferralDonorRecNumber END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@ReferralDonorAge, '') = '' THEN 'ILB' ELSE @ReferralDonorAge END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@ReferralDonorAgeUnit, '') = '' THEN 'ILB' ELSE @ReferralDonorAgeUnit END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@ReferralDonorRaceID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralDonorRaceID END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@ReferralDonorGender, '') = '' THEN 'I' ELSE @ReferralDonorGender END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@ReferralDonorWeight, '') = '' THEN 'ILB' ELSE @ReferralDonorWeight END,
		CASE WHEN SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@ReferralDonorAdmitDate, '') = '' THEN '01/01/1900' ELSE @ReferralDonorAdmitDate END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@ReferralDonorAdmitTime, '') = '' THEN 'ILB' ELSE @ReferralDonorAdmitTime END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@ReferralDonorDeathDate, '') = '' THEN '01/01/1900' ELSE @ReferralDonorDeathDate END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@ReferralDonorDeathTime, '') = '' THEN 'ILB' ELSE @ReferralDonorDeathTime END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@ReferralDonorCauseOfDeathID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralDonorCauseOfDeathID END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@ReferralDonorOnVentilator, '') = '' THEN 'ILB' ELSE @ReferralDonorOnVentilator END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@ReferralDonorDead, '') = '' THEN 'ILB' ELSE @ReferralDonorDead END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@ReferralTypeID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTypeID END,
		CASE WHEN SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@ReferralApproachTypeID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralApproachTypeID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@ReferralApproachedByPersonID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralApproachedByPersonID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@ReferralApproachNOK, '') = '' THEN 'ILB' ELSE @ReferralApproachNOK END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 4 = 4 AND IsNull(@ReferralApproachRelation, '') = '' THEN 'ILB' ELSE @ReferralApproachRelation END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@ReferralOrganAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralOrganAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 16 = 16 AND IsNull(@ReferralOrganApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralOrganApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 32 = 32 AND IsNull(@ReferralOrganConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralOrganConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@ReferralOrganConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralOrganConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 4, 1) & 128 = 128 AND IsNull(@ReferralBoneAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralBoneAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 1 = 1 AND IsNull(@ReferralBoneApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralBoneApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 2 = 2 AND IsNull(@ReferralBoneConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralBoneConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 4 = 4 AND IsNull(@ReferralBoneConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralBoneConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 8 = 8 AND IsNull(@ReferralTissueAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTissueAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 16 = 16 AND IsNull(@ReferralTissueApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTissueApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 32 = 32 AND IsNull(@ReferralTissueConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTissueConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 64 = 64 AND IsNull(@ReferralTissueConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTissueConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 5, 1) & 128 = 128 AND IsNull(@ReferralSkinAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralSkinAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 1 = 1 AND IsNull(@ReferralSkinApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralSkinApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 2 = 2 AND IsNull(@ReferralSkinConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralSkinConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 4 = 4 AND IsNull(@ReferralSkinConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralSkinConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 8 = 8 AND IsNull(@ReferralEyesTransAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesTransAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 16 = 16 AND IsNull(@ReferralEyesTransApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesTransApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 32 = 32 AND IsNull(@ReferralEyesTransConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesTransConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 64 = 64 AND IsNull(@ReferralEyesTransConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesTransConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 6, 1) & 128 = 128 AND IsNull(@ReferralEyesRschAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesRschAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 1 = 1 AND IsNull(@ReferralEyesRschApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesRschApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 2 = 2 AND IsNull(@ReferralEyesRschConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesRschConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 4 = 4 AND IsNull(@ReferralEyesRschConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesRschConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 8 = 8 AND IsNull(@ReferralValvesAppropriateID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralValvesAppropriateID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 16 = 16 AND IsNull(@ReferralValvesApproachID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralValvesApproachID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 32 = 32 AND IsNull(@ReferralValvesConsentID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralValvesConsentID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 64 = 64 AND IsNull(@ReferralValvesConversionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralValvesConversionID END,
		CASE WHEN SUBSTRING(@bitmap, 7, 1) & 128 = 128 AND IsNull(@ReferralNotesCase, '') = '' THEN 'ILB' ELSE @ReferralNotesCase END,
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 1 = 1 AND IsNull(@ReferralNotesPrevious, '') = '' THEN 'ILB' ELSE @ReferralNotesPrevious END,
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 2 = 2 THEN IsNull(@ReferralVerifiedOptions, 0) END, -- ILB not required
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 4 = 4 THEN IsNull(@ReferralCoronersCase, 0) END, -- ILB not required
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 8 = 8 THEN IsNull(@Inactive, 0) END, -- ILB not required
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 16 = 16 AND IsNull(@ReferralCallerLevelID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCallerLevelID END,
		ISNULL(@LastModified, @lastModifiedFromLookup),
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 64 = 64 AND IsNull(@UnusedField1, -1) IN ( -1, 0) THEN -2 ELSE @UnusedField1 END,
		CASE WHEN SUBSTRING(@bitmap, 8, 1) & 128 = 128 AND IsNull(@ReferralDonorFirstName, '') = '' THEN 'ILB' ELSE @ReferralDonorFirstName END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 1 = 1 AND IsNull(@ReferralDonorLastName, '') = '' THEN 'ILB' ELSE @ReferralDonorLastName END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 2 = 2 AND IsNull(@ReferralOrganDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralOrganDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 4 = 4 AND IsNull(@ReferralBoneDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralBoneDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 8 = 8 AND IsNull(@ReferralTissueDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralTissueDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 16 = 16 AND IsNull(@ReferralSkinDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralSkinDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 32 = 32 AND IsNull(@ReferralValvesDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralValvesDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 64 = 64 AND IsNull(@ReferralEyesDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralEyesDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 9, 1) & 128 = 128 AND IsNull(@ReferralRschDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralRschDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 1 = 1 AND IsNull(@ReferralAllTissueDispositionID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralAllTissueDispositionID END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 2 = 2 AND IsNull(@ReferralPronouncingMD, -1) IN ( -1, 0) THEN -2 ELSE @ReferralPronouncingMD END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 4 = 4 AND IsNull(@UnusedField3, -1) IN ( -1, 0) THEN -2 ELSE @UnusedField3 END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 8 = 8 AND IsNull(@ReferralNOKPhone, '') = '' THEN 'ILB' ELSE @ReferralNOKPhone END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 16 = 16 AND IsNull(@ReferralAttendingMD, -1) IN ( -1, 0) THEN -2 ELSE @ReferralAttendingMD END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 32 = 32 AND IsNull(@ReferralGeneralConsent, -1) IN ( -1, 0) THEN -2 ELSE @ReferralGeneralConsent END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 64 = 64 AND IsNull(@ReferralNOKAddress, '') = '' THEN 'ILB' ELSE @ReferralNOKAddress END,
		CASE WHEN SUBSTRING(@bitmap, 10, 1) & 128 = 128 AND IsNull(@ReferralCoronerName, '') = '' THEN 'ILB' ELSE @ReferralCoronerName END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 1 = 1 AND IsNull(@ReferralCoronerPhone, '') = '' THEN 'ILB' ELSE @ReferralCoronerPhone END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 2 = 2 AND IsNull(@ReferralCoronerOrganization, '') = '' THEN 'ILB' ELSE @ReferralCoronerOrganization END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 4 = 4 AND IsNull(@ReferralCoronerNote, '') = '' THEN 'ILB' ELSE @ReferralCoronerNote END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 8 = 8 AND IsNull(@ReferralApproachTime, -1) IN ( -1, 0) THEN -2 ELSE @ReferralApproachTime END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 16 = 16 AND IsNull(@ReferralConsentTime, -1) IN ( -1, 0) THEN -2 ELSE @ReferralConsentTime END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 32 = 32 AND IsNull(@Unused, '') = '' THEN '01/01/1900' ELSE @Unused END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 64 = 64 THEN IsNull(@ReferralDOA, 0) END,
		CASE WHEN SUBSTRING(@bitmap, 11, 1) & 128 = 128 AND IsNull(@ReferralDOB, '') = '' THEN '01/01/1900' ELSE @ReferralDOB END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 1 = 1 AND IsNull(@ReferralDonorSSN, '') = '' THEN 'ILB' ELSE @ReferralDonorSSN END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 2 = 2 AND IsNull(@UpdatedFlag, -1) IN ( -1, 0) THEN -2 ELSE @UpdatedFlag END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 4 = 4 AND IsNull(@ReferralExtubated, '') = '' THEN 'ILB' ELSE @ReferralExtubated END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 8 = 8 AND IsNull(@DonorRegistryType, -1) IN ( -1, 0) THEN -2 ELSE @DonorRegistryType END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 16 = 16 AND IsNull(@DonorRegId, -1) IN ( -1, 0) THEN -2 ELSE @DonorRegId END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 32 = 32 AND IsNull(@DonorDMVId, -1) IN ( -1, 0) THEN -2 ELSE @DonorDMVId END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 64 = 64 AND IsNull(@DonorDMVTable, '') = '' THEN 'ILB' ELSE @DonorDMVTable END,
		CASE WHEN SUBSTRING(@bitmap, 12, 1) & 128 = 128 AND IsNull(@DonorIntentDone, -1) IN ( -1, 0) THEN -2 ELSE @DonorIntentDone END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 1 = 1 AND IsNull(@DonorFaxSent, -1) IN ( -1, 0) THEN -2 ELSE @DonorFaxSent END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 2 = 2 AND IsNull(@DonorDSNID, -1) IN ( -1, 0) THEN -2 ELSE @DonorDSNID END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 4 = 4 AND IsNull(@ReferralDonorHeartBeat, -1) IN ( -1) THEN -2 ELSE @ReferralDonorHeartBeat END, --<13, 1, 4>
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 8 = 8 AND IsNull(@ReferralCoronerOrgID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralCoronerOrgID END, --<13, 1, 8>
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 16 = 16 AND IsNull(@CurrentReferralTypeId, -1) IN ( -1, 0) THEN -2 ELSE @CurrentReferralTypeId END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 32 = 32 AND IsNull(@ReferralDonorBrainDeathDate, '') = '' THEN '01/01/1900' ELSE @ReferralDonorBrainDeathDate END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 64 = 64 AND IsNull(@ReferralDonorBrainDeathTime, '') = '' THEN 'ILB' ELSE @ReferralDonorBrainDeathTime END,
		CASE WHEN SUBSTRING(@bitmap, 13, 1) & 128 = 128 AND IsNull(@ReferralPronouncingMDPhone, '') = '' THEN 'ILB' ELSE @ReferralPronouncingMDPhone END,
		CASE WHEN SUBSTRING(@bitmap, 14, 1) & 1 = 1 AND IsNull(@ReferralAttendingMDPhone, '') = '' THEN 'ILB' ELSE @ReferralAttendingMDPhone END,
		CASE WHEN SUBSTRING(@bitmap, 14, 1) & 2 = 2 THEN IsNull(@ReferralDOB_ILB, 0) END,
		CASE WHEN SUBSTRING(@bitmap, 14, 1) & 4 = 4 AND IsNull(@ReferralDonorSpecificCOD, '') = '' THEN 'ILB' ELSE @ReferralDonorSpecificCOD END,
		CASE WHEN SUBSTRING(@bitmap, 14, 1) & 8 = 8 AND IsNull(@ReferralDonorNameMI, '') = '' THEN 'IL' ELSE @ReferralDonorNameMI END,
		CASE WHEN SUBSTRING(@bitmap, 14, 1) & 16 = 16 AND IsNull(@ReferralNOKID, -1) IN ( -1, 0) THEN -2 ELSE @ReferralNOKID END,
		@ReferralQAReviewComplete,    /*14, 1, 32*/
		ISNULL(@LastStatEmployeeID, @lastStatEmployeeIDFromLookup), /* 14, 1, 64 */
		@auditLogTypeIDFromLookup, /* 14, 1, 128 */
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 1 = 1 AND IsNull(@ReferralDonorLSADate, '') = '' THEN '01/01/1900' ELSE @ReferralDonorLSADate END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 2 = 2 AND IsNull(@ReferralDonorLSATime, '') = '' THEN 'ILB' ELSE @ReferralDonorLSATime END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 4 = 4 AND IsNull(@ReferralDCDPotential, -1) = -1 THEN -1 ELSE @ReferralDCDPotential END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 8 = 8 THEN IsNull(@ReferralPendingCase, 0) END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 16 = 16 AND IsNull(@ReferralPendingCaseCoordinator, -1) IN ( -1, 0) THEN -2 ELSE @ReferralPendingCaseCoordinator END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 32 = 32 AND IsNull(@ReferralPendingCaseComment, '') = '' THEN 'ILB' ELSE @ReferralPendingCaseComment END,
		CASE WHEN SUBSTRING(@bitmap, 15, 1) & 64 = 64 AND IsNull(@ReferralPendingCaseLastModified, '') = '' THEN '01/01/1900' ELSE @ReferralPendingCaseLastModified END
	)
		
END		


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

