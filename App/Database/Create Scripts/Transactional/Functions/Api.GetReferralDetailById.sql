IF OBJECT_ID('Api.GetReferralDetailById') IS NOT NULL 
DROP FUNCTION Api.GetReferralDetailById;
GO

CREATE FUNCTION Api.GetReferralDetailById
(
	@webReportGroupId int,
	@referralId int
)
RETURNS TABLE
AS

-- Below I tried to fit the query into an inline
-- function to avoid defining a table type with all 
-- numerous columns.

RETURN(
SELECT DISTINCT 
	Referral.ReferralID, 
	Call.LastModified as CallLastModified, 
	CallNumber,
	Referral.CallID,
	CallDateTime, 
 	StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', 
 	Referral.ReferralTypeID, 
	ReferralTypeName, 
	(SELECT StatusId FROM Api.GetReferralStatusId(ReferralID)) AS ReferralStatusID,
	(SELECT StatusName FROM Api.GetReferralStatusName(ReferralID)) AS ReferralStatus,
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', 
	ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', 
	PersonTypeName, 
	Organization.ProviderNumber 'OrganizationUserCode', 
	Organization.OrganizationName, 
		Case 
			When SubLocationName is null Then '' 
			Else SubLocationName End + ' ' + 
		Case 
			When ReferralCallerSubLocationLevel is null Then '' 
			Else ReferralCallerSubLocationLevel End 
		AS 'CallerOrganizationUnit', 
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
	ReferralDonorAdmitDate, 
	ReferralDonorAdmitTime,
	ReferralDonorOnVentilator, 
	ReferralDonorDeathDate, 
	ReferralDonorDeathTime, 
	ReferralApproachTypeID, 
	ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', 
	Case 
		When ReferralNOKID is not null THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName, CHAR(10), CHAR(32)), CHAR(13), ''), 50)
		ELSE ReferralApproachNOK END 
		AS ReferralApproachNOK,
 	Case 
 		When ReferralNOKID is not null THEN nok.nokApproachRelation 
 		else referralapproachrelation END 
 		AS ReferralApproachRelation, 
 	---- Appropriate
 	ReferralOrganAppropriateID, 
 	ReferralBoneAppropriateID, 
 	ReferralTissueAppropriateID, 
 	ReferralSkinAppropriateID, 
 	ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	---- Approach
	case when RegistryStatus.RegistryStatus = 6 then 23 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	---- Consent
	case when RegistryStatus.RegistryStatus = 6 then 12 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	---- Conversion or Recovery
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, 
	ReferralAllTissueDispositionID, 
	ReferralEyesDispositionID, 
	ReferralBoneDispositionID, 
	ReferralTissueDispositionID, 
	ReferralSkinDispositionID, 
	ReferralValvesDispositionID, 
	ReferralGeneralConsent, 
	ReferralExtubated, 
	cast(convert(char(10),ReferralDOB,101) as varchar(10)) as 'ReferralDOB', 
	ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', 
	CTY.CountyName, 
	ReferralEyesRschAppropriateID, 
	ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, 
 	ReferralEyesRschConversionID, 
 	ReferralRschDispositionID, 
 	CallCustomField.CallCustomField1 as customField_1, 
 	CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, 
	CallCustomField.CallCustomField4 as customField_4, 
	CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, 
	REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, 
	CallCustomField.CallCustomField9 as customField_9, 
	CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, 
	CallCustomField.CallCustomField12 as customField_12, 
	CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, 
	CallCustomField.CallCustomField15 as customField_15, 
	CallCustomField.CallCustomField16 as customField_16, 
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
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS ServiceLevelCustomFieldLabel_16,
 	CASE 
 		WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv 
 		ELSE NULL END 
 		as CoronerState,  
 	Referral.ReferralCoronerOrganization AS CoronerOrganization, 
	Referral.ReferralCoronerName AS CoronerName, 
	Referral.ReferralCoronerPhone AS CoronerPhone, 
	REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, 
	Case 
		When ReferralNOKID is not null then nok.nokphone 
		else Referral.ReferralNOKPhone end 
		AS NOKPhone,
	LTRIM(REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), ''))  
		AS NOKAddress, 	
	RegistryStatus.RegistryStatus RegistryStatusID, 
	RegistryStatusType.RegistryType RegistryStatusType,
	case 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = 0 then 'N' 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = -1 then 'N' 
		Else 'Y' End 
		AS PatientHasHeartbeat, 
	Case 
		When Referral.ReferralDOA = 1 then 'Y' 
		Else 'N' End 
		AS DOA, 
	AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician,
 	PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician  ,
	Referral.LastModified as ReferralLastModified,
 	CASE Referral.ReferralDOB_ILB WHEN -1 Then  1 ELSE 0 END AS ReferralDonor_ILB,
	REPLACE(REPLACE(ReferralDonorSpecificCOD, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorSpecificCOD,
	ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime,
	ReferralAttendingMDPhone,
	ReferralPronouncingMDPhone,
	CurrentReferralTypeID,
	REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS MedicalHistory, 
	NOK.NOKFirstName, 
	NOK.NOKLastName, 
	NOK.NOKCity, 
	ST.StateAbbrv AS NOKState, 
	NOK.NOKZip, 
	Referral.ReferralDonorNameMI , 
	' ' AS CoronorsCase,
	CAST(ReferralDonorWeight as varchar(6)) AS PatientWeight_Decimal,
		ReferralDonorLSADate,
	ReferralDonorLSATime,
	SourceCodeName AS SourceCode,
	CallTypeName AS CallType
FROM 
	Referral 	 
LEFT JOIN
	Call ON Call.CallID = Referral.CallID 
LEFT JOIN
	CallType ON Call.CallTypeID = CallType.CallTypeID 
LEFT JOIN 
	CallCriteria ON Referral.CallID = CallCriteria.CallID 
LEFT JOIN
	ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID 		
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
LEFT JOIN 
	SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
LEFT JOIN 
	SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID 
LEFT JOIN 
	Race ON Race.RaceID = ReferralDonorRaceID 
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
	ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID 
	AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN 
	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
LEFT JOIN 
	ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
LEFT JOIN 
	RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
LEFT JOIN
	RegistryStatusType ON RegistryStatusType.ID = RegistryStatus.RegistryStatus 
LEFT JOIN 
	Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
LEFT JOIN 
	Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD
LEFT JOIN 
 	Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN 
	State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
LEFT JOIN 
	NOK on Referral.ReferralNOKID = NOK.NOKID 
LEFT JOIN 
	State AS ST on NOK.NOKStateID = ST.StateID	
WHERE 
	Referral.ReferralID = @referralId 
	AND
	[dbo].[Referral].ReferralCallerOrganizationID IN 
		(SELECT * FROM Api.GetWebReportGroupOrganizationIds(@webReportGroupId))
	AND 
	(
	[dbo].[call].SourceCodeID IS NULL OR -- For recycled referrals
	[dbo].[call].SourceCodeID IN 
		(SELECT * FROM Api.GetWebReportGroupSourceCodes(@webReportGroupId))
	)
);
	
GO