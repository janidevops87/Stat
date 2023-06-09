SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFile_GetData_ReferralDetailExt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFile_GetData_ReferralDetailExt]
GO


--************sps_StatFile_GetData_ReferralDetailExt

CREATE PROCEDURE sps_StatFile_GetData_ReferralDetailExt
(
	@vOrgID as int,
	@vWebReportGroupID as int,
	@vStartDateTime as datetime,
	@vEndDateTime as datetime,
	@vCreated bit,
	@vModified bit,
	@vLastRecord as int = 0
)

AS

DECLARE @vnumRec as int


SELECT top 1 @vnumRec = recordsreturned FROM StatFileOrgFrequency WHERE OrgID = @vOrgID
SET rowcount @vnumRec

IF (@vCreated = 1) AND (@vModified = 1)
	SELECT DISTINCT Referral.ReferralID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified),120) as LastModified, ReferralID, CallNumber,Convert(char(25),
 	dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, 
	ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, 
	Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, 
	ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(cast(ReferralNotesCase as varchar(255)), CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused',
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', Case When ReferralNOKID is not null THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName,50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
 	Case When ReferralNOKID is not null THEN nok.nokApproachRelation else referralapproachrelation END AS ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	--ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, 
	--ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,
 	--ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, 
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1  then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, 
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated,cast(convert(char(8),ReferralDOB,1) as varchar(8)) as 'ReferralDOB', ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', CTY.CountyName, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16
	FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID 
	WHERE Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime  AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  And Referral.ReferralID > @vLastRecord 
	
	UNION
	
SELECT DISTINCT Referral.ReferralID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified),120) as LastModified, ReferralID, CallNumber,Convert(char(25),
 	dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, 
	ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, 
	Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, 
	ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(cast(ReferralNotesCase as varchar(255)), CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused',
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', Case When ReferralNOKID is not null THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName,50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
 	Case When ReferralNOKID is not null THEN nok.nokApproachRelation else referralapproachrelation END AS ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID,
	-- ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, 
	--ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,
 	--ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, 
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1  then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, 
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated, cast(convert(char(8),ReferralDOB,1) as varchar(8)) as 'ReferralDOB', ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', CTY.CountyName, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16
	FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID WHERE Referral.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vWebReportGroupID  and Referral.ReferralID > @vLastRecord     
	ORDER BY Referral.ReferralID
ELSE IF (@vCreated = 1)
SELECT DISTINCT Referral.ReferralID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified),120) as LastModified, ReferralID, CallNumber,Convert(char(25),
 	dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, 
	ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, 
	Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, 
	ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(cast(ReferralNotesCase as varchar(255)), CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused',
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', Case When ReferralNOKID is not null THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName,50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
 	Case When ReferralNOKID is not null THEN nok.nokApproachRelation else referralapproachrelation END AS ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID,
	-- ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, 
	--ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,
 	--ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, 
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1  then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, 
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated, cast(convert(char(8),ReferralDOB,1) as varchar(8)) as 'ReferralDOB', ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', CTY.CountyName, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16
	FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID WHERE Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime  AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  And Referral.ReferralID > @vLastRecord 
	ORDER BY Referral.ReferralID
ELSE IF (@vModified = 1)
SELECT DISTINCT Referral.ReferralID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified),120) as LastModified, ReferralID, CallNumber,Convert(char(25),
 	dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, 
	ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, 
	Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, 
	ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(cast(ReferralNotesCase as varchar(255)), CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused',
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', Case When ReferralNOKID is not null THEN LEFT(NOK.NOKFirstName + ' ' + NOK.NOKLastName,50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
 	Case When ReferralNOKID is not null THEN nok.nokApproachRelation else referralapproachrelation END AS ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	--ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, 
	--ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,
 	--ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, 
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1  then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when dbo.fn_ApproachServiceLevel(CallCriteria.ServiceLevelID) = -1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, 
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated, cast(convert(char(8),ReferralDOB,1) as varchar(8)) as 'ReferralDOB', ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', CTY.CountyName, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16
	FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID WHERE Referral.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vWebReportGroupID  and Referral.ReferralID > @vLastRecord     
	ORDER BY Referral.ReferralID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

