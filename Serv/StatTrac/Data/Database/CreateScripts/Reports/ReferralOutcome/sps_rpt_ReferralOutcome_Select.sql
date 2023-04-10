IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralOutcome_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralOutcome_Select'
		DROP  Procedure  sps_rpt_ReferralOutcome_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralOutcome_Select'
GO



CREATE Procedure [dbo].[sps_rpt_ReferralOutcome_Select]
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
**		File: sps_rpt_ReferralOutcome_Select.sql
**		Name: sps_rpt_ReferralOutcome_Select
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
**      09/25/2007	ccarroll			Initial release
**      04/2009         jth             fixed handling of null age limits
**		04/19/2010	James Gerberich		Added @Race Parameter,
**		04/20/2010	James Gerberich		Added @ReferralCallerPersonID Parameter and field
**		12/02/2014	Bret Knoll			Broke out the udfs and cleanupd the where clause.
**		02/04/2021	James Gerberich		The old (new) website was submitting 194 as an
**											the Organization Id to the Initial Approacher
**											Summary which is passed in and needs to be null
**		02/08/2021	James Gerberich		Modified to correclty handle 0 values for Referral Type
**											and Cause of Death
*******************************************************************************/
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--- replace use of udf - user defined functions 
	declare		
		@ReferralStartDateTimeAdjusted datetime ,
		@ReferralEndDateTimeAdjusted datetime,
		@CardiacStartDateTimeAdjusted datetime,
		@CardiacEndDateTimeAdjusted datetime;

	set @ReferralStartDateTimeAdjusted = dateadd(hh, -4, @ReferralStartDateTime);
	set @ReferralEndDateTimeAdjusted = dateadd(hh, 4, @ReferralEndDateTime);
	set @CardiacStartDateTimeAdjusted = dateadd(d, -1, @CardiacStartDateTime);
	set @CardiacEndDateTimeAdjusted = dateadd(d, +1, @CardiacEndDateTime);

	if object_id('tempdb..#fn_rpt_ReferralDateTimeConversion') is not null
	begin
		drop table #fn_rpt_ReferralDateTimeConversion
	end
	if object_id('tempdb..#SUBQUERYTABLE') is not null
	begin
		drop table #SubQueryTable;
	end
	if object_id('tempdb..#fn_SourceCodeList') is not null
	begin
		drop table #fn_SourceCodeList;
	end
	create table #fn_rpt_ReferralDateTimeConversion
	(
		CallId int,
		CallDateTime datetime
	);
	create table #SubQueryTable
	(
		Callid INT,
		Calldatetime DATETIME,
		ReferralDonorDeathDateTime DATETIME
	);
	create table #fn_SourceCodeList
	(
		SourceCodeId int
	);
	
	-- load SourceCode based on reportGroupID
		insert #fn_SourceCodeList
			SELECT DISTINCT 
				wrgsc.SourceCodeID
			FROM	WebReportGroupSourceCode wrgsc
			JOIN	SourceCode sc ON sc.SourceCodeID = wrgsc.SourceCodeID	
			WHERE	WebReportGroupID = @ReportGroupID
			AND		(@SourceCodeName IS NULL 
					OR
					sc.SourceCodeName = @SourceCodeName
					)

	-- we need to do some date and time conversions. The next two queries will grab a larger set of records to account for different timezones than what will be needed. 
	--	By doing this we do not use functions in the where clause, when we try to convert the data in the initial select the query becomes a table scan, 
	--	killing the performance.
		insert #SubQueryTable
			SELECT 
				Call.CallID,
				dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Call.CallDateTime, @DisplayMT) 'CallDateTime',		
				CASE 
				WHEN	Referral.ReferralDonorDeathDate IS NULL THEN '01/01/00'
				ELSE 	CONVERT(DATETIME,ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '01/01/00') + ' ' + CASE WHEN ISNULL(ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]' /*(LEN(ISNULL(ReferralDonorDeathTime, '')) < 8) */ THEN '00:00' ELSE ISNULL(substring( ReferralDonorDeathTime,1, 5 ), '00:00')END) 
				END		'ReferralDonorDeathDateTime'
			FROM	Call 
			JOIN	Referral				ON Referral.CallID = Call.CallID 
			join	#fn_SourceCodeList sc	ON Call.sourcecodeid = sc.SourceCodeId
			JOIN	Organization			ON Organization.ORganizationID = referral.referralcallerorganizationID
			WHERE	(@CallID IS NULL 
					OR
					Call.CallID = @CallID
					)	
			AND		( (@ReferralStartDateTime IS NULL AND @REFERRALENDDATETIME IS NULL) -- Looking at original param for null
					OR ( Call.CallDateTime >= @ReferralStartDateTimeAdjusted 
					AND Call.CallDateTime <= @ReferralEndDateTimeAdjusted)
					)
		
			AND		((@CardiacStartDateTime IS NULL AND @CardiacEndDateTime IS NULL) -- Looking at original param for null
					OR
					(REFERRAL.REFERRALDONORDEATHDATE >= @CardiacStartDateTimeAdjusted
					AND 
					REFERRAL.REFERRALDONORDEATHDATE <= @CardiacEndDateTimeAdjusted)			
					);

	
		-- now that we have records with the converted datetime we can select the subset we need. 
		insert #fn_rpt_ReferralDateTimeConversion		
		SELECT	CallID, 
				CallDateTime
		FROM	#SubQueryTable SUBQUERY
 
		WHERE	((@ReferralStartDateTime IS NULL AND @ReferralEndDateTime IS NULL)
				OR
				(CallDateTime >= @ReferralStartDateTime
				AND CallDateTime <= @ReferralEndDateTime)
				)
		AND		((@CardiacStartDateTime IS NULL AND @CardiacEndDateTime IS NULL)
				OR
				(ReferralDonorDeathDateTime >= @CardiacStartDateTime
				AND ReferralDonorDeathDateTime <= @CardiacEndDateTime)
				);

--if Statline is supplied as the organization id, get all organizations
IF @OrganizationID = 194
BEGIN
	SET @OrganizationID = NULL
END;


SELECT DISTINCT 
	call.CallID,
	call.CallNumber,
	ReferralType.ReferralTypeName AS 'PreliminaryRefType',
	ReferralType.ReferralTypeID,
	LT.CallDateTime AS BasedOnDT,
	/* Caller Information */
	
	Organization.OrganizationName AS 'ReferralFacility',
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	CallerPerson.PersonID,
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',

	/* Initial Approach -  */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN isnull(HospitalApproach.ApproachTypeName, ApproachType.ApproachTypeName) -- pull from Secondary
		 ELSE ApproachType.ApproachTypeName     -- pull from Triage
	END AS 'InitialApproachType',

	/* Initial Approach Outcome - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null and SecondaryApproach.SecondaryHospitalOutcome > 0
		 THEN (CASE SecondaryApproach.SecondaryHospitalOutcome
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
		 ELSE
			  (CASE Referral.ReferralGeneralConsent
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
	END AS 'InitialConsent',
	
	/* Initial Approacher - */
	Referral.ReferralApproachedByPersonID,
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN ISNULL(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + ISNULL(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
		 ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
	END AS 'InitialApproacher',

	/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN InformedApproach.FSApproachTypeName
		 ELSE '' 
	END AS 'FinalApproachType',

	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN 
				(CASE SecondaryApproach.SecondaryApproachOutcome
					WHEN 1 THEN 'Yes-Verbal'
					WHEN 2 THEN 'Yes-Written'
					WHEN 3 THEN 'No'
					WHEN 4 THEN 'Undecided' 
					ELSE null 
				 END)
		 ELSE null
	END AS 'FinalApproachOutcome',
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN ISNULL(InformedApproachPerson.PersonFirst, null) + ' ' + ISNULL(InformedApproachPerson.PersonLast, null)
		 ELSE null
	END AS 'FinalApproacher',

	/* Patient Information */
	--IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	CASE WHEN ServiceLevel.ServiceLevelLastName = -1 and ServiceLevel.ServiceLevelFirstName = -1 THEN IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientName', 
	CASE WHEN ServiceLevel.ServiceLevelGender = -1 THEN Referral.ReferralDonorGender ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientGender', 
	CASE WHEN ServiceLevel.ServiceLevelAge = -1 THEN Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientAge', 
	CASE WHEN ServiceLevel.ServiceLevelRace = -1 THEN race.RaceName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientRace', 
	CASE WHEN ServiceLevel.ServiceLevelRecNum = -1 THEN Referral.ReferralDonorRecNumber ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'MedicalRecordNumber', 
	ISNULL(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus,
	CauseOfDeathName AS 'CauseOfDeath',
	--dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Referral.ReferralDonorDeathDate, @DisplayMT) 
	--LT.ReferralDonorDeathDateTime AS 'CardiacDeathDateTime',
	CASE WHEN ServiceLevel.ServiceLevelDeathDate = -1 THEN CASE WHEN ISNULL(Referral.ReferralDonorDeathDate, '') = '' THEN ' ' ELSE convert(char(10),Referral.ReferralDonorDeathDate,101) + ' '+ Referral.ReferralDonorDeathTime END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'CardiacDeathDateTime',
	Referral.ReferralDonorDeathDate,
	/* Disposition */
		/* Custom Mapping
		1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.
			ref: sub_DynamicDonorCategory.rdl

		Note: If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied */

		/* Organ @UserOrgId = 194 OR */
		--AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateOrgan = -1 THEN AppropOrgan.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		--AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateBone = -1 THEN AppropBone.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		--AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateTissue = -1 THEN AppropTissue.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		--AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateSkin = -1 THEN AppropSkin.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		--AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateValves = -1 THEN AppropValve.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		--AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateEyes = -1 THEN AppropEyes.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateRsch = -1 THEN AppropRsch.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachRsch = -1 THEN ApproaRsch.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentRsch = -1 THEN ConsentRsch.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryRsch = -1 THEN RecoveryRsch.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOther,

		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',

				
		/* RS sub-report paramaters for DynamicDonorCategory */
		Referral.ReferralCallerOrganizationID,
		SourceCode.SourceCodeID,
		SourceCode.SourceCodeName,
		ReferralGeneralConsent,
		ReferralApproachTypeID,
		ReferralOrganAppropriateID,
		ReferralOrganApproachID,
		ReferralOrganConsentID,
		ReferralOrganConversionID  ,
		ReferralBoneAppropriateID  ,
		ReferralBoneApproachID  ,
		ReferralBoneConsentID  ,
		ReferralBoneConversionID  ,
		ReferralTissueAppropriateID  ,
		ReferralTissueApproachID  ,
		ReferralTissueConsentID  ,
		ReferralTissueConversionID  ,
		ReferralSkinAppropriateID  ,
		ReferralSkinApproachID  ,
		ReferralSkinConsentID  ,
		ReferralSkinConversionID  ,
		ReferralEyesTransAppropriateID  ,
		ReferralEyesTransApproachID  ,
		ReferralEyesTransConsentID  ,
		ReferralEyesTransConversionID  ,
		ReferralEyesRschAppropriateID  ,
		ReferralEyesRschApproachID  ,
		ReferralEyesRschConsentID  ,
		ReferralEyesRschConversionID  ,
		ReferralValvesAppropriateID  ,
		ReferralValvesApproachID  ,
		ReferralValvesConsentID  ,
		ReferralValvesConversionID , 
		FSCaseBillSecondaryUserID ,
		FSCaseBillApproachUserID ,
		FSCaseBillMedSocUserID ,
		FSCaseBillFamUnavailUserID ,
		FSCaseBillCryoFormUserID ,
		FSCaseBillApproachCount ,
		FSCaseBillMedSocCount ,
		FSCaseBillCryoFormCount,
		RegistryStatus.RegistryStatus
		

	FROM	Call
	-- now use temptable to join on .
	join	#fn_rpt_ReferralDateTimeConversion LT on Call.CallID =  LT.CallId 	
	JOIN	Referral ON Referral.CallID = Call.CallID 	
	LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
	LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID

	/* Changed to LEFT JOIN to display triage data Ref:OutcomeByCategory Report
		See WHERE clause addition below*/
	LEFT JOIN FSCase ON FSCase.CallID = Call.CallID

	/* Hospital Approach */
	LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID
	LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
	LEFT JOIN Person AS HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy

	/* Informed Approach */
	LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
	LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy

	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
	LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
	LEFT JOIN RegistryStatus ON RegistryStatus.CallId = Call.CallId 
	LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
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
		/* Search - ReportGroup */
WHERE	((@ReportGroupID IS NULL)
		OR	
		(WebReportGroupOrg.WebReportGroupID = @ReportGroupID )
		)
	
		/* Search - Organization */
AND		(@OrganizationID is null 
		OR
		Referral.ReferralCallerOrganizationID = @OrganizationID
		)
		
		/* Search - Referral Type */
AND		(
			(@ReferralType is null
			OR	@ReferralType = 0)
		OR
		Referral.ReferralTypeID = @ReferralType
		)
		/* Search - CauseOfDeath */
AND		(
			(@CauseOfDeath is null
			OR	@CauseOfDeath = 0)
		OR
		Referral.ReferralDonorCauseOfDeathID = @CauseOfDeath
		)

		/* Search - Lower/Upper Age Limit */
AND		((@LowerAgeLimit is null and @UpperAgeLimit is null )
		OR
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit) >= @LowerAgeLimit 
		AND
		dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit) <= @UpperAgeLimit)
		)
			
		/* Search - Coordinator */
AND		(@CoordinatorID IS NULL 
		OR
		LogEvent.StatEmployeeID = @CoordinatorID
		)

		/* Search - Gender */
AND		(@Gender IS NULL 
		OR
		PATINDEX(@Gender, Referral.ReferralDonorGender) > 0
		)
	
		/* Search (wildcards permitted) - PatientLastName */
AND		(@PatientLastName IS NULL
		OR
		PATINDEX(@PatientLastName, Referral.ReferralDonorLastName) > 0
		)
		/* Search (wildcards permitted) - PatientFirstName */
AND		(@PatientFirstName IS NULL
		OR
		PATINDEX(@PatientFirstName, Referral.ReferralDonorFirstName) > 0
		)
		/* Search (wildcards permitted) - Medical Record# */
AND		(@MedicalRecordNumber IS NULL
		OR
		PATINDEX(@MedicalRecordNumber, Referral.ReferralDonorRecNumber) > 0
		);

if object_id('tempdb..#fn_rpt_ReferralDateTimeConversion') is not null
	begin
		drop table #fn_rpt_ReferralDateTimeConversion
	end
	if object_id('tempdb..#SUBQUERYTABLE') is not null
	begin
		drop table #SubQueryTable;
	end
	if object_id('tempdb..#fn_SourceCodeList') is not null
	begin
		drop table #fn_SourceCodeList;
	end
GO


