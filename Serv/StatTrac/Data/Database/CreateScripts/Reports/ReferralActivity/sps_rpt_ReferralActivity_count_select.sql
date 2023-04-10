 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity_count_select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity'
		DROP  Procedure  sps_rpt_ReferralActivity_count_select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity_count_select'
GO


CREATE Procedure sps_rpt_ReferralActivity_count_select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity_count_select.sql
**		Name: sps_rpt_ReferralActivity_count_select
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
**		Auth: jth
**		Date: 05/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		09/30/2008		ccarroll			Added for Archive and Production selects
*******************************************************************************/


SELECT  COUNT(DISTINCT Referral.CallID) 'RecordCount'
FROM Call 
Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID 
	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	INNER JOIN AlertOrganization ON Referral.ReferralCallerOrganizationID = AlertOrganization.OrganizationID 
	INNER JOIN  AlertSourceCode ON Call.SourceCodeID = AlertSourceCode.SourceCodeID 
	INNER JOIN  Alert ON AlertOrganization.AlertID = Alert.AlertID  
	AND AlertSourceCode.AlertID = Alert.AlertID 
	--LEFT JOIN AlertOrganization ON AlertOrganization.OrganizationID = Organization.OrganizationID AND Organization.Inactive = 0
	--LEFT JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID 
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
	LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 

WHERE ISNULL(@CallID,call.CallID) = call.CallID


	/* Search - ReportGroup */
		AND Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))

	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)

	/* Search - Referral Type */
		AND IsNull(Referral.ReferralTypeID, 0) = IsNull(@ReferralType, IsNull(Referral.ReferralTypeID, 0))

	/* Search - Lower/Upper Age Limit */
		AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0))	OR 	(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)		
	/* Search - Coordinator */
		AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))

	/* Search - Gender */
		AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))

		AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)

	/* Search (wildcards permitted) - PatientLastName */
	--	AND PATINDEX(IsNull(@PatientLastName, IsNull(Referral.ReferralDonorLastName, 0)), IsNull(Referral.ReferralDonorLastName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientLastName, ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
	/* Search (wildcards permitted) - PatientFirstName */
		--AND PATINDEX(IsNull(@PatientFirstName, IsNull(Referral.ReferralDonorFirstName, 0)), IsNull(Referral.ReferralDonorFirstName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientFirstName, ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
	/* Search (wildcards permitted) - Medical Record# */
	--	AND PATINDEX(IsNull(@MedicalRecordNumber, IsNull(Referral.ReferralDonorRecNumber, 0)), IsNull(Referral.ReferralDonorRecNumber, 0)) > 0
	AND ISNULL(PATINDEX(@MedicalRecordNumber, ISNULL(Referral.ReferralDonorRecNumber, 0)), -1) <> 0

GO

