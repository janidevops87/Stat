

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelSelect'
		DROP Procedure ServiceLevelSelect
	END
GO

PRINT 'Creating Procedure ServiceLevelSelect'
GO
CREATE Procedure ServiceLevelSelect
(
		@ServiceLevelID int = null output
)
AS
/******************************************************************************
**	File: ServiceLevelSelect.sql
**	Name: ServiceLevelSelect
**	Desc: Selects multiple rows of ServiceLevel Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**	09/13/2011		ccarroll			Added ServiceLevelPNEAllowSaveWithoutContactRequired CCRST151
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ServiceLevel.ServiceLevelID,
		ServiceLevel.ServiceLevelGroupName,
		ServiceLevel.ServiceLevelTriageLevel,
		ServiceLevel.ServiceLevelOTEMROLevel,
		ServiceLevel.ServiceLevelTEMROLevel,
		ServiceLevel.ServiceLevelEMROLevel,
		ServiceLevel.ServiceLevelLastName,
		ServiceLevel.ServiceLevelFirstName,
		ServiceLevel.ServiceLevelRecNum,
		ServiceLevel.ServiceLevelSSN,
		ServiceLevel.ServiceLevelGender,
		ServiceLevel.ServiceLevelAge,
		ServiceLevel.ServiceLevelWeight,
		ServiceLevel.ServiceLevelWeightAgeLimit,
		ServiceLevel.ServiceLevelRace,
		ServiceLevel.ServiceLevelVent,
		ServiceLevel.ServiceLevelPrevVentClass,
		ServiceLevel.ServiceLevelDead,
		ServiceLevel.ServiceLevelDeathDate,
		ServiceLevel.ServiceLevelDeathTime,
		ServiceLevel.ServiceLevelAdmitDate,
		ServiceLevel.ServiceLevelAdmitTime,
		ServiceLevel.ServiceLevelCOD,
		ServiceLevel.ServiceLevelDOB,
		ServiceLevel.ServiceLevelDOA,
		ServiceLevel.ServiceLevelCoroner,
		ServiceLevel.ServiceLevelAttendingMD,
		ServiceLevel.ServiceLevelPronouncingMD,
		ServiceLevel.ServiceLevelApproachMethod,
		ServiceLevel.ServiceLevelApproachBy,
		ServiceLevel.ServiceLevelApproachOTEPrompt,
		ServiceLevel.ServiceLevelApproachTEPrompt,
		ServiceLevel.ServiceLevelApproachEPrompt,
		ServiceLevel.ServiceLevelApproachROPrompt,
		ServiceLevel.ServiceLevelNOK,
		ServiceLevel.ServiceLevelRelation,
		ServiceLevel.ServiceLevelNOKPhone,
		ServiceLevel.ServiceLevelNOKAddress,
		ServiceLevel.ServiceLevelAppropriateOrgan,
		ServiceLevel.ServiceLevelAppropriateBone,
		ServiceLevel.ServiceLevelAppropriateTissue,
		ServiceLevel.ServiceLevelAppropriateSkin,
		ServiceLevel.ServiceLevelAppropriateValves,
		ServiceLevel.ServiceLevelAppropriateEyes,
		ServiceLevel.ServiceLevelAppropriateRsch,
		ServiceLevel.ServiceLevelApproachOrgan,
		ServiceLevel.ServiceLevelApproachBone,
		ServiceLevel.ServiceLevelApproachTissue,
		ServiceLevel.ServiceLevelApproachSkin,
		ServiceLevel.ServiceLevelApproachValves,
		ServiceLevel.ServiceLevelApproachEyes,
		ServiceLevel.ServiceLevelApproachRsch,
		ServiceLevel.ServiceLevelConsentOrgan,
		ServiceLevel.ServiceLevelConsentBone,
		ServiceLevel.ServiceLevelConsentTissue,
		ServiceLevel.ServiceLevelConsentSkin,
		ServiceLevel.ServiceLevelConsentValves,
		ServiceLevel.ServiceLevelConsentEyes,
		ServiceLevel.ServiceLevelConsentRsch,
		ServiceLevel.ServiceLevelRecoveryOrgan,
		ServiceLevel.ServiceLevelRecoveryBone,
		ServiceLevel.ServiceLevelRecoveryTissue,
		ServiceLevel.ServiceLevelRecoverySkin,
		ServiceLevel.ServiceLevelRecoveryValves,
		ServiceLevel.ServiceLevelRecoveryEyes,
		ServiceLevel.ServiceLevelRecoveryRsch,
		ServiceLevel.LastModified,
		ServiceLevel.ServiceLevelExcludePrevVent,
		ServiceLevel.ServiceLevelCheckRegistry,
		ServiceLevel.ServiceLevelDonorIntentFaxYN,
		ServiceLevel.ServiceLevelDonorIntentNurseScript,
		ServiceLevel.ServiceLevelDonorIntentOrganizationId,
		ServiceLevel.ServiceLevelDonorIntentFaxId,
		ServiceLevel.ServiceLevelDonorIntentPersonId,
		ServiceLevel.ServiceLevelDonorIntentRetries,
		ServiceLevel.ServiceLevelDonorIntentDocumentName,
		ServiceLevel.ServiceLevelRegCheckRegistry,
		ServiceLevel.ServiceLevelStatus,
		ServiceLevel.WorkingStatusUpdatedFlag,
		ServiceLevel.WorkingServiceLevelId,
		ServiceLevel.ServiceLevelEyeCareReminder,
		ServiceLevel.ServiceLevelHeartBeat,
		ServiceLevel.ServiceLevelNOKConsent,
		ServiceLevel.ServiceLevelNOKRegistration,
		ServiceLevel.ServiceLevelEmailDisposition,
		ServiceLevel.ServiceLevelDonorBrainDeathDate,
		ServiceLevel.ServiceLevelDonorBrainDeathTime,
		ServiceLevel.ServiceLevelPronouncingMDPhone,
		ServiceLevel.ServiceLevelAttendingMDPhone,
		ServiceLevel.ServiceLevelDOB_ILB,
		ServiceLevel.ServiceLevelDonorNameMI,
		ServiceLevel.ServiceLevelDonorSpecificCOD,
		ServiceLevel.ServiceLevelApproachLevel,
		ServiceLevel.ServiceLevelDisableASPSave,
		ServiceLevel.ServiceLevelAlwaysPopRegistry,
		ServiceLevel.ServiceLevelBillSecondaryManualEnable,
		ServiceLevel.ServiceLevelBillFamilyApproachManualEnable,
		ServiceLevel.ServiceLevelBillMedSocManualEnable,
		ServiceLevel.ServiceLevelVerifyWeight,
		ServiceLevel.ServiceLevelVerifySex,
		ServiceLevel.ServiceLevelBillApproachOnly,
		ServiceLevel.ServiceLevelPNEAllowSaveWithoutContactRequired,
		(Select DRDSNID from ServiceLevelDRDSN where ServiceLevelID = @ServiceLevelID) DRDSNID
	FROM 
		dbo.ServiceLevel 
	
	WHERE 
		ServiceLevel.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevel.ServiceLevelID)
	
	
GO

GRANT EXEC ON ServiceLevelSelect TO PUBLIC
GO
