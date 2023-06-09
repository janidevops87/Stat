IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_DonorTracReferralFS')
	BEGIN
		PRINT 'Dropping Procedure sps_DonorTracReferralFS';
		DROP Procedure sps_DonorTracReferralFS;
	END
GO
PRINT 'Creating Procedure sps_DonorTracReferralFS';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_DonorTracReferralFS] 

		@vUserName AS VARCHAR(50),
		@vPASsWord AS VARCHAR(50),
		@CallID AS INT
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
**      12/03       bret				Comment webreport group code and now join to function
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

BEGIN

	DECLARE
		@vOrgID AS INT,
		@ReferralCategoryMappingNameOrgan AS VARCHAR(50),
		@ReferralCategoryMappingNameBone AS VARCHAR(50),
		@ReferralCategoryMappingNameSoftTissue AS VARCHAR(50),
		@ReferralCategoryMappingNameSkin AS VARCHAR(50),
		@ReferralCategoryMappingNameValves AS VARCHAR(50),
		@ReferralCategoryMappingNameEyes AS VARCHAR(50),
		@ReferralCategoryMappingOther AS VARCHAR(50),
		@ReferralDonorTracMappingOrgan AS INT,
		@ReferralDonorTracMappingBone AS INT,
		@ReferralDonorTracMappingSoftTissue AS INT,
		@ReferralDonorTracMappingSkin AS INT,
		@ReferralDonorTracMappingValves AS INT,
		@ReferralDonorTracMappingEyes AS INT,
		@ReferralDonorTracMappingOther AS INT,
		@CallerOrgID AS INT,
		@SourceCodeDonorTracMap AS INT,
		@ApproachLevel 	AS INT,
		@approachLevelEnabled AS INT = 0;

	-- Get OrganizationID
	SELECT 
		@vOrgID = OrganizationID  
	FROM 
		WebPerson
		JOIN Person ON Person.PersonID = WebPerson.PersonID
	WHERE 
		WebPersonUserName = @vUserName
		AND WebPersonPASsword = @vPASsword;

	-- Get callerorgid & sourcecodeDonorTracMap
	SELECT 
		@CallerOrgID = Referral.ReferralCallerOrganizationID,
		@SourceCodeDonorTracMap = Call.SourceCodeID
	FROM 
		Referral 
		JOIN Call ON Call.CallID = Referral.CallID
	WHERE 
		Referral.CallID = @CallID;

	-- Begin Criteria TracMapping Logic
	SELECT 
		@ReferralDonorTracMappingOrgan = Organcriteria.criteriaDonortracmap, 
		@ReferralDonorTracMappingBone = Bonecriteria.criteriaDonortracmap,
		@ReferralDonorTracMappingSoftTissue = tissuecriteria.criteriaDonortracmap,
		@ReferralDonorTracMappingSkin = SkinCriteria.criteriaDonortracmap,
		@ReferralDonorTracMappingValves = ValvesCriteria.criteriaDonortracmap,
		@ReferralDonorTracMappingEyes = EyesCriteria.criteriaDonortracmap,
		@ReferralDonorTracMappingOther = OtherCriteria.criteriaDonortracmap  
	FROM 
		CallCriteria 
		LEFT JOIN criteria AS Organcriteria ON Organcriteria.criteriaID = callcriteria.OrganCriteriaID 
		LEFT JOIN criteria AS Bonecriteria ON Bonecriteria.criteriaID = callcriteria.BoneCriteriaID
		LEFT JOIN criteria AS tissuecriteria ON tissuecriteria.criteriaID = callcriteria.tissueCriteriaID 
		LEFT JOIN criteria AS Skincriteria ON Skincriteria.criteriaID = callcriteria.skinCriteriaID 
		LEFT JOIN criteria AS Valvescriteria ON Valvescriteria.criteriaID = callcriteria.ValvesCriteriaID 
		LEFT JOIN criteria AS Eyescriteria ON Eyescriteria.criteriaID = callcriteria.EyesCriteriaID 
		LEFT JOIN criteria AS Othercriteria ON Othercriteria.criteriaID = callcriteria.OtherCriteriaID 
	WHERE  
		CallCriteria.CallID =  @CallID;

	SELECT
		@ReferralCategoryMappingNameOrgan = OrganMapping,
		@ReferralCategoryMappingNameBone = BoneMapping,
		@ReferralCategoryMappingNameSoftTissue = TissueMapping,
		@ReferralCategoryMappingNameSkin = SkinMapping,
		@ReferralCategoryMappingNameValves = ValvesMapping,
		@ReferralCategoryMappingNameEyes = EyesMapping,
		@ReferralCategoryMappingOther = OtherMapping
	FROM
	(
		SELECT
			MAX(CASE DonorCategoryId WHEN 1 THEN DynamicDonorCategoryName END) AS OrganMapping,
			MAX(CASE DonorCategoryId WHEN 2 THEN DynamicDonorCategoryName END) AS BoneMapping,
			MAX(CASE DonorCategoryId WHEN 3 THEN DynamicDonorCategoryName END) AS TissueMapping,
			MAX(CASE DonorCategoryId WHEN 4 THEN DynamicDonorCategoryName END) AS SkinMapping,
			MAX(CASE DonorCategoryId WHEN 5 THEN DynamicDonorCategoryName END) AS ValvesMapping,
			MAX(CASE DonorCategoryId WHEN 6 THEN DynamicDonorCategoryName END) AS EyesMapping,
			MAX(CASE DonorCategoryId WHEN 7 THEN DynamicDonorCategoryName END) AS OtherMapping
		FROM (	SELECT 
					DonorCategoryID,
					DynamicDonorCategoryName
				FROM criteria
				JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
				JOIN SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
				JOIN CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
				JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
				WHERE 
					OrganizationID = @CallerOrgID
					AND SourceCode.SourceCodeID =@SourceCodeDonorTracMap
					AND	CriteriaStatus = 1
			) as cr1
	) as cr2;

	-- Start the big select
	SELECT DISTINCT 
		Referral.ReferralID, 
		Call.CallID, 
		CallNumber, 
		CONVERT(varchar,dbo.fn_StatFile_ConvertDateTime(@vOrgID,  CallDateTime),121) AS CallDateTime, 
		CONVERT(char(8), dbo.fn_StatFile_ConvertDateTime(@vOrgID ,CallDateTime), 1) AS CallDate, 
		CONVERT(char(5), dbo.fn_StatFile_ConvertDateTime(@vOrgID , CallDateTime), 8) AS CallTime, 
		StatPerson.PersonFirst AS StatPersonFirstName, 
		StatPerson.PersonLast AS StatPersonLastName, 
		ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS 'GenderAgeANDUnit', 
		Call.SourceCodeID, 
		SourceCodeName, 
		Referral.ReferralTypeID, 
		ReferralTypeName, 
		ReferralDonorLastName, 
		ReferralDonorFirstName,  
		OrganizatiON.OrganizationID, 
		OrganizatiON.OrganizationName, 
		CallerPerson.PersonFirst AS 'CallPersonFirst', 
		CallerPerson.PersonLast AS 'CallerPersonLast', 
		CallPersonType.PersonTypeName AS 'CallerPersonTitle', 
		SubLocationName, 
		ReferralCallerSubLocationLevel, 
		'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'Phone', 
		ReferralCallerExtensiON, 
		CASE WHEN ReferralDonorSSN IS NOT NULL THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber,
		ReferralDonorAge, 
		ReferralDonorAgeUnit, 
		ReferralDonorGender, 
		ReferralDonorWeight, 
		ReferralDonorOnVentilator, 
		CONVERT(char(8),ReferralDonorAdmitDate,1) AS 'ReferralDonorAdmitDate', 
		ReferralDonorAdmitTime, 
		CONVERT(char(8),ReferralDonorDeathDate,1) AS 'ReferralDonorDeathDate', 
		ReferralDonorDeathTime,
		 REPLACE(REPLACE(ReferralNotesCASE, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralNotesCASE, 
		 RaceName, 
		CauseOfDeathName, 
		approachType.ApproachTypeName, 
		ApproachPerson.PersonFirst AS ApproachPersonFirst, 
		ApproachPerson.PersonLast AS ApproachPersonLast, 
		CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName,50) ELSE ReferralApproachNOK END AS ReferralApproachNOK, 
		CASE WHEN ReferralNOKID IS NOT NULL THEN nok.nokApproachRelatiON else referralapproachrelatiON END AS ReferralApproachRelatiON,
		ReferralNOKPhone, 
		REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS NOKAddress, 
		ReferralCoronerName, 
		ReferralCoronerOrganizatiON, 
		ReferralCoronerPhone, 
		REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralCoronerNote,
		Attending.PersonFirst AS AttendingFirst, 
		Attending.PersonLast AS AttendingLast, 
		Pronouncing.PersonFirst AS PronouncingFirst, 
		Pronouncing.PersonLast AS PronouncingLast, 
		AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		ApproaOrgan.ApproachReportName AS ApproachOrgan, 
		ConsentOrgan.ConsentReportName AS ConsentOrgan, 
		RecoveryOrgan.ConversionReportName AS RecoveryOrgan, 
		AppropBone.AppropriateReportName AS AppropriateBone, 
		ApproaBone.ApproachReportName AS ApproachBone, 
		ConsentBone.ConsentReportName AS ConsentBone, 
		RecoveryBone.ConversionReportName AS RecoveryBone, 
		AppropTissue.AppropriateReportName AS AppropriateTissue, 
		ApproaTissue.ApproachReportName AS ApproachTissue, 
		ConsentTissue.ConsentReportName AS ConsentTissue, 
		RecoveryTissue.ConversionReportName AS RecoveryTissue, 
		AppropSkin.AppropriateReportName AS AppropriateSkin, 
		ApproaSkin.ApproachReportName AS ApproachSkin, 
		ConsentSkin.ConsentReportName AS ConsentSkin, 
		RecoverySkin.ConversionReportName AS RecoverySkin, 
		AppropValve.AppropriateReportName AS AppropriateValves, 
		ApproaValve.ApproachReportName AS ApproachValves, 
		ConsentValve.ConsentReportName AS ConsentValve, 
		RecoveryValve.ConversionReportName AS RecoveryValve, 
		AppropEyes.AppropriateReportName AS AppropriateEyes, 
		ApproaEyes.ApproachReportName AS ApproachEyes, 
		ConsentEyes.ConsentReportName AS ConsentEyes, 
		RecoveryEyes.ConversionReportName AS RecoveryEyes, 
		'' AS 'blankfield', 
		'' AS 'blankfield', 
		'' AS 'blankfield', 
		'' AS 'blankfield', 
		ReferralCallerOrganizationID AS OrganizationID, 
		ReferralGeneralConsent, 
		ReferralApproachTime, 
		ReferralConsentTime, 
		ReferralSecondaryHistory, 
		ReferralExtubated, 
		AppropRsch.AppropriateReportName AS AppropriateOther, 
		ApproaRsch.ApproachReportName AS ApproachOther, 
		ConsentRsch.ConsentReportName AS ConsentOther, 
		RecoveryRsch.ConversionReportName AS RecoveryOther, 
		Referral.ReferralApproachTypeId, 
		CallCustomField.CallCustomField1 AS customField_1, 
		CallCustomField.CallCustomField2 AS customField_2, 
		CallCustomField.CallCustomField3 AS customField_3, 
		CallCustomField.CallCustomField4 AS customField_4, 
		CallCustomField.CallCustomField5 AS customField_5, 
		CallCustomField.CallCustomField6 AS customField_6, 
		CallCustomField.CallCustomField7 AS customField_7, 
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
		CONVERT (varchar(14), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastmodIFied), 1) + ' ' + CONVERT (varchar(14), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastmodIFied), 108) AS 'ftpLastmodIFied', 
		OrganizatiON.OrganizatiONUserCode, 
		ReferralDonorRaceID, 
		ReferralDonorCauseOfDeathID, 
		--- appropriate
		ReferralOrganAppropriateID, 
		ReferralBoneAppropriateID, 
		ReferralTissueAppropriateID, 
		ReferralSkinAppropriateID, 
		ReferralValvesAppropriateID, 
		ReferralEyesTransAppropriateID, 

		--- approach
		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralOrganApproachID END AS ReferralOrganApproachID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralBoneApproachID END AS ReferralBoneApproachID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralTissueApproachID END AS ReferralTissueApproachID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralSkinApproachID END AS ReferralSkinApproachID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralValvesApproachID END AS ReferralValvesApproachID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralEyesTransApproachID END AS ReferralEyesTransApproachID, 

		--- consent
		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralOrganConsentID END AS ReferralOrganConsentID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralBoneConsentID END AS ReferralBoneConsentID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralTissueConsentID END AS ReferralTissueConsentID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralSkinConsentID END AS ReferralSkinConsentID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralValvesConsentID END AS ReferralValvesConsentID, 

		CASE WHEN @approachLevelEnabled = -1 then  -1  else ReferralEyesTransConsentID END AS ReferralEyesTransConsentID, 

		--- conversion / recover
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
		ReferralEyesRschAppropriateID, 
		ReferralEyesRschApproachID, 
		ReferralEyesRschConsentID, 
		ReferralEyesRschConversionID, 
		ReferralRschDispositionID, 
		CAST(DATEPART(m, ReferralDOB) AS Varchar) + '/' + CAST(DATEPART(d, ReferralDOB) AS Varchar) + '/' + CAST(DATEPART(yyyy, ReferralDOB) AS Varchar), 
		ReferralDonorSSN, 
		CASE ReferralCoronersCase WHEN -1 Then 0 WHEN 0 Then -1 END AS 'CoronersCase', 
		CTY.CountyName AS 'CoronerCounty', 
		REPLACE(REPLACE(ReferralNotesCASE, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCASE', 
		ReferralDonorRecNumber, 
		CONVERT (varchar(14), DATEADD(hour, 1, CallDateTime), 1) + ' ' + CONVERT (varchar(14), DATEADD(hour, 1, CallDateTime), 108) AS 'FTPCallDateTime', 
		CASE WHEN Len(Referral.ReferralCoronerOrganizatiON) > 0 THEN CoronersT.StateAbbrv ELSE NULL END AS Coronerstate, 
		Referral.ReferralCoronerOrganizatiON AS CoronerOrganization,
	 
		Referral.ReferralCoronerName AS CoronerName,
		Referral.ReferralCoronerPhone AS CoronerPhone, 
		REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, 
		CASE WHEN ReferralNOKID IS NOT NULL then nok.nokPhone else Referral.ReferralNOKPhone END  AS NOKPhone, 
		CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') , 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS NOKAddress, 
		RegistryStatus.RegistryStatus AS RegistryStatusID, 
		CASE RegistryStatus.RegistryStatus WHEN 1 THEN 'Found ON the State Registry' WHEN 2 THEN 'Found ON the Web Registry' WHEN 3 THEN 'Manually Found' WHEN 4 THEN 'NOT ON the Registry' WHEN 5 THEN 'NOT Checked' END AS RegistryStatus, 
		CASE Referral.ReferralDonorHeartBeat WHEN 1 Then 'Y' ELSE 'N' END AS PatientHASHeartbeat, 
		CASE Referral.ReferralDOA WHEN -1 Then 'Y' ELSE 'N' END AS DOA, 
		AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician, 
		PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician, 
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
		'' AS CorONorsCASE, 
		CASE WHEN ReferralNOKID IS NOT NULL THEN LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS NOKAddress, 
		FSCaseId, 
		FSCaseCreateUserId, 
		FSCaseCreateDateTime, 
		FSCaseOPENUserId, 
		FSCaseOPENDateTime, 
		FSCaseSysEventsUserId, 
		FSCaseSysEventsDateTime, 
		FSCaseSecCompUserId, 
		FSCaseSecCompDateTime, 
		FSCaseApproachUserId, 
		FSCaseApproachDateTime, 
		FSCaseFinalUserId, 
		FSCaseFinalDateTime, 
		FSCaseUpdate, 
		FSCaseUserId, 
		FSCaseBillSecondaryUserID, 
		FSCaseBillDateTime, 
		FSCaseBillApproachUserID, 
		FSCaseBillApproachDateTime, 
		FSCaseBillMedSocUserID, 
		FSCaseBillMedSocDateTime, 
		SecondaryManualBillPersonId, 
		SecondaryUpdatedFlag, 
		FSCaseTotalTime, 
		FSCaseSeconds, 
		FSCaseBillFamUnavailUserId, 
		FSCaseBillFamUnavailDateTime, 
		FSCaseBillCryoFORmUserId, 
		FSCaseBillCryoFORmDateTime, 
		FSCaseBillApproachCount, 

		FSCaseBillMedSocCount, 
		FSCaseBillCryoFORmCount, 
		SecondaryWhoAreWe, 
		SecondaryNOKaware, 
		SecondaryFamilyConsent, 
		SecondaryFamilyInterested, 

		SecondaryNOKatHospital, 
		SecondaryEstTimeSinceLEFT, 
		SecondaryTimeLEFTInMT, 
		SecondaryNOKNextDest, 
		SecondaryNOKETA, 
		SecondaryPatientMiddleName, 
		SecondaryPatientHeightFeet, 
		SecondaryPatientHeightInches, 
		SecondaryPatientBMICalc, 
		SecondaryPatientTOD1, 
		SecondaryPatientTOD2, 
		SecondaryPatientDeathType1, 

		SecondaryPatientDeathType2, 
		SecondaryTriageHX, 
		REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath, 
		REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory, 
		SecondaryAdmissionDiagnosis, 
		SecondaryCOD, 
		SecondaryCODSignatory, 
		SecondaryCODTime, 
		SecondaryCODSignedBy, 
		/* Added translatiON of ReferralDonorOnVentilator to int FOR value of SecondaryPatientVent.  5/17/05 - SAP */
		CASE
			WHEN ReferralDonorOnVentilator = 'Never' THEN 0
			WHEN ReferralDonorOnVentilator = 'Previously' THEN 1
			WHEN ReferralDonorOnVentilator = 'Currently' THEN 2
			ELSE NULL
		END AS SecondaryPatientVent, 
		SecondaryIntubatiONDate, 
		SecondaryIntubatiONTime, 
		CONVERT(varchar, SecondaryBrainDeathDate, 121) AS SecondaryBrainDeathDate, 
		SecondaryBrainDeathTime, CONVERT(varchar, SecondaryDNRDate, 121) AS SecondaryDNRDate, 
		SecondaryERORDeath, 
		SecondaryEMSArrivalToPatientDate, 
		SecondaryEMSArrivalToPatientTime, 
		SecondaryEMSArrivalToHospitalDate, 
		SecondaryEMSArrivalToHospitalTime, 
		SecondaryPatientTerminal, 
		SecondaryDeathWitnessed, 
		SecondaryDeathWitnessedBy, 
		CONVERT(varchar, SecondaryLSADate, 121) AS SecondaryLSADate, 
		SecondaryLSATime, 
		SecondaryLSABy, 
		SecondaryACLSProvided, 
		SecondaryACLSProvidedTime, 
		SecondaryGestatiONalAge, 
		SecondaryParentName1, 
		SecondaryParentName2, 
		SecondaryBirthCBO, 
		SecondaryActiveInfectiON, 
		SecondaryActiveInfectiONType, 
		SecondaryFluidsGiven, 
		SecondaryBloodLoss, 
		SecondarySignOfInfectiON, 
		SecondaryMedication, 
		SecondaryAntibiotic, 
		SecondaryPCPName, 
		SecondaryPCPPhone, 
		SecondaryMDAttending, 
		SecondaryMDAttendingPhone, 
		REPLACE(REPLACE(SecondaryPhysicalAppearance, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance, 
		SecondaryInternalBloodLossCC, 
		SecondaryExternalBloodLossCC, 
		SecondaryBloodProducts, 
		SecondaryColloidsInfused, 
		SecondaryCrystalloids, 
		SecondaryPreTransfusionSampleRequired, 
		SecondaryPreTransfusionSampleAvailable, 
		CONVERT(varchar, SecondaryPreTransfusionSampleDrawnDate, 121) AS SecondaryPreTransfusionSampleDrawnDate, 
		SecondaryPreTransfusionSampleDrawnTime, 
		SecondaryPreTransfusionSampleQuantity, 
		SecondaryPreTransfusionSampleHeldAt, 
		CONVERT(varchar, SecondaryPreTransfusionSampleHeldDate, 121) AS SecondaryPreTransfusionSampleHeldDate, 
		SecondaryPreTransfusionSampleHeldTime, 
		SecondaryPreTransfusionSampleHeldTechnician, 
		SecondaryPostMordemSampleTestSuitable, 
		SecondaryPostMordemSampleLocation, 
		SecondaryPostMordemSampleContact, 
		CONVERT(varchar, SecondaryPostMordemSampleCollectionDate, 121) AS SecondaryPostMordemSampleCollectionDate, 
		SecondaryPostMordemSampleCollectionTime, 
		REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics, 
		SecondaryNOKAltPhone, 
		SecondaryNOKLegal, 
		ReferralApproachNOK AS SecondaryNOKAltContact, 
		SecondaryNOKAltContactPhone, 
		SecondaryNOKPostMortemAuthorization, 
		SecondaryNOKAltContact AS SecondaryNOKAltContact2, 

		SecondaryNOKPostMortemAuthorizationReminder, 
		SecondaryCoronerCaseNumber, 
		SecondaryCoronerCounty, 
		SecondaryCoronerReleased, 

		-- place the value of CoronerNote in this field.  5/16/05 - SAP
		CASE  
			WHEN ISNULL(SecondaryCoronerReleasedStipulations, '') <> '' THEN REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') 
			ELSE REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '')
		END AS SecondaryCoronerReleasedStipulations , 
		SecondaryAutopsy, 
		CONVERT(varchar, SecondaryAutopsyDate, 121) AS SecondaryAutopsyDate, 
		SecondaryAutopsyTime, 
		SecondaryAutopsyLocation, 
		SecondaryAutopsyBloodRequested, 
		SecondaryAutopsyCopyRequested, 
		SecondaryFuneralHomeSELECTed, 
		SecondaryFuneralHomeName, 
		SecondaryFuneralHomePhone, 
		SecondaryFuneralHomeAddress, 
		SecondaryFuneralHomeContact, 
		SecondaryFuneralHomeNotIFied, 
		SecondaryFuneralHomeMorgueCooled, 
		SecondaryHoldOnBody, 
		SecondaryHoldOnBodyTag, 
		CONVERT(varchar, SecondaryBodyRefrigerationDate, 121) AS SecondaryBodyRefrigerationDate, 
		SecondaryBodyRefrigerationTime, 
		SecondaryBodyLocation, 
		SecondaryBodyMedicalChartLocation, 
		SecondaryBodyIDTagLocation, 
		SecondaryBodyCoolingMethod, 
		SecondaryUNOSNumber, 
		SecondaryClientNumber, 
		SecondaryCryolIFeNumber, 
		SecondaryMTFNumber, 
		SecondaryLIFeNetNumber, 
		REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText, 
		SecondaryHistorySubstanceAbuse, 
		SecondarySubstanceAbuseDetail, 
		SecondaryExtubatiONDate, 
		SecondaryExtubatiONTime, 
		SecondaryAutopsyReminderYN, 
		SecondaryFHReminderYN, 
		SecondaryBodyCareReminderYN, 
		SecondaryWrapUpReminderYN, 
		SecondaryNOKNotIFiedBy, 
		CONVERT(varchar, SecondaryNOKNotIFiedDate, 121) AS SecondaryNOKNotIFiedDate, 
		SecondaryNOKNotIFiedTime, 
		SecondaryNOKGender, 
		SecondaryCODOther, 
		SecondaryAutopsyLocationOther, 
		SecondaryPatientHospitalPhone, 
		SecondaryCoronerCase, 

		Abo.AboRefName AS SecondaryPatientABO, 
		SecondaryPatientSuffix, 
		SecondaryMDAttendingId, 
		REPLACE(REPLACE(SecondaryAdditionalComments, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalComments, rhy.RhythmName AS  SecondaryRhythm, 
		REPLACE(REPLACE(SecondaryAdditionalMedications, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalMedications, 
		CONVERT(varchar, SecondaryBodyHoldPlaced, 121) AS SecondaryBodyHoldPlaced, 
		SecondaryBodyHoldPlacedWith, 

		SecondaryBodyFutureContact, 
		SecondaryBodyHoldPhone, 
		SecondaryBodyHoldInstructionsGiven, 
		SecondarySteroid, 
		SecondaryBodyHoldPlacedTime, 

		SecondaryAntibiotic1Name, 
		SecondaryAntibiotic1Dose, 
		SecondaryAntibiotic1StartDate, 
		SecondaryAntibiotic1ENDDate, 
		SecondaryAntibiotic2Name, 

		SecondaryAntibiotic2Dose, 
		SecondaryAntibiotic2StartDate, 
		SecondaryAntibiotic2ENDDate, 
		SecondaryAntibiotic3Name, 
		SecondaryAntibiotic3Dose, 

		SecondaryAntibiotic3StartDate, 
		SecondaryAntibiotic3ENDDate, 
		SecondaryAntibiotic4Name, 
		SecondaryAntibiotic4Dose, 
		SecondaryAntibiotic4StartDate, 

		SecondaryAntibiotic4ENDDate, 
		SecondaryAntibiotic5Name, 
		SecondaryAntibiotic5Dose, 
		SecondaryAntibiotic5StartDate, 
		SecondaryAntibiotic5ENDDate, 

		SecondaryBloodProductsReceived1Type, 
		SecondaryBloodProductsReceived1Units, 
		SecondaryBloodProductsReceived1TypeCC, 

		SecondaryBloodProductsReceived1TypeUnitGiven, 
		SecondaryBloodProductsReceived2Type, 
		SecondaryBloodProductsReceived2Units, 

		SecondaryBloodProductsReceived2TypeCC, 
		SecondaryBloodProductsReceived2TypeUnitGiven, 
		SecondaryBloodProductsReceived3Type, 

		SecondaryBloodProductsReceived3Units, 
		SecondaryBloodProductsReceived3TypeCC, 
		SecondaryBloodProductsReceived3TypeUnitGiven, 

		SecondaryColloidsInfused1Type, 
		SecondaryColloidsInfused1Units, 
		SecondaryColloidsInfused1CC, 
		SecondaryColloidsInfused1UnitGiven, 

		SecondaryColloidsInfused2Type, 
		SecondaryColloidsInfused2Units, 
		SecondaryColloidsInfused2CC, 
		SecondaryColloidsInfused2UnitGiven, 

		SecondaryColloidsInfused3Type, 
		SecondaryColloidsInfused3Units, 
		SecondaryColloidsInfused3CC, 
		SecondaryColloidsInfused3UnitGiven, 

		SecondaryCrystalloids1Type, 
		SecondaryCrystalloids1Units, 
		SecondaryCrystalloids1CC, 
		SecondaryCrystalloids1UnitGiven, 
		SecondaryCrystalloids2Type, 

		SecondaryCrystalloids2Units, 
		SecondaryCrystalloids2CC, 
		SecondaryCrystalloids2UnitGiven, 
		SecondaryCrystalloids3Type, 
		SecondaryCrystalloids3Units, 

		SecondaryCrystalloids3CC, 
		SecondaryCrystalloids3UnitGiven, 
		SecondaryWBC1Date, 
		SecondaryWBC1, 
		SecondaryWBC1BANDs, 
		SecondaryWBC2Date, 

		SecondaryWBC2, 
		SecondaryWBC2BANDs, 
		SecondaryWBC3Date, 
		SecondaryWBC3, 
		SecondaryWBC3BANDs, 
		SecondaryLabTemp1, 
		CONVERT(varchar, SecondaryLabTemp1Date, 121) AS SecondaryLabTemp1Date, 

		SecondaryLabTemp1Time, 
		SecondaryLabTemp2, 
		CONVERT(varchar, SecondaryLabTemp2Date, 121)  AS SecondaryLabTemp2Date, 
		SecondaryLabTemp2Time, 
		SecondaryLabTemp3, 
		CONVERT(varchar, SecondaryLabTemp3Date, 121) AS  SecondaryLabTemp3Date, 

		SecondaryLabTemp3Time, 
		SecondaryCulture1Type, 
		SecondaryCulture1Other, 
		SecondaryCulture1DrawnDate, 
		SecondaryCulture1Growth, 
		SecondaryCulture2Type, 

		SecondaryCulture2Other, 
		SecondaryCulture2DrawnDate, 
		SecondaryCulture2Growth, 
		SecondaryCulture3Type, 
		SecondaryCulture3Other, 
		SecondaryCulture3DrawnDate, 

		SecondaryCulture3Growth, 
		SecondaryCXRAvailable, 
		SecondaryCXR1Date, 
		REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding, 
		SecondaryCXR2Date, 
		REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding, 

		SecondaryCXR3Date, 
		REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding, 
		SecondaryAntibiotic1NameOther, 

		SecondaryAntibiotic2NameOther, 
		SecondaryAntibiotic3NameOther, 
		SecondaryAntibiotic4NameOther, 
		SecondaryAntibiotic5NameOther, 
		SecondaryBloodProductsReceived1TypeOther, 
		SecondaryBloodProductsReceived2TypeOther, 
		SecondaryBloodProductsReceived3TypeOther, 
		SecondaryColloidsInfused1TypeOther, 

		SecondaryColloidsInfused2TypeOther, 
		SecondaryColloidsInfused3TypeOther, 
		SecondaryCrystalloids1TypeOther, 
		SecondaryCrystalloids2TypeOther, 

		SecondaryCrystalloids3TypeOther, 
		SecondaryApproached, 
		Per.PersonFirst  + ' ' + Per.PersonLast  AS SecondaryApproachedBy, 
		SecondaryApproachType, 
		SecondaryApproachOutcome, 
		FSA.FSApproachName AS SecondaryApproachReASON, 

		SecondaryConsented, 
		Pers.PersonFirst + ' ' + Pers.PersonLast AS  SecondaryConsentBy, 
		SecondaryConsentOutcome, 
		SecondaryConsentResearch, 
		SecondaryRecoveryLocation, 
		apt.ApproachTypeName AS  SecondaryHospitalApproach, 

		pha.PersonFirst + ' ' + pha.PersonLast AS SecondaryHospitalApproachedByText, 
		SecondaryHospitalOutcome, 
		SecondaryConsentMedSocPaperwork, 
		Pms.PersonFirst + ' ' + Pms.PersonLast AS  SecondaryConsentMedSocObtainedBy, 
		SecondaryConsentFuneralPlans, 

		SecondaryConsentFuneralPlansOther, 
		SecondaryConsentLONgSleeves , 
		Referral.LastModIFied , 
		SecondaryAdditionalMedications , 
		Person.PersonFirst + ' ' + Person.PersonLast AS SecondaryHospitalApproachBy
		, 

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
		STBI.SecondaryTBINumber,
		STBI.SecondaryTBIAssignmentNotNeeded,
		STBI.SecondaryTBIComment

	FROM 
 		Call 
		JOIN Referral ON Referral.CallID = Call.CallID 
		LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
		LEFT JOIN OrganizatiON ON OrganizatiON.OrganizationID = Referral.ReferralCallerOrganizationID 
		LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
		LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
		LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
		LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID
		LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
		LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD
		LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD
		LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID
		LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID
		LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID
		LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
		LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
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
		LEFT JOIN CallCustomField ON CallCustomField.CallID = Referral.CallID 
		LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID
		LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
		LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID
			AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
		LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID
		LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
		LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
		LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD 
		LEFT JOIN OrganizatiON AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN State AS CoronersT ON CoronersT.StateID = CoronerOrg.StateID 
		LEFT JOIN Secondary ON Secondary.CallID = Call.CallID 
		LEFT JOIN Secondary2 ON Secondary2.CallID = Call.CallID 
		LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID 
		LEFT JOIN FSCase ON FSCase.CallID = Call.CallID 
		LEFT JOIN OrganizatiON ME ON ME.OrganizationName = Referral.ReferralCoronerOrganizatiON
		LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID 
		LEFT JOIN ABORef ABO ON ABO.AboRefID = Secondary.SecondaryPatientABO
		LEFT JOIN Rhythm Rhy ON Rhy.RhythmID = Secondary.SecondaryRhythm
		LEFT JOIN Person Per ON Per.PersonID = Secondaryapproach.SecondaryApproachedBy
		LEFT JOIN FSApproach FSA ON FSA.FSApproachID = SecondaryApproach.SecondaryApproachReASON
		LEFT JOIN Person Pers ON Pers.PersonID = SecondaryApproach.SecondaryConsentby
		LEFT JOIN ApproachType apt ON apt.approachTypeID =  SecondaryApproach.SecondaryHospitalApproach
		LEFT JOIN Person Pms ON Pms.PersonID = SecondaryApproach.SecondaryConsentMedSocObtainedBy
		LEFT JOIN Person Pha ON Pha.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy
		LEFT JOIN SourceCodeOrganizatiON ON SourcecodeOrganizatiON.OrganizationID = Referral.ReferralCallerOrganizationID
		LEFT JOIN NOK ON Referral.ReferralNOKID = NOK.NOKID 
		LEFT JOIN State AS ST ON NOK.NOKStateID = ST.StateID
		LEFT JOIN SecondaryTBI STBI ON STBI.CallID = Call.CallID
		JOIN 
			(SELECT SourceCodeID, 
					OrgID
				FROM dbo.fn_GetStatInfoReportWebGroups 
				(
					@vUserName
				)
			) fn ON fn.SourceCodeID = Call.SourceCodeID AND fn.OrgID = ReferralCallerOrganizationID			
	WHERE  
		Call.CallID = @CallID; 

	---- set the UnusedField1 to 1 to note the referral has been pulled.
	UPDATE
		Referral 
	SET 
		UnusedField1 = 1
	WHERE 
		Referral.CallID = @CallID;

END

GO
