SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileReferralDetailCombined]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileReferralDetailCombined]
GO



CREATE PROCEDURE sps_StatFileReferralDetailCombined
			@vUserName as varchar(20),
			@vPassword as varchar(20),
			@vwebReportGroupID as int,
			@vStartDateTime as datetime,
			@vEndDateTime as datetime,
			@vLastRecord as int = 0


 AS

	declare
		@vOrgID as int,
		@vOrgTZ as varchar(20),
		@vOrgTZdiff as int,
		@vnumRec as int

--Get OrganizationID
SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword

--Get OrganizationTimeZone
SELECT @vOrgTZ = TimeZone.TimeZoneAbbreviation 
		from Organization 
		join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
		where OrganizationID = @vOrgID
 --select @vOrgTZdiff = exec spf_TimeZone @vOrgTZ

SELECT @vOrgTZdiff = 
                    CASE @vOrgTZ
                    When 'AT' Then 3                    
                    When 'AS' Then 3                    
                    When 'ET' Then 2
                    When 'ES' Then 2
                    When 'CT' Then 1
                    When 'CS' Then 1
                    When 'MT' Then 0
                    When 'MS' Then 0
                    When 'PT' Then -1
                    When 'PS' Then -1
                    When 'KT' Then -2
                    When 'KS' Then -2
                    When 'HT' Then -3
                    When 'HS' Then -3
                    When 'ST' Then -4                                                              
                    When 'SS' Then -4                                                              
                    END

select @vnumRec = recordsreturned from StatFileOrgFrequency where OrgID = @vOrgID
set rowcount @vnumRec
SELECT DISTINCT ReferralID, DATEADD(hour, @vOrgTZdiff, Referral.LastModified) as LastModified,   ReferralID,CallNumber, DATEADD(hour, @vOrgTZdiff, CallDateTime) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, OrganizationUserCode, OrganizationName, Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused', ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', ReferralApproachNOK, ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON Race.RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
 WHERE Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime  AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  And ReferralID > @vLastRecord 

union

SELECT DISTINCT ReferralID, DATEADD(hour, @vOrgTZdiff, Referral.LastModified) as LastModified, ReferralID, CallNumber, DATEADD(hour, @vOrgTZdiff, CallDateTime) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, OrganizationUserCode, OrganizationName, Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused', ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', ReferralApproachNOK, ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON Race.RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID
 WHERE Referral.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND Call.CallDateTime NOT BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vWebReportGroupID  and ReferralID > @vLastRecord     

order by  Referral.ReferralID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

