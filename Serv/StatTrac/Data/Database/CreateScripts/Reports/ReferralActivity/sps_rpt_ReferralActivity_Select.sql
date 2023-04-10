IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity_Select'
		DROP  Procedure  sps_rpt_ReferralActivity_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity_Select'
GO


CREATE Procedure sps_rpt_ReferralActivity_Select
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
**		File: sps_rpt_ReferralActivity_Select.sql
**		Name: sps_rpt_ReferralActivity_Select
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
**		Date: 08/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      08/30/2007		ccarroll			Initial release
**		11/15/2007		ccarroll			Added FN for ConvertDateTime
**		06/2008 		jth					fix cardiac/referral date selection, create groupby field, 
**											remove unneeded columns,fixed join to get alert group
**		09/30/2008		ccarroll			Added selection for Archive data
**      04/2009         jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
**      04/2009         jth                 fixed handling of null age limits
**		04/04/2012		ccarroll			HS 31129 Duplicate referrals: Added Alert.AlertTypeID = 1 to JOIN
*******************************************************************************/


SELECT  DISTINCT
	call.CallID,
	call.CallNumber,
	ReferralType.ReferralTypeName AS 'ReferralType',
	Alert.AlertGroupName AS 'AlertGroup',
	Alert.AlertID,
	CASE WHEN (@CardiacStartDateTime Is Not Null) 
		 --THEN ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorDeathTime, ' ')
		 THEN convert(datetime,ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + substring(ISNULL(ReferralDonorDeathTime, '00:00 '),1,5))
		ELSE LT.CallDateTime
		 END AS 'BasedOnDT1',
	/* LT.CallDateTime AS CallDateTime,
	CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
	CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
	Caller Information */
	Organization.OrganizationName AS 'ReferralFacility',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	CASE WHEN (@ReportGroupID = 37) 
		 THEN Alert.AlertGroupName
		 ELSE Organization.OrganizationName
		 END AS GroupBy,
	/* Patient Information */
	IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / ' + Referral.ReferralDonorGender + ' / ' + isnull(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
	Referral.ReferralDonorRecNumber AS 'MedicalRecordNumber',

	/* Disposition */
		/* Custom Mapping
		1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.

		Note: If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied */

		/* Organ @UserOrgId = 194 OR */
		AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		AppropRsch.AppropriateReportName AS AppropriateOther,
		ApproaRsch.ApproachReportName AS ApproachOther,
		ConsentRsch.ConsentReportName AS ConsentOther,
		RecoveryRsch.ConversionReportName AS RecoveryOther,

		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',

		/* RS GroupBy ReferralType ID */
		Referral.ReferralTypeID,

		/* ReferralType Counts */
		Case WHEN Referral.ReferralTypeID = 1 THEN 1 ELSE 0 END AS 'CountOrganTissueEye',
		Case WHEN Referral.ReferralTypeID = 2 THEN 1 ELSE 0 END AS 'CountTissueEye',
		Case WHEN Referral.ReferralTypeID = 3 THEN 1 ELSE 0 END AS 'CountEyesOnly',
		Case WHEN IsNull(Referral.ReferralTypeID, 0) = 4 THEN 1 ELSE 0 END AS 'CountRuleOut'
	
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
	INNER JOIN  Alert ON AlertOrganization.AlertID = Alert.AlertID  AND AlertSourceCode.AlertID = Alert.AlertID AND Alert.AlertTypeID = 1
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

GROUP BY

	Referral.ReferralTypeID,
	Call.CallID,
	Call.CallNumber,
	Alert.AlertID,
	LT.CallDateTime,

	Referral.ReferralCallerOrganizationID,
	ReferralType.ReferralTypeName,

	Referral.ReferralDonorDeathDate,
	Referral.ReferralDonorDeathTime,
	Referral.ReferralCallerSubLocationLevel,
	Referral.ReferralDonorLastName,
	Referral.ReferralDonorFirstName,
	Referral.ReferralDonorNameMI,
	Referral.ReferralDonorAge,
	Referral.ReferralDonorAgeUnit,
	Referral.ReferralDonorGender,
	Referral.ReferralDonorRecNumber,

	Organization.OrganizationName,
	CallerPerson.PersonFirst,
	CallerPerson.PersonLast,
	SubLocation.SubLocationName,
	Race.RaceName,

	AppropOrgan.AppropriateReportName,
	AppropTissue.AppropriateReportName,
	AppropBone.AppropriateReportName,
	AppropSkin.AppropriateReportName,
	AppropValve.AppropriateReportName,
	AppropEyes.AppropriateReportName,
	AppropRsch.AppropriateReportName,

	ApproaOrgan.ApproachReportName,
	ApproaBone.ApproachReportName,
	ApproaTissue.ApproachReportName,
	ApproaSkin.ApproachReportName,
	ApproaValve.ApproachReportName,
	ApproaEyes.ApproachReportName,
	ApproaRsch.ApproachReportName,

	ConsentOrgan.ConsentReportName,
	ConsentBone.ConsentReportName,
	ConsentTissue.ConsentReportName,
	ConsentSkin.ConsentReportName,
	ConsentValve.ConsentReportName,
	ConsentEyes.ConsentReportName,
	ConsentRsch.ConsentReportName,

	RecoveryOrgan.ConversionReportName,
	RecoveryBone.ConversionReportName,
	RecoveryTissue.ConversionReportName,
	RecoverySkin.ConversionReportName,
	RecoveryValve.ConversionReportName,
	RecoveryEyes.ConversionReportName,
	RecoveryRsch.ConversionReportName,

	ServiceLevel.ServiceLevelApproachOrgan,
	ServiceLevel.ServiceLevelApproachBone,
	ServiceLevel.ServiceLevelApproachTissue,
	ServiceLevel.ServiceLevelApproachSkin,
	ServiceLevel.ServiceLevelApproachValves,
	ServiceLevel.ServiceLevelApproachEyes,

	ServiceLevel.ServiceLevelConsentOrgan,
	ServiceLevel.ServiceLevelConsentBone,
	ServiceLevel.ServiceLevelConsentTissue,
	ServiceLevel.ServiceLevelConsentSkin,
	ServiceLevel.ServiceLevelConsentValves,
	ServiceLevel.ServiceLevelConsentEyes,

	ServiceLevel.ServiceLevelRecoveryOrgan,
	ServiceLevel.ServiceLevelRecoveryBone,
	ServiceLevel.ServiceLevelRecoveryTissue,
	ServiceLevel.ServiceLevelRecoverySkin,
	ServiceLevel.ServiceLevelRecoveryValves,
	ServiceLevel.ServiceLevelRecoveryEyes,
	Alert.AlertGroupName



GO

