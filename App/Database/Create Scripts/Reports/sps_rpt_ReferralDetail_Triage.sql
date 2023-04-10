IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id(N'[dbo].[sps_rpt_ReferralDetail_Triage]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_Triage';
		DROP  PROCEDURE  sps_rpt_ReferralDetail_Triage;
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_Triage';
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_ReferralDetail_Triage]
(
	@CallID					int			= NULL,
	@ReferralStartDateTime	DateTime	= NULL,
	@ReferralEndDateTime	DateTime	= NULL,
	@CardiacStartDateTime	DateTime	= NULL,
	@CardiacEndDateTime		DateTime	= NULL,
	@ReportGroupID			int			= NULL,
	@OrganizationID			int			= NULL,
	@SourceCodeName			varchar(10) = NULL,
	@CoordinatorID			int			= NULL,
	@LowerAgeLimit			int			= NULL,
	@UpperAgeLimit			int			= NULL,
	@Gender					varchar(1)	= NULL,
	@UserOrgID				int			= NULL,
	@DisplaySecondary		smallint	= NULL,
	@DisplayMT				int			= NULL
 )
AS
/******************************************************************************
**  File: sps_rpt_ReferralDetail_Triage.sql
**  Name: sps_rpt_ReferralDetail_Triage
**  Desc:
**
**
**  Return values:
**
**  Called by: ReferralDetail.rdl
**
**  Parameters:
**	Input		Output  
**	----------	-----------
**  See Above
**  
**  Auth: christopher carroll
**  Date: 06/13/2007
**
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:		Author:			Description:
**  --------	--------		-------------------------------------------
**	6/20/2007	ccarroll		Initail release
**  8/20/2007	ccarroll		Empirix 6728, 6729, 6730, 2726
**  8/29/2007	ccarroll		Empirix 6839
**  11/14/2007	ccarroll		TimeZone requirement changes
**  04/07/2008	jth				Added @listTable and adjusted DeathDateConversion
**  04/25/208	Bret			Replace @listTable with dbo.fn_rpt_ReferralDateTimeConversion
**  05/08/2008	ccarroll		Changed ServiceLevelAttendingMD, ServiceLevelPronounceingMD from -1 to 1
**  10/02/2008	ccarroll		Added select sproc for Archive and Production db
**	03/09		jth				Don't use NOKID to link to state table to get state abbreviation
**	04/2009		jth				Fixed handling of NULL age limits
**	05/2009		jth				Changed ServiceLevelAttendingMD, ServiceLevelPronounceingMD test from = 1 to > 0
**								...for some reason ServiceLevelAttendingMD is getting set with a 2
**  12/08/2009	ccarroll		Removed table alias in ORDER BY for SQL Server 2008 update
**  03/16/2010	ccarroll		Added this note for inclusion in release
**  04/01/2010	JEGerberich		Concatented ReferralCallerExtension with ReferralPhone HS 22712
**  06/16/2010	Bret			Modified to Include in change
**	09/2011		jth				Added LSADateTime
**  10/13/2011	ccarroll		Added note for inclusion in release
**  12/17/2013	jegerberich		Corrected bug for NOK State used in ReferralNOKCSZ HS 38081
**  05/14/2019	jegerberich		Account for NULL NOK information. VS 66070
**	08/04/2020	james gerberich	Refactored for performance. VS 69297
**	10/08/2020	James Gerberich	Added Referral Facility Time Zone to Extubation Date. VS 71473
******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
----------------------------------------------------------------

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;
----------------------------------------------------------------

-- If a Call ID is provided ignore all other parameters
IF(@CallID IS NOT NULL AND @CallID <> 0)
BEGIN SELECT
	@ReferralStartDateTime	= NULL,
	@ReferralEndDateTime	= NULL,
	@CardiacStartDateTime	= NULL,
	@CardiacEndDateTime		= NULL,
	@OrganizationID			= NULL,
	@SourceCodeName			= NULL,
	@CoordinatorID			= NULL,
	@LowerAgeLimit			= NULL,
	@UpperAgeLimit			= NULL,
	@Gender					= NULL;
END;
----------------------------------------------------------------

-- Get the default value for NULL Service Levels
DECLARE
	@ServiceLevelDefault	varchar(10) = (SELECT dbo.fn_ServiceLevelDefault(NULL));
----------------------------------------------------------------

-- Get list of needed Source Codes 
SELECT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);
--------------------------------

-- Converts CallDateTime to proper time zone and gets Case IDs within the date range
SELECT
	CallID,
	CallDateTime
INTO #ConvertedDate
FROM dbo.fn_rpt_ReferralDateTimeConversion
(
	@CallID,
	@ReferralStartDateTime,
	@ReferralEndDateTime,
	@CardiacStartDateTime,
	@CardiacEndDateTime,
	@DisplayMT
);
----------------------------------------------------------------

-- Get basic info for needed cases and initial filters
SELECT DISTINCT
	c.CallID,
	c.CallNumber,
	LT.CallDateTime AS CallDateTime,
	CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
	CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
	dbo.fn_rpt_DonorAgeYear(ReferralDOB, ReferralDonorDeathDate,ReferralDonorAge, ReferralDonorAgeUnit) AS DonorAge,
	/* Caller Information */
	c.StatEmployeeID,
	c.SourceCodeID,
	SourceCode.SourceCodeName,
	Organization.OrganizationID,
	Organization.OrganizationName AS 'ReferralFacility',
	Organization.OrganizationAddress1 + ' ' + IsNULL(Organization.OrganizationAddress2,' ') AS 'ReferralAddress',
	Organization.OrganizationCity + ', ' + st.stateabbrv + ' ' + Organization.OrganizationZipCode AS 'ReferralCSZ',
	tz.TimeZoneAbbreviation AS OrganizationTimeZone
INTO #Calls
FROM
	dbo.[Call] c
	INNER JOIN #SourceCodes sc
			LEFT JOIN SourceCode ON sc.SourceCodeID = SourceCode.SourceCodeID
		ON sc.SourceCodeID = c.SourceCodeID
	INNER JOIN #ConvertedDate LT ON LT.CallID = c.CallID
	INNER JOIN Referral ON Referral.CallID = c.CallID
	INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN [State] st ON st.StateID = Organization.StateID
	LEFT JOIN TimeZone tz ON Organization.TimeZoneId = tz.TimeZoneID
WHERE
	WebReportGroupOrg.WebReportGroupID = @ReportGroupID
AND	(
		@OrganizationID IS NULL
	OR	Referral.ReferralCallerOrganizationID = @OrganizationID
	)
AND	(
		@Gender IS NULL
	OR	Referral.ReferralDonorGender = @Gender
	);
--------------------------------

-- Get expanded info and final filters
SELECT DISTINCT
	c.*,
	ReferralType.ReferralTypeName AS PreliminaryRefType,
	CurrentRefType.ReferralTypeName AS CurrentRefType,
	COALESCE(Person.PersonFirst,' ') + ' ' + COALESCE(Person.PersonLast,' ') AS TriageCoordinator,

	/* Caller Information */
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber + IsNULL(' x' + ReferralCallerExtension, ' No Ext') AS 'Referralphone',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
	CallPersonType.PersonTypeName AS 'ReferralPersonTitle',
	ReferralCallerExtension AS 'ReferralPersonExtension',
	@SourceCodeName AS SourceCodeName,

	/* Patient Information */
	CASE
		WHEN ServiceLevel.ServiceLevelFirstName = -1
		THEN IsNULL(Referral.ReferralDonorFirstName, '')
		ELSE @ServiceLevelDefault
	END AS 'ReferralDonorFirstName',
	COALESCE(Referral.ReferralDonorNameMI,'') AS 'ReferralDonorNameMI',
	CASE
		WHEN ServiceLevel.ServiceLevelLastName = -1
		THEN IsNULL(Referral.ReferralDonorLastName, '')
		ELSE @ServiceLevelDefault
	END AS 'ReferralDonorLastName',
	CASE
		WHEN ServiceLevel.ServiceLevelDOB = -1
		THEN
			CASE
				WHEN COALESCE(ReferralDOB_ILB, 0) = -1
				THEN 'Unknown'
				ELSE CONVERT(varchar,ReferralDOB,101)
			END
		ELSE @ServiceLevelDefault
	END AS 'DateOfBirth',
	CASE
		WHEN ServiceLevel.ServiceLevelAge = -1
		THEN Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1))
		ELSE @ServiceLevelDefault
	END + ' / ' +
			CASE
				WHEN ServiceLevel.ServiceLevelGender = -1
				THEN Referral.ReferralDonorGender
				ELSE @ServiceLevelDefault
			END + ' / ' +
					CASE
						WHEN ServiceLevel.ServiceLevelRace = -1
						THEN IsNULL(UPPER(SUBSTRING(race.RaceName,1,2)),'')
						ELSE @ServiceLevelDefault
					END AS 'A/S/R',
	CASE
		WHEN ServiceLevel.ServiceLevelSSN = -1
		THEN Referral.ReferralDonorSSN
		ELSE @ServiceLevelDefault
	END AS 'DonorSSN',
	CASE
		WHEN ServiceLevel.ServiceLevelRecNum = -1
		THEN Referral.ReferralDonorRecNumber
		ELSE @ServiceLevelDefault
	END AS 'MedicalRecordNumber',
	CASE
		WHEN ServiceLevel.ServiceLevelWeight = -1
		THEN Referral.ReferralDonorWeight
		ELSE @ServiceLevelDefault
	END AS 'DonorWeight',
	CASE
		WHEN ServiceLevel.ServiceLevelCOD = -1
		THEN CauseOfDeathName
		ELSE @ServiceLevelDefault
	END AS 'CauseOfDeath',
	CASE
		WHEN ServiceLevel.ServiceLevelDonorSpecificCOD = -1
		THEN Referral.ReferralDonorSpecificCOD
		ELSE @ServiceLevelDefault
	END AS 'ReferralDonorSpecificCOD',
	CASE
		WHEN ServiceLevel.ServiceLevelVent = -1
		THEN ReferralDonorOnVentilator
		ELSE @ServiceLevelDefault
	END AS 'OnVentilation',
	CASE ReferralDonorHeartBeat
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE ''
	END AS 'ReferralDonorHeartBeat',
	LTRIM(RTRIM(Referral.ReferralExtubated + ' ' + c.OrganizationTimeZone)) AS ReferralExtubated,
	CASE
		WHEN ServiceLevel.ServiceLevelAdmitDate = -1
		THEN COALESCE(CONVERT(varchar, ReferralDonorAdmitDate, 101),' ') + ' ' + COALESCE(ReferralDonorAdmitTime, ' ')
		ELSE @ServiceLevelDefault
	END AS 'DonorAdmitDT',
	CASE
		WHEN ServiceLevel.ServiceLevelDeathDate = -1
		THEN COALESCE(CONVERT(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + COALESCE(ReferralDonorDeathTime, ' ')
		ELSE @ServiceLevelDefault
	END AS 'DonorCardiacDeathDT',
	CASE
		WHEN ServiceLevel.ServiceLevelDonorBrainDeathDate = -1
		THEN COALESCE(CONVERT(varchar, ReferralDonorBrainDeathDate, 101),' ') + ' ' + COALESCE(ReferralDonorBrainDeathTime, ' ')
		ELSE @ServiceLevelDefault
	END AS 'DonorBrainDeathDT',
	COALESCE(CONVERT(varchar, ReferralDonorLSADate, 101),' ') + ' ' + COALESCE(ReferralDonorLSATime, ' ') AS 'DonorLSADeathDT',
	Referral.ReferralDOA,
	Referral.ReferralNotesCase AS 'MedicalHistory',

	/* Disposition */
	 /* Custom Mapping
	 1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.

	 Note: If client's service level is turned off, default values are set by the
	 function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the
	 future by changing the return value in the function. All reports using this function will
	 receive the new default value. Passing the function either a blank ('') or NULL value will cause
	 the default value to be returned. If the UserOrg = 194 all data will be displaied */

	/* Organ */
	CASE
		WHEN @UserOrgId = 194
			OR ServiceLevel.ServiceLevelAppropriateOrgan = -1
		THEN AppropOrgan.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateOrgan,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachOrgan = -1
		THEN ApproaOrgan.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachOrgan,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentOrgan = -1
		THEN ConsentOrgan.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentOrgan,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryOrgan = -1
		THEN RecoveryOrgan.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryOrgan,

	/* Bone*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateBone = -1
		THEN AppropBone.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateBone,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachBone = -1
		THEN ApproaBone.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachBone,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentBone = -1
		THEN ConsentBone.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentBone,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryBone = -1
		THEN RecoveryBone.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryBone,

	/* Tissue*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateTissue = -1
		THEN AppropTissue.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateTissue,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachTissue = -1
		THEN ApproaTissue.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachTissue,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentTissue = -1
		THEN ConsentTissue.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentTissue,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryTissue = -1
		THEN RecoveryTissue.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryTissue,

	/* Skin*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateSkin = -1
		THEN AppropSkin.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateSkin,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachSkin = -1
		THEN ApproaSkin.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachSkin,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentSkin = -1
		THEN ConsentSkin.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentSkin,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoverySkin = -1
		THEN RecoverySkin.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoverySkin,

	/* Valves*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateValves = -1
		THEN AppropValve.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateValve,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachValves = -1
		THEN ApproaValve.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachValve,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentValves = -1
		THEN ConsentValve.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentValve,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryValves = -1
		THEN RecoveryValve.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryValve,

	/* Eyes*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateEyes = -1
		THEN AppropEyes.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateEyes,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachEyes = -1
		THEN ApproaEyes.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachEyes,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentEyes = -1
		THEN ConsentEyes.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentEyes,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryEyes = -1
		THEN RecoveryEyes.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryEyes,

	/* Other*/
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelAppropriateRsch = -1
		THEN AppropRsch.AppropriateReportName
		ELSE @ServiceLevelDefault
	END AS AppropriateOther,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelApproachRsch = -1
		THEN ApproaRsch.ApproachReportName
		ELSE @ServiceLevelDefault
	END AS ApproachOther,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelConsentRsch = -1
		THEN ConsentRsch.ConsentReportName
		ELSE @ServiceLevelDefault
	END AS ConsentOther,
	CASE
		WHEN @UserOrgId = 194
		OR ServiceLevel.ServiceLevelRecoveryRsch = -1
		THEN RecoveryRsch.ConversionReportName
		ELSE @ServiceLevelDefault
	END AS RecoveryOther,

	/* Approach Imformation */
	/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		THEN InformedApproach.FSApproachTypeName
		ELSE ''
	END AS 'FinalApproachType',

	/* Initial Approach -  */
	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		AND FSCase.CallID IS NOT NULL
		THEN IsNULL(HospitalApproach.ApproachTypeName,ApproachType.ApproachTypeName) -- pull from Secondary
		ELSE ApproachType.ApproachTypeName     -- pull from Triage
	END AS 'InitialApproachType',
	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		THEN COALESCE(InformedApproachPerson.PersonFirst, '') + ' ' + COALESCE(InformedApproachPerson.PersonLast, '')
		ELSE ''
	END AS 'FinalApproacher',

	/* Initial Approacher - */
	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		AND FSCase.CallID IS NOT NULL
		THEN COALESCE(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + COALESCE(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
		ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
	END AS 'InitialApproacher',

	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		THEN
			CASE SecondaryApproach.SecondaryApproachOutcome
				WHEN 1 THEN 'Yes-Verbal'
				WHEN 2 THEN 'Yes-Written'
				WHEN 3 THEN 'No'
				WHEN 4 THEN 'Undecided'
				ELSE ''
			END
	  ELSE ''
	END AS 'FinalOutcome',

	/* Initial Approach Outcome - */
	CASE
		WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT NULL
		AND SecondaryApproach.SecondaryHospitalOutcome > 0
		THEN
			CASE SecondaryApproach.SecondaryHospitalOutcome
				WHEN 1 THEN 'Yes-Written'
				WHEN 2 THEN 'Yes-Verbal'
				WHEN 3 THEN 'No'
			END
		ELSE
			CASE Referral.ReferralGeneralConsent
				WHEN 1 THEN 'Yes-Written'
				WHEN 2 THEN 'Yes-Verbal'
				WHEN 3 THEN 'No'
		   END
	END AS 'Initial Outcome',

	COALESCE(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus,

	/* Next of Kin Information */
	CASE
		WHEN ReferralNOKID > 0
		THEN LEFT(REPLACE(REPLACE(IsNULL(NOK.NOKFirstName,'') + IsNULL(' ' + NOK.NOKLastName,''),CHAR(10), CHAR(32)), CHAR(13), ''),50)
		ELSE ReferralApproachNOK
	END AS ReferralApproachNOK,
	CASE
		WHEN ServiceLevel.ServiceLevelRelation = -1
		THEN
			CASE
				WHEN ReferralNOKID > 0
				THEN NOK.NOKApproachRelation
				ELSE ReferralApproachRelation
			END
		ELSE @ServiceLevelDefault
	END AS 'ReferralApproachRelation',
	CASE
		WHEN ServiceLevel.ServiceLevelNOKPhone = -1
		THEN
			CASE
				WHEN ReferralNOKID > 0
				THEN NOK.NOKPhone
				ELSE ReferralNOKPhone
			END
		ELSE @ServiceLevelDefault
	END AS 'ReferralNOKPhone',
	CASE
		WHEN ServiceLevel.ServiceLevelNOKAddress = -1
		THEN
			CASE
				WHEN ReferralNOKID > 0
				THEN Referral.ReferralNOKAddress
			END
		ELSE @ServiceLevelDefault
	END AS 'ReferralNOKAddress',
	CASE
		WHEN ReferralNOKID > 0
		THEN IsNULL(NOK.NOKCity,'') + IsNULL(', ' + nokst.StateAbbrv,'') + IsNULL(' ' + NOK.NOKZip,'')
	END AS ReferralNOKCSZ,
	rcs.StateAbbrv, -- ReferralCoronerStateAbbrvst.StateAbbrv,

	/* Physician Information */
	CASE
		WHEN ServiceLevel.ServiceLevelAttendingMD > 0
		THEN Attending.PersonFirst + ' ' + Attending.PersonLast
		ELSE @ServiceLevelDefault
	END AS 'Attending',
	CASE
		WHEN ServiceLevel.ServiceLevelAttendingMDPhone = -1
		THEN Referral.ReferralAttendingMDPhone
		ELSE @ServiceLevelDefault
	END AS 'ReferralAttendingMDPhone',
	CASE
		WHEN ServiceLevel.ServiceLevelPronouncingMD > 0
		THEN Pronouncing.PersonFirst + ' ' + Pronouncing.PersonLast
		ELSE @ServiceLevelDefault
	END AS 'Pronouncing',
	CASE
		WHEN ServiceLevel.ServiceLevelPronouncingMDPhone = -1
		THEN Referral.ReferralPronouncingMDPhone
		ELSE @ServiceLevelDefault
	END AS 'ReferralPronouncingMDPhone',

	/* Coroner/ME Information */
	CASE
		WHEN Referral.ReferralCoronersCase = -1
		THEN 'Yes'
		ELSE 'No'
	END AS 'CoronersCase',
	Referral.ReferralCoronerName,
	Referral.ReferralCoronerOrganization,
	Referral.ReferralCoronerPhone,
	Referral.ReferralCoronerNote,

	/* Additional Information */
	CallCustomField.CallCustomField1 AS CustomField_1,
	CallCustomField.CallCustomField2 AS CustomField_2,
	CallCustomField.CallCustomField3 AS CustomField_3,
	CallCustomField.CallCustomField4 AS CustomField_4,
	CallCustomField.CallCustomField5 AS CustomField_5,
	CallCustomField.CallCustomField6 AS CustomField_6,
	CallCustomField.CallCustomField7 AS CustomField_7,
	CallCustomField.CallCustomField8 AS CustomField_8,
	CallCustomField.CallCustomField9 AS CustomField_9,
	CallCustomField.CallCustomField10 AS CustomField_10,
	CallCustomField.CallCustomField11 AS CustomField_11,
	CallCustomField.CallCustomField12 AS CustomField_12,
	CallCustomField.CallCustomField13 AS CustomField_13,
	CallCustomField.CallCustomField14 AS CustomField_14,
	CallCustomField.CallCustomField15 AS CustomField_15,
	CallCustomField.CallCustomField16 AS CustomField_16,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS CustomFieldLabel_1,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS CustomFieldLabel_2,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS CustomFieldLabel_3,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS CustomFieldLabel_4,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS CustomFieldLabel_5,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS CustomFieldLabel_6,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS CustomFieldLabel_7,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS CustomFieldLabel_8,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS CustomFieldLabel_9,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS CustomFieldLabel_10,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS CustomFieldLabel_11,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS CustomFieldLabel_12,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS CustomFieldLabel_13,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS CustomFieldLabel_14,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS CustomFieldLabel_15,
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS CustomFieldLabel_16
FROM
	#Calls c
	INNER JOIN Referral ON Referral.CallID = c.CallID
	LEFT JOIN LogEvent ON c.CallID = LogEvent.CallID
	LEFT JOIN NOK ON NOK.NOKID = Referral.ReferralNOKID
	LEFT JOIN Organization coronerOrg ON coronerOrg.OrganizationID = Referral.ReferralCoronerOrgID
	LEFT JOIN [State] nokst ON NOK.NOKStateID = nokst.StateID
	LEFT JOIN [State] rcs ON coronerOrg.StateID = rcs.StateID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = c.StatEmployeeID
	LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID
	LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID
/* Hospital Approach */
	LEFT JOIN SecondaryApproach ON c.CallID = SecondaryApproach.CallID
	LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
	LEFT JOIN Person HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy
/* Informed Approach */
	LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
	LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy

	LEFT JOIN ApproachType HospitalApproachType ON HospitalApproachType.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
	LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD
	LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD
	LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
	LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID
	LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
	LEFT JOIN ReferralType AS CurrentRefType ON CurrentRefType.ReferralTypeID = Referral.CurrentReferralTypeID
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
	LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID
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
	LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID
	LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID
	LEFT JOIN RegistryStatus ON RegistryStatus.CallId = c.CallId
	LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID
	LEFT JOIN CallCriteria CC ON CC.CallID = c.CallID
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID
	LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID
	LEFT JOIN FSCase ON c.CallID = FSCase.CallID
	LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = c.SourceCodeID
	LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID
WHERE
	(
		@LowerAgeLimit IS NULL
	OR	c.DonorAge >= @LowerAgeLimit
	)
AND	(
		@UpperAgeLimit IS NULL
	OR	c.DonorAge <= @UpperAgeLimit
	)
AND	(
		@CoordinatorID IS NULL
	OR	LogEvent.StatEmployeeID = @CoordinatorID
	)
/* Default Sort order */
ORDER BY
	PreliminaryRefType,
	CallDateTime,
	ReferralDonorLastName;
----------------------------------------------------------------  

-- Clean up temp tables
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedDate;
DROP TABLE IF EXISTS #Calls;