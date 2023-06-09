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
**		07/17/2012	ccarroll			Fixed table join for TimeZone
**		03/17/2015	Bret Knoll			Converted to fn_rpt_ConvertDateTime
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

DECLARE
	@SourcecodeID AS VARCHAR(10),
	@WebReportID AS VARCHAR(10),
	@vOrgID AS INT,		
	@vReportGroupID AS INT,		 
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
	@ApproachLevel 	AS INT,
	@approachLevelEnabled AS INT,
	@webReportGroupName varchar(100),
	@TargetHashedPassword VARCHAR(100);

SELECT 
	@TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
FROM [dbo].[WebPerson]
JOIN Person ON Person.PersonID = WebPerson.PersonID
WHERE 
	[WebPersonUserName] = @vUserName 
	AND Person.Inactive <> 1;

		
--Get OrganizationID
SELECT 
	@vOrgID = Person.OrganizationID
FROM WebPerson
JOIN Person ON Person.PersonID = WebPerson.PersonID
WHERE 
	WebPersonUserName = @vUserName
	AND HashedPassword = @TargetHashedPassword;

	
--T.T 12/14/2006 turned off functionality for approachlevel servicelevel
Select @approachLevelEnabled = 0;

SELECT 
	@CallerOrgID = ReferralCallerOrganizationID 
FROM referral 
WHERE 
	callID = @CallID;

SELECT @SourceCodeDonorTracMap = SourceCodeID 
FROM call 
WHERE 
	callID = @CallID;

SELECT 
	@referraldonorTracmappingorgan = organcriteria.criteriadonortracmap,
	@ReferralDonorTracMappingBone = bonecriteria.criteriadonortracmap,
	@ReferralDonorTracMappingSoftTissue = tissuecriteria.criteriadonortracmap,
	@ReferralDonorTracMappingSkin = SkinCriteria.criteriadonortracmap,
	@ReferralDonorTracMappingValves = ValvesCriteria.criteriadonortracmap,
	@ReferralDonorTracMappingEyes = EyesCriteria.criteriadonortracmap,
	@ReferralDonorTracMappingOther = OtherCriteria.criteriadonortracmap
FROM CallCriteria 
LEFT JOIN criteria AS organcriteria ON organcriteria.criteriaID = callcriteria.OrganCriteriaID 
LEFT JOIN criteria AS bonecriteria ON bonecriteria.criteriaID = callcriteria.BoneCriteriaID
LEFT JOIN criteria AS tissuecriteria ON tissuecriteria.criteriaID = callcriteria.tissueCriteriaID 
LEFT JOIN criteria AS Skincriteria ON Skincriteria.criteriaID = callcriteria.skinCriteriaID
LEFT JOIN criteria AS Valvescriteria ON Valvescriteria.criteriaID = callcriteria.ValvesCriteriaID
LEFT JOIN criteria AS Eyescriteria ON Eyescriteria.criteriaID = callcriteria.EyesCriteriaID
LEFT JOIN criteria AS Othercriteria ON Othercriteria.criteriaID = callcriteria.OtherCriteriaID 
WHERE 
	CallCriteria.CallID =  @callID;

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
    FROM criteria
	JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
	JOIN SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
	JOIN CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
	JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	WHERE 
		OrganizationID = @CallerOrgID
		AND SourceCode.SourceCodeID =@SourceCodeDonorTracMap
		AND	CriteriaStatus = 1
) as cr;

SELECT SourceCodeID, 
	   OrgID
INTO #WebGroups
FROM dbo.fn_GetStatInfoReportWebGroups(@vUserName);


SELECT DISTINCT 
	CONVERT(VARCHAR, dbo.fn_rpt_ConvertDateTime(@vOrgID, Referral.LastModified, 0), 121) AS LastModified, 
 	Call.CallID, 
 	CallNumber, 
  	CONVERT(VARCHAR, dbo.fn_rpt_ConvertDateTime(@vOrgID,  CallDateTime, 0), 121) AS CallDateTime, 
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
	TimeZone.TimeZoneAbbreviation AS TimeZone, 
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
	CASE ReferralCoronersCASE 
		WHEN -1 THEN 0 
		ELSE -1 
	END AS 'ReferralCoronersCASE', 
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
	CONVERT(char(25), dbo.fn_rpt_ConvertDateTime(@vOrgID, ReferralDonorBrainDeathDate, 0 ), 1) AS ReferralDonorBrainDeathDate, 

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

	CASE 
		WHEN ReferralNOKID is NOT NULL THEN 
			LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '')  , 255)	
		ELSE 
			REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), 	CHAR(13), '') 
		END AS NOKAddress,
	STBI.SecondaryTBINumber,
	STBI.SecondaryTBIAssignmentNotNeeded,
	STBI.SecondaryTBIComment,
	ReferralCallerSubLocationLevel
FROM 
	Referral 
JOIN Call ON Call.CallID = Referral.CallID 
LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID 
LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID 
LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
JOIN #WebGroups fn ON fn.sourcecodeid =call.sourcecodeid and fn.orgid = ReferralCallerOrganizationID	
LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID 
LEFT JOIN Race ON ReferralDonorRaceID  = Race.RaceID
LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID 
LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID 
LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID 
LEFT JOIN Organization ME ON ME.OrganizationID = Referral.ReferralCoronerOrgID 
LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID 
LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID 
LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID
LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID 
LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID
LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD 
LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID 
LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
LEFT JOIN NOK AS NOK ON NOK.NOKID = Referral.ReferralNOKID
LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID
LEFT JOIN SecondaryTBI STBI ON STBI.CallID = Call.CallID
WHERE 
	Call.CallID = @CallID  
ORDER BY 
	Call.CallID; 

----- set flag so Referral is not sent to DT
Update Referral 
SET unusedField1 = 1
WHERE Referral.CallID = @callID;

DROP TABLE IF EXISTS #WebGroups;

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

