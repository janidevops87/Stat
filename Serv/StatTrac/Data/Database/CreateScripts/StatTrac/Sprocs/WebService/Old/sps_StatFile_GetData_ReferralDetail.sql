SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFile_GetData_ReferralDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFile_GetData_ReferralDetail]
GO

CREATE PROCEDURE sps_StatFile_GetData_ReferralDetail
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
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0,  Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
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
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated
	FROM Referral JOIN Call ON Call.CallID = Referral.CallID Join CallCriteria ON Call.CallID = CallCriteria.CallID Join ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
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
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated
	 FROM Referral JOIN Call ON Call.CallID = Referral.CallID Join CallCriteria ON Call.CallID = CallCriteria.CallID Join ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID
	 LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID
	WHERE Referral.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vWebReportGroupID  and Referral.ReferralID > @vLastRecord     
	ORDER BY Referral.ReferralID
ELSE IF (@vCreated = 1)
	SELECT DISTINCT Referral.ReferralID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, Referral.LastModified),120) as LastModified, ReferralID, CallNumber,Convert(char(25),
 	dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, 
	ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, 
	Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', 
	ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, 
	ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(cast(ReferralNotesCase as varchar(255)), CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused',
	 Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorAdmitDate),1) as ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0,Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, ReferralDonorDeathDate),1) as ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, 
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
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated
	 FROM Referral JOIN Call ON Call.CallID = Referral.CallID Join CallCriteria ON Call.CallID = CallCriteria.CallID Join ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID  LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID
	WHERE Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime  AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  And Referral.ReferralID > @vLastRecord 
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
	ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated
	 FROM Referral JOIN Call ON Call.CallID = Referral.CallID Join CallCriteria ON Call.CallID = CallCriteria.CallID Join ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
	LEFT JOIN NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN State AS ST on NOK.NOKStateID = ST.StateID
	WHERE Referral.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vWebReportGroupID  and ReferralID > @vLastRecord     
	ORDER BY Referral.ReferralID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

