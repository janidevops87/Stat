SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileReferralDetail2004Created]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileReferralDetail2004Created]
GO



CREATE PROCEDURE sps_StatFileReferralDetail2004Created
			@vUserName as varchar(20),
			@vPassword as varchar(20),
			@vwebReportGroupID as int,
			@vStartDateTime as datetime,
			@vEndDateTime as datetime,
			@vLastRecord as int = 0


 AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update **/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

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

/* FileReferralDetail2004 */ SELECT DISTINCT ReferralID,  DATEADD(hour,@vOrgTZdiff, Referral.LastModified) as LastModified, ReferralID, CallNumber, DATEADD(hour, @vOrgTZdiff, CallDateTime) as CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', Referral.ReferralTypeID, ReferralTypeName, 1 AS 'ReferralStatusID', 'Complete' AS 'ReferralStatus', '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', ReferralCallerExtension, CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', PersonTypeName, Organization.OrganizationUserCode, Organization.OrganizationName, Case When SubLocationName is null Then '' Else SubLocationName End + ' ' + Case When SubLocationLevelName is null Then '' Else SubLocationLevelName End AS 'CallerOrganizationUnit', ReferralDonorFirstName, ReferralDonorLastName, ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorRaceID, RaceName, ReferralDonorGender, ReferralDonorWeight, ReferralDonorCauseOfDeathID, CauseOfDeathName, REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 0 AS 'Unused', ReferralDonorAdmitDate, ReferralDonorAdmitTime, ReferralDonorOnVentilator, 0, ReferralDonorDeathDate, ReferralDonorDeathTime, ReferralApproachTypeID, ApproachTypeName, ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', ReferralApproachNOK, ReferralApproachRelation, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID, ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID, ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID, ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID, ReferralValvesDispositionID, ReferralGeneralConsent, ReferralExtubated, ReferralDOB, ReferralDonorSSN, CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', CTY.CountyName, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, CallCustomField.CallCustomField6 as customField_6, REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2, ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10, ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16, CASE WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END as CoronerState,  Referral.ReferralCoronerOrganization AS CoronerOrganization, Referral.ReferralCoronerName AS CoronerName, Referral.ReferralCoronerPhone AS CoronerPhone, Referral.ReferralCoronerNote AS CoronerNote, Referral.ReferralNOKPhone AS NOKPhone, Referral.ReferralNOKAddress AS NOKAddress, RegistryStatus.RegistryStatus, Referral.ReferralDonorHeartBeat AS PatientHasHeartbeat, Referral.ReferralDOA AS DOA, AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician, PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician  FROM Referral JOIN Call ON Call.CallID = Referral.CallID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID LEFT JOIN SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID LEFT JOIN Race ON Race.RaceID = ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachTypeID=ReferralApproachTypeID LEFT JOIN Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN CallCriteria ON CallCriteria.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CallCriteria.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
WHERE Call.CallDateTime BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  and ReferralID > @vLastRecord  
ORDER BY CallDateTime



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

