PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:6/7/2012 4:54:50 PM-- -- --  
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/ReferralActivity/sps_rpt_ReferralActivity_Select.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/StatTrac/Sprocs/WebService/sps_DonorTracUpdateReferral.sql

-- -- -- File Manifest Created On:6/13/2012 1:35:46 PM-- -- --  
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Table/DataLoad/LogEventType.sql
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Transactional/Sprocs/WebReportGroupOrgInsert.sql

PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Table\DataLoad\LogEventType.sql'
GO
/* ****************************************************************************************************
**	Name: LogEventType
**	Desc: Data Load for table LogEventType

****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/08/2011	ccarroll		Added events for Online Review
**  09/06/2011	ccarroll		Added events for Declared CTOD
**	06/13/2012	ccarroll		Add event for Case Hand Off
************************************************************************************************** */
SET NOCOUNT ON

DECLARE @EventTypeName AS NVARCHAR(50)
DECLARE @EventColor AS NVARCHAR(50)
DECLARE @Code AS NVARCHAR(50)

/* Add Online Review Pending */
SET @EventTypeName = 'Online Review Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Online Review Response */
SET @EventTypeName = 'Online Review Response'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Pending */
SET @EventTypeName = 'Declared CTOD Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Confirmed */
SET @EventTypeName = 'Declared CTOD Confirmed'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END


/* Add Case Handoff LogEventTypeId:47 */
SET @EventTypeName = 'Case Hand Off'
SET @EventColor = '0'
SET @Code = ''
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END
GO
PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Transactional\Sprocs\WebReportGroupOrgInsert.sql'
GO
IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgInsert')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgInsert'
		DROP Procedure WebReportGroupOrgInsert
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgInsert'
GO
CREATE Procedure WebReportGroupOrgInsert
(
		@WebReportGroupOrgID int = null output,
		@ReportID int = null,		
		@WebReportGroupID int = null,		
		@OrganizationID int = null,
		@PersonID int = null,		
		@LastModified datetime = null,
		@UpdatedFlag smallint = null
)
AS
/******************************************************************************
**	File: WebReportGroupOrgInsert.sql
**	Name: WebReportGroupOrgInsert
**	Desc: Inserts WebReportGroupOrg Based on Id field 
**	Auth: ccarroll	
**	Date: 05/13/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/13/2011		ccarroll				Initial Sproc Creation
**  06/13/2012		ccarroll				Added check for duplicates
*******************************************************************************/

DECLARE @ExistingWebReportGroupOrgID int 

SET  @ExistingWebReportGroupOrgID = (SELECT TOP 1 WebReportGroupOrgID FROM WebReportGroupOrg WHERE OrganizationID = @OrganizationID AND WebReportGroupID = @WebReportGroupID)
IF (IsNull(@ExistingWebReportGroupOrgID, 0)) = 0

BEGIN
INSERT	WebReportGroupOrg
	(
		ReportID,
		WebReportGroupID,
		OrganizationID,
		PersonID,
		LastModified,
		UpdatedFlag
	)
VALUES
	(
		@ReportID,
		@WebReportGroupID,
		@OrganizationID,
		@PersonID,
		IsNull(@LastModified, GetDate()),
		@UpdatedFlag
	)

SET @WebReportGroupOrgID = SCOPE_IDENTITY()
END
ELSE
BEGIN
SET @WebReportGroupOrgID = @ExistingWebReportGroupOrgID
END



EXEC WebReportGroupOrgSelect @WebReportGroupOrgID

GO

GRANT EXEC ON WebReportGroupOrgInsert TO PUBLIC
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\ReferralActivity\sps_rpt_ReferralActivity_Select.sql'
GO
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


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\StatTrac\Sprocs\WebService\sps_DonorTracUpdateReferral.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracUpdateReferral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_DonorTracUpdateReferral]'
	drop procedure [dbo].[sps_DonorTracUpdateReferral]
END
PRINT 'Creating procedure [sps_DonorTracUpdateReferral]'


GO

--LastUpdated T.T 08/25/05 DonorTrac Criteria Mapping

CREATE PROCEDURE sps_DonorTracUpdateReferral
		@vUserName AS VARCHAR(50),
		@vPassWord AS VARCHAR(50),
		@CallID AS VARCHAR(20)
AS
/******************************************************************************
**		File: sps_DonorTracReferralFS.sql
**		Name: sps_DonorTracReferralFS
**		Desc: Provides the detail information for a FS Referral 
**
**              
**		Return values: returns the inserted record
**		
** 
**		Called by:   Statline.StatInfo
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Thien Ta
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		05/01/05	Thien Ta			initial
**		05/16/05	Scott Plummer		IF there IS nothing in the
										SecondaryCoronerReleasedStipulations, 
										place the value of CoronerNote in this field.
		05/17/05	Scott Plummer		Added translatiON of ReferralDonorOnVentilator 
										to int FOR value of SecondaryPatientVent.
**		8/25/05		Thien Ta			DonorTrac Criteria Mapping								
**		09/16/07	Bret Knoll			8.4 Added TBI fields
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**      07/09       jth					Comment webreport group code and now join to function
**		06/07/2012	ccarroll			Fixed table JOIN for Coroner
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	DECLARE
		@SourcecodeID AS VARCHAR(10),
		@WebReportID AS VARCHAR(10),
		@vOrgID AS INT,
		@vSourceCode AS INT,
		@vReportGroupID AS INT,		 
		@vSourceCodeName AS VARCHAR(10),
		@vSourceCodeIDRef AS INT,
		@ID AS INT,
		@ReferralCategoryMappingNameOrgan AS VARCHAR(50),
		@ReferralCategoryMappingNameBone AS VARCHAR(50),
		@ReferralCategoryMappingNameSoftTissue AS VARCHAR(50),
		@ReferralCategoryMappingNameSkin AS VARCHAR(50),
		@ReferralCategoryMappingNameValves AS VARCHAR(50),
		@ReferralCategoryMappingNameEyes AS VARCHAR(50),
		@ReferralCategoryMappingOther AS VARCHAR(50),
		@DonorValue AS VARCHAR(50),
		@ReferralDonorTracMappingOrgan AS INT,
		@ReferralDonorTracMappingBone AS INT,
		@ReferralDonorTracMappingSoftTissue AS INT,
		@ReferralDonorTracMappingSkin AS INT,
		@ReferralDonorTracMappingValves AS INT,
		@ReferralDonorTracMappingEyes AS INT,
		@ReferralDonorTracMappingOther AS INT,
		@DonorTracValue AS INT,
		@CallerOrgID AS INT,
		@SourceCodeDonorTracMap AS INT,
		@ServiceLevelID	AS INT,
		@ApproachLevel 	AS INT,
		@approachLevelEnabled AS INT,
		@webReportGroupName varchar(100)

/* 6/30/08 

	for any client where a sourcecode should not be pulled have clients services create a 
	"DTStatTrac Imports" web report group.
	
	Add an IF statement to check for the @vUserName and add the DTClient user to the in statement

	IF (@vUserName IN( 'DTMTF'))
	BEGIN
		SET @webReportGroupName = 'DTStatTrac Imports'
	END
	ELSE
	BEGIN
		SET @webReportGroupName = 'All Referrals'
	END*/
	
/* End 6/30/08 Section */
		
--Get OrganizationID
	SELECT 	
		@vOrgID = OrganizationID  
	FROM 	
		WebPerson
    	JOIN 	
    		Person ON Person.PersonID = WebPerson.PersonID
    	WHERE 	
    		WebPersonUserName = @vUserName
    	AND 	
    		WebPersonPassword = @vPassword

	PRINT 
		@vOrgID

--Get SourceCode
--SELECT   @vSourceCode = Sourcecode.SourceCodeID FROM sourcecodeorganization JOIN SourceCode 
--ON SourceCode.SourceCodeID = SourceCodeORganization.SourceCodeID WHERE organizationID = @vOrgID
	SELECT  
		@vSourceCode = SourcecodeID 
	FROM 
		sourceCodeOrganization 
	WHERE 
		OrganizationID = @vOrgID
	PRINT 
		@vSourceCode

-- Get SourceCode Name
	SELECT 
		@vSourceCodeName = SourcecodeName 
	FROM 
		Sourcecode 
	WHERE 
		SourcecodeID = @vSourceCode

	PRINT 
		@vSourceCodeName

-- Get sourcecodeType
	SELECT  
		@vSourceCodeIDRef = SourcecodeID 
	FROM 
		sourcecode 
	WHERE 
		sourcecodeName = @vSourceCodeName 
	AND 
		sourcecodeType = 1 
	AND 
		sourcecode.sourcecodeID <>170

	PRINT 
		@vSourceCodeIDRef

	SELECT 
		@ServiceLevelID = ServiceLevelID 
	FROM 
		callcriteria 
	WHERE 
		callID = @CallID
	
	PRINT 
		'ServiceLevelID'
	PRINT 
		@ServiceLevelID
	--T.T 12/14/2006 turned off functionality for approachlevel servicelevel
	Select @approachLevelEnabled = 0
	PRINT 
		'showdispo'
	PRINT 
		@approachLevelEnabled

--	SELECT 
--		@vReportGroupID = wrg.WebReportGroupID  
--	FROM 
--		WebReportGroup wrg 
--	JOIN 
--		webreportgroupsourcecode wrgsc on wrg.webReportGroupID = wrgsc.webReportGroupID
--	LEFT JOIN 
--		organization o on o.organizationid = wrg.OrgHierarchyParentid
--	WHERE 
--		WebReportGroupName = @webReportGroupName 	
--	AND 
--		o.OrganizationID = @vOrgID

	PRINT 
		@vReportGroupID

	SELECT 
		@CallerOrgID = ReferralCallerOrganizationID 
	FROM 
		referral 
	WHERE 
		callID = @CallID
	SELECT 
		@SourceCodeDonorTracMap = SourceCodeID 
	FROM 
		call 
	WHERE 
		callID = @CallID
--dbo.fn_StatFile_ConvertDateTime(@vOrgID, @CurrentDay)  
--LastUpdated T.T 08/25/05 DonorTrac Criteria Mapping
--fix FOR missing criteria other T.T 10/10/05

SELECT 
	@referraldonorTracmappingorgan = organcriteria.criteriadonortracmap 
FROM 
	CallCriteria 
JOIN 
	criteria AS organcriteria ON organcriteria.criteriaID = callcriteria.OrganCriteriaID 
WHERE  
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingBone = bonecriteria.criteriadonortracmap 
FROM 
	CallCriteria
JOIN 
	criteria AS bonecriteria ON bonecriteria.criteriaID = callcriteria.BoneCriteriaID
WHERE  
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingSoftTissue = tissuecriteria.criteriadonortracmap 
FROM 
	callcriteria
JOIN 	
	criteria AS tissuecriteria ON tissuecriteria.criteriaID = callcriteria.tissueCriteriaID 
WHERE  
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingSkin = SkinCriteria.criteriadonortracmap  
FROM 
	callcriteria
JOIN 
	criteria AS Skincriteria ON Skincriteria.criteriaID = callcriteria.skinCriteriaID 
WHERE  
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingValves = ValvesCriteria.criteriadonortracmap 
FROM 
	callcriteria
JOIN 
	criteria AS Valvescriteria ON Valvescriteria.criteriaID = callcriteria.ValvesCriteriaID 
WHERE  
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingEyes = EyesCriteria.criteriadonortracmap  
FROM 
	callcriteria
JOIN 
	criteria AS Eyescriteria ON Eyescriteria.criteriaID = callcriteria.EyesCriteriaID 
WHERE 
	CallCriteria.CallID =  @callID

SELECT 
	@ReferralDonorTracMappingOther = OtherCriteria.criteriadonortracmap  
FROM 
	CallCriteria 
JOIN 
	criteria AS Othercriteria ON Othercriteria.criteriaID = callcriteria.OtherCriteriaID 
WHERE 
	CallCriteria.CallID =  @callID


DECLARE aRef CURSOR FOR
	SELECT  
		DonorCategoryID
               --DynamicDonorCategoryName 
	FROM 
		criteria
	JOIN   	
		CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
     	JOIN   		
     		SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
	JOIN    
		CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
	JOIN    
		DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	WHERE   
		OrganizationID = @CallerOrgID
     	AND 		
     		SourceCode.SourceCodeID =@SourceCodeDonorTracMap
    	AND	
    		CriteriaStatus = 1

OPEN aRef
 FETCH NEXT FROM aRef INTO @ID
 WHILE @@fetch_Status = 0
BEGIN
	BEGIN
	    	SET @DonorValue = ''
	    	SET @DonorTracValue = 0
		SELECT 
                	@DonorValue=DynamicDonorCategoryName , 

                	@DonorTracValue = CriteriaDonorTracMap
		FROM 
			criteria
		JOIN   	
			CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
     		JOIN   	
     			SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
		JOIN    	
			CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
		JOIN    
			DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
		WHERE   
			OrganizationID = @CallerOrgID
     		AND 		
     			SourceCode.SourceCodeID =@SourceCodeDonorTracMap
    		AND	
    			CriteriaStatus = 1
		AND     
			DonorCategoryID = @ID
		
		IF @ID = 1 
			BEGIN	
				SET @ReferralCategoryMappingNameOrgan = @DonorValue
				PRINT 1
				PRINT @ReferralCategoryMappingNameOrgan
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingOrgan = @DonorTracValue
				PRINT @ReferralDonorTracMappingOrgan
			END	
		IF @ID = 2 
			BEGIN	
				SET @ReferralCategoryMappingNameBone = @DonorValue
				PRINT 2
				PRINT @ReferralCategoryMappingNameBone
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingBone = @DonorTracValue
				PRINT @ReferralDonorTracMappingBone
			END	
		IF @ID = 3 
			BEGIN	
				SET @ReferralCategoryMappingNameSoftTissue = @DonorValue
				PRINT 3
				PRINT @ReferralCategoryMappingNameSoftTissue

				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingSoftTissue = @DonorTracValue
				PRINT @ReferralDonorTracMappingSoftTissue
			END	
		IF @ID = 4 
			BEGIN	
				SET @ReferralCategoryMappingNameSkin = @DonorValue
				PRINT 4
				PRINT @ReferralCategoryMappingNameSkin
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingSkin = @DonorTracValue
				PRINT @ReferralDonorTracMappingSkin
			END	
		IF @ID = 5 
			BEGIN	
				SET @ReferralCategoryMappingNameValves = @DonorValue
				PRINT 5
				PRINT @ReferralCategoryMappingNameValves
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingValves = @DonorTracValue
				PRINT @ReferralDonorTracMappingValves
			END	
		IF @ID = 6 
			BEGIN	
				SET @ReferralCategoryMappingNameEyes = @DonorValue
				PRINT 6
				PRINT @ReferralCategoryMappingNameEyes
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingEyes = @DonorTracValue
				PRINT @ReferralDonorTracMappingEyes
			END	
		IF @ID = 7 
			BEGIN	
				SET @ReferralCategoryMappingOther = @DonorValue
				PRINT 7
				PRINT @ReferralCategoryMappingOther
				PRINT 'DonorTracMap'
				--SET @ReferralDonorTracMappingOther = @DonorTracValue
				PRINT @ReferralDonorTracMappingOther
			END	
END

FETCH NEXT FROM aRef INTO @ID
END


CLOSE aref 
DEALLOCATE aref
SELECT DISTINCT 
	CONVERT(VARCHAR, dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified), 121) AS LastModified, 
 	Call.CallID, 
 	CallNumber, 
  	CONVERT(VARCHAR, dbo.fn_StatFile_ConvertDateTime(@vOrgID,  CallDateTime), 121) AS CallDateTime, 
	StatEmployeeFirstName + ' ' + StatEmployeeLastName AS 'StatEmployee', 
	Referral.ReferralTypeID, 
	ReferralTypeName, 
	1 AS 'ReferralStatusID', 
	'Complete' AS 'ReferralStatus', 
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', 
	ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', 
	PersonTypeName, 
	Organization.OrganizationUserCode, 
	Organization.OrganizationID, 
	Organization.OrganizationName, 
	Organization.OrganizationTimeZone AS TimeZone, 
	CASE WHEN SubLocationName is NULL Then '' Else SubLocationName END AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, 
	ReferralDonorLastName, 
	ReferralDonorRecNumber, 
	ReferralDonorAge, 
	ReferralDonorAgeUnit, 
	ReferralDonorRaceID, 
	RaceName, 
	ReferralDonorGender, 
	ReferralDonorWeight, 
	ReferralDonorCauseOfDeathID, 
	CauseOfDeathName, 
	REPLACE(REPLACE(ReferralNotesCASE, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCASE', 
	0 AS 'Unused', 
	CONVERT(VARCHAR , ReferralDonorAdmitDate, 121) AS ReferralDonorAdmitDate, 
	CASE WHEN ReferralDonorAdmitTime is NULL Then '.0001' Else ReferralDonorAdmitTime END AS 'ReferralDonorAdmitTime' , 
	ReferralDonorOnVentilator, 
	0, 
	CONVERT(VARCHAR, ReferralDonorDeathDate, 121) AS ReferralDonorDeathDate , 
	CASE WHEN ReferralDonorDeathTime is NULL Then '.0001' else ReferralDonorDeathTime END AS 'ReferralDonorDeathTime', 
	ReferralApproachTypeID, 
	ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', 

	CASE WHEN ReferralNOKID is NOT NULL THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName, 50) ELSE ReferralApproachNOK END AS ReferralApproachNOK, 
	ReferralApproachRelation, 

	ReferralOrganAppropriateID, 
	ReferralBoneAppropriateID, 
	ReferralTissueAppropriateID, 
	ReferralSkinAppropriateID, 
	ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	
	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralOrganApproachID END AS ReferralOrganApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralBoneApproachID END AS ReferralBoneApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralTissueApproachID END AS ReferralTissueApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralSkinApproachID END AS ReferralSkinApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralValvesApproachID END AS ReferralValvesApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralEyesTransApproachID END AS ReferralEyesTransApproachID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralOrganConsentID END AS ReferralOrganConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralBoneConsentID END AS ReferralBoneConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralTissueConsentID END AS ReferralTissueConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralSkinConsentID END AS ReferralSkinConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralValvesConsentID END AS ReferralValvesConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralEyesTransConsentID END AS ReferralEyesTransConsentID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralOrganConversionID END AS ReferralOrganConversionID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralBoneConversionID END AS ReferralBoneConversionID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralTissueConversionID END AS ReferralTissueConversionID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralSkinConversionID END AS ReferralSkinConversionID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralValvesConversionID END AS ReferralValvesConversionID, 

	CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralEyesTransConversionID END AS ReferralEyesTransConversionID, 

	ReferralOrganDispositionID, 
	ReferralAllTissueDispositionID, 
	ReferralEyesDispositionID, 
	ReferralBoneDispositionID, 

	ReferralTissueDispositionID, 
	ReferralSkinDispositionID, 
	ReferralValvesDispositionID, 
	ReferralGeneralConsent, 
	ReferralExtubated, 
	ReferralDOB, 

	ReferralDonorSSN, 
	CASE ReferralCoronersCASE WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCASE', 
	CTY.CountyName, 

	ReferralEyesRschAppropriateID AS  AppropriateOtherID, 
	ReferralEyesRschApproachID, 
	ReferralEyesRschConsentID, 
	ReferralEyesRschConversionID, 
	ReferralRschDispositionID, 

	CallCustomField.CallCustomField1 AS customField_1, 
	CallCustomField.CallCustomField2 AS customField_2, 
	CallCustomField.CallCustomField3 
	AS customField_3, 
	CallCustomField.CallCustomField4 AS customField_4, 
	CallCustomField.CallCustomField5 AS customField_5, 

	CallCustomField.CallCustomField6 AS customField_6, 
	REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') AS customField_7, 
	CallCustomField.CallCustomField8 AS customField_8, 
	CallCustomField.CallCustomField9 AS customField_9, 
	CallCustomField.CallCustomField10 AS customField_10, 
	CallCustomField.CallCustomField11 AS customField_11, 
	CallCustomField.CallCustomField12 AS customField_12, 
	CallCustomField.CallCustomField13 AS customField_13, 
	CallCustomField.CallCustomField14 AS customField_14, 
	CallCustomField.CallCustomField15 AS customField_15, 
	CallCustomField.CallCustomField16 AS customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16, 
	CASE WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END AS CoronerState, 
	Referral.ReferralCoronerOrganization AS CoronerOrganization, 
	Referral.ReferralCoronerOrgID AS CoronerOrganizationID, 
	CASE WHEN Referral.ReferralCoronerName = 'NOT Available' Then '' Else Referral.ReferralCoronerName END AS  'CoronerName' , 
	Referral.ReferralCoronerPhone AS CoronerPhone, 
	Referral.ReferralCoronerNote AS CoronerNote, 
	CASE WHEN ReferralNOKID is NOT NULL then nok.nokphone else Referral.ReferralNOKPhone END AS NOKPhone, 
	CASE WHEN ReferralNOKID is NOT NULL THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS NOKAddress, 
	RegistryStatus.RegistryStatus, 
	Referral.ReferralDonorHeartBeat AS PatientHasHeartbeat, 
	Referral.ReferralDOA AS DOA, 

	AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician, 
	PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS
	PronouncingPhysician , 
	@ReferralCategoryMappingNameOrgan AS ReferralCategoryMappingNameOrgan, 
	@ReferralDonorTracMappingOrgan AS ReferralDonorTracMappingOrgan, 

	@ReferralCategoryMappingNameBone AS ReferralCategoryMappingNameBone, 
	@ReferralDonorTracMappingBone AS ReferralDonorTracMappingBone, 

	@ReferralCategoryMappingNameSoftTissue AS ReferralCategoryMappingNameSoftTissue, 
	@ReferralDonorTracMappingSoftTissue AS ReferralDonorTracMappingSoftTissue, 

	@ReferralCategoryMappingNameSkin AS ReferralCategoryMappingNameSkin, 
	@ReferralDonorTracMappingSkin AS ReferralDonorTracMappingSkin, 

	@ReferralCategoryMappingNameValves AS ReferralCategoryMappingNameValves, 
	@ReferralDonorTracMappingValves AS ReferralDonorTracMappingValves, 

	@ReferralCategoryMappingNameEyes AS ReferralCategoryMappingNameEyes, 
	@ReferralDonorTracMappingEyes AS ReferralDonorTracMappingEyes, 

	@ReferralCategoryMappingOther AS ReferralCategoryMappingOther, 
	@ReferralDonorTracMappingOther AS ReferralDonorTracMappingOther, 

	CASE Referral.ReferralDOB_ILB WHEN -1 Then  1 ELSE 0 END AS ReferralDonor_ILB, 

	ReferralDonorSpecificCOD, 
	CONVERT(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorBrainDeathDate), 1) AS ReferralDonorBrainDeathDate, 

	ReferralDonorBrainDeathTime, 
	ReferralAttendingMDPhone, 
	ReferralPronouncingMDPhone, 
	CurrentReferralTypeID, 
	Referral.ReferralNotesCASE AS MedicalHistory, 

	NOK.NOKFirstName, 
	NOK.NOKLastName, 
	NOK.NOKCity, 
	ST.StateAbbrv AS NOKState, 
	NOK.NOKZip, 
	Referral.ReferralDonorNameMI , 
	'' AS CoronorsCASE, 

	CASE WHEN ReferralNOKID is NOT NULL THEN LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '')  , 255)	ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), 	CHAR(13), '') END AS NOKAddress,
	STBI.SecondaryTBINumber,
	STBI.SecondaryTBIAssignmentNotNeeded,
	STBI.SecondaryTBIComment
FROM 
	Referral 
JOIN Call ON Call.CallID = Referral.CallID 
LEFT JOIN 
	ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
LEFT JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN 
	Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
LEFT JOIN 
	PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID 
LEFT JOIN 
	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
LEFT JOIN 
	Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
JOIN 
	(SELECT SourceCodeID, 
			OrgID
		FROM dbo.fn_GetStatInfoReportWebGroups 
		( 
		@vUserName)) fn ON fn.sourcecodeid =call.sourcecodeid and fn.orgid = ReferralCallerOrganizationID	
--JOIN 
--	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
LEFT JOIN 
	SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
LEFT JOIN 
	SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID 
LEFT JOIN 
	Race ON ReferralDonorRaceID  = Race.RaceID
LEFT JOIN 
	CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID 
LEFT JOIN 
	ApproachType ON ApproachTypeID=ReferralApproachTypeID 
LEFT JOIN 
	Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID 
LEFT JOIN
	Organization ME ON ME.OrganizationID = Referral.ReferralCoronerOrgID 
LEFT JOIN 
	COUNTY CTY ON CTY.CountyID = ME.CountyID 
LEFT JOIN 
	CallCustomField on CallCustomField.CallID = Referral.CallID 
LEFT JOIN 
	ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
LEFT JOIN 
	CallCriteria ON CallCriteria.CallID = Call.CallID 
LEFT JOIN 
	ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID
LEFT JOIN 
	ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID 
	AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN 
	ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
LEFT JOIN 
	RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
LEFT JOIN 
	Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
LEFT JOIN 
	Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD 
LEFT JOIN
	Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID 
LEFT JOIN 
	State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
LEFT JOIN 
	NOK AS NOK ON NOK.NOKID = Referral.ReferralNOKID
LEFT JOIN 
	State AS ST on NOK.NOKStateID = ST.StateID
LEFT JOIN
	SecondaryTBI STBI ON STBI.CallID = Call.CallID
WHERE 
	Call.CallID = @CallID  
--AND 
--	WebReportGroupOrg.WebReportGroupID = @vReportGroupID 
ORDER BY 
	Call.CallID 

----- set flag so Referral is not sent to DT
Update 
	Referral 
SET 
	unusedField1 = 1
WHERE 
	Referral.CallID = @callID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


GO

