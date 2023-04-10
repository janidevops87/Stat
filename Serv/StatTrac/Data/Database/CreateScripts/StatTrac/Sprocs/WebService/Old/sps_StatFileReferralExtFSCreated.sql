SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileReferralExtFSCreated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileReferralExtFSCreated]
GO





CREATE PROCEDURE sps_StatFileReferralExtFSCreated


@vUserName as varchar(20),
			@vPassword as varchar(20),
			@vwebReportGroupID as int,
			@vStartDateTime as datetime,
			@vEndDateTime as datetime,
			@vLastRecord as int = 0


 AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update **/
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


/* FileExtendedReferralFS */ SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, DATEADD(hour, @vOrgTZdiff , CallDateTime) AS CallDateTime, CONVERT(char(8), DATEADD(hour, @vOrgTZdiff , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, 0 , CallDateTime), 8) AS CallTime, StatPerson.PersonFirst AS StatPersonFirstName, StatPerson.PersonLast AS StatPersonLastName, ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit as 'GenderAgeAndUnit', Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, ReferralDonorLastName, ReferralDonorFirstName, Organization.OrganizationName, CallerPerson.PersonFirst AS 'CallPersonFirst', CallerPerson.PersonLast AS 'CallerPersonLast', CallPersonType.PersonTypeName AS 'CallerPersonTitle', SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber as 'Phone' , ReferralCallerExtension, Case when ReferralDonorSSN is not null THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ReferralDonorWeight, ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1) as 'ReferralDonorAdmitDate', ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1) as 'ReferralDonorDeathDate', ReferralDonorDeathTime, REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralNotesCase, RaceName, CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralNOKAddress, ReferralCoronerName, ReferralCoronerOrganization, ReferralCoronerPhone, REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, '' as 'blankfield','' as 'blankfield','' as 'blankfield','' as 'blankfield', ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime, ReferralSecondaryHistory, ReferralExtubated, '' AS AppropriateOther, '' AS ApproachOther, '' AS ConsentOther, '' AS RecoveryOther, Referral.ReferralApproachTypeId, CallCustomField.CallCustomField1 as customField_1, CallCustomField.CallCustomField2 as customField_2, CallCustomField.CallCustomField3 as customField_3, CallCustomField.CallCustomField4 as customField_4, CallCustomField.CallCustomField5 as customField_5, CallCustomField.CallCustomField6 as customField_6, CallCustomField.CallCustomField7 as customField_7, CallCustomField.CallCustomField8 as customField_8, CallCustomField.CallCustomField9 as customField_9, CallCustomField.CallCustomField10 as customField_10, CallCustomField.CallCustomField11 as customField_11, CallCustomField.CallCustomField12 as customField_12, CallCustomField.CallCustomField13 as customField_13, CallCustomField.CallCustomField14 as customField_14, CallCustomField.CallCustomField15 as customField_15, CallCustomField.CallCustomField16 as customField_16, ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2, ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10, ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS  ServiceLevelCustomFieldLabel_16, CONVERT (varchar(14), DATEADD(hour, 0, Referral.lastmodified), 1) + ' ' + CONVERT (varchar(14), DATEADD(hour, 0, Referral.lastmodified), 108) as 'ftplastmodified', Organization.OrganizationUserCode, ReferralDonorRaceID, ReferralDonorCauseOfDeathID,  ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID,  ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID,  ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID,  ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID,  ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID,  ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID,  ReferralOrganConversionID, ReferralBoneConversionID, ReferralTissueConversionID,  ReferralSkinConversionID, ReferralValvesConversionID, ReferralEyesTransConversionID,  ReferralOrganDispositionID, ReferralAllTissueDispositionID, ReferralEyesDispositionID,  ReferralBoneDispositionID, ReferralTissueDispositionID, ReferralSkinDispositionID,  ReferralValvesDispositionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,  ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralRschDispositionID,  Cast(DATEPART(m, ReferralDOB) AS Varchar) + '/' + Cast(DATEPART(d, ReferralDOB) AS Varchar) + '/' + Cast(DATEPART(yyyy, ReferralDOB) AS Varchar), ReferralDonorSSN, CASE ReferralCoronersCase WHEN -1 Then 0 WHEN 0 Then -1 END AS 'CoronoersCase', CTY.CountyName AS 'CoronerCounty', REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', ReferralDonorRecNumber, CONVERT (varchar(14), DATEADD(hour, 0, CallDateTime), 1) + ' ' + CONVERT (varchar(14), DATEADD(hour, 0, CallDateTime), 108) as 'FTPCallDateTime', CASE WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv ELSE NULL END as CoronerState,  Referral.ReferralCoronerOrganization AS CoronerOrganization, Referral.ReferralCoronerName AS CoronerName, Referral.ReferralCoronerPhone AS CoronerPhone, REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, Referral.ReferralNOKPhone AS NOKPhone, REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') AS NOKAddress, RegistryStatus.RegistryStatus as RegistryStatusID, CASE RegistryStatus.RegistryStatus WHEN 1 THEN 'Found on the State Registry' WHEN 2 THEN 'Found on the Web Registry' WHEN 3 THEN 'Not on the Registry' WHEN 4 THEN 'Manually Found' WHEN 5 THEN 'Not Checked' END AS RegistryStatus, Case Referral.ReferralDonorHeartBeat WHEN 1 Then 'Y' ELSE 'N' END AS PatientHasHeartbeat, CASE Referral.ReferralDOA WHEN -1 Then 'Y' ELSE 'N' END AS DOA, AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician, PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician,  FSCaseId, FSCaseCreateUserId, FSCaseCreateDateTime, FSCaseOpenUserId, FSCaseOpenDateTime, FSCaseSysEventsUserId, FSCaseSysEventsDateTime, FSCaseSecCompUserId, FSCaseSecCompDateTime, FSCaseApproachUserId, FSCaseApproachDateTime, FSCaseFinalUserId, FSCaseFinalDateTime, FSCaseUpdate, FSCaseUserId, FSCaseBillSecondaryUserID, FSCaseBillDateTime, FSCaseBillApproachUserID, FSCaseBillApproachDateTime, FSCaseBillMedSocUserID, FSCaseBillMedSocDateTime, SecondaryManualBillPersonId, SecondaryUpdatedFlag, FSCaseTotalTime, FSCaseSeconds, FSCaseBillFamUnavailUserId, FSCaseBillFamUnavailDateTime, FSCaseBillCryoFormUserId, FSCaseBillCryoFormDateTime, FSCaseBillApproachCount, FSCaseBillMedSocCount, FSCaseBillCryoFormCount, SecondaryWhoAreWe, SecondaryNOKaware, SecondaryFamilyConsent, SecondaryFamilyInterested, SecondaryNOKatHospital, SecondaryEstTimeSinceLeft, SecondaryTimeLeftInMT, SecondaryNOKNextDest, SecondaryNOKETA, SecondaryPatientMiddleName, SecondaryPatientHeightFeet, SecondaryPatientHeightInches, SecondaryPatientBMICalc, SecondaryPatientTOD1, SecondaryPatientTOD2, SecondaryPatientDeathType1, SecondaryPatientDeathType2, SecondaryTriageHX, REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath, REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory, SecondaryAdmissionDiagnosis, SecondaryCOD, SecondaryCODSignatory, SecondaryCODTime, SecondaryCODSignedBy, SecondaryPatientVent, SecondaryIntubationDate, SecondaryIntubationTime, SecondaryBrainDeathDate, SecondaryBrainDeathTime, SecondaryDNRDate, SecondaryERORDeath, SecondaryEMSArrivalToPatientDate, SecondaryEMSArrivalToPatientTime, SecondaryEMSArrivalToHospitalDate, SecondaryEMSArrivalToHospitalTime, SecondaryPatientTerminal, SecondaryDeathWitnessed, SecondaryDeathWitnessedBy, SecondaryLSADate, SecondaryLSATime, SecondaryLSABy, SecondaryACLSProvided, SecondaryACLSProvidedTime, SecondaryGestationalAge, SecondaryParentName1, SecondaryParentName2, SecondaryBirthCBO, SecondaryActiveInfection, SecondaryActiveInfectionType, SecondaryFluidsGiven, SecondaryBloodLoss, SecondarySignOfInfection, SecondaryMedication, SecondaryAntibiotic, SecondaryPCPName, SecondaryPCPPhone, SecondaryMDAttending, SecondaryMDAttendingPhone, REPLACE(REPLACE(SecondaryPhysicalAppearance, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance, SecondaryInternalBloodLossCC, SecondaryExternalBloodLossCC, SecondaryBloodProducts, SecondaryColloidsInfused, SecondaryCrystalloids, SecondaryPreTransfusionSampleRequired, SecondaryPreTransfusionSampleAvailable, SecondaryPreTransfusionSampleDrawnDate, SecondaryPreTransfusionSampleDrawnTime, SecondaryPreTransfusionSampleQuantity, SecondaryPreTransfusionSampleHeldAt, SecondaryPreTransfusionSampleHeldDate, SecondaryPreTransfusionSampleHeldTime, SecondaryPreTransfusionSampleHeldTechnician, SecondaryPostMordemSampleTestSuitable, SecondaryPostMordemSampleLocation, SecondaryPostMordemSampleContact, SecondaryPostMordemSampleCollectionDate, SecondaryPostMordemSampleCollectionTime, REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics, SecondaryNOKAltPhone, SecondaryNOKLegal, SecondaryNOKAltContact, SecondaryNOKAltContactPhone, SecondaryNOKPostMortemAuthorization, SecondaryNOKPostMortemAuthorizationReminder, SecondaryCoronerCaseNumber, SecondaryCoronerCounty, SecondaryCoronerReleased, REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCoronerReleasedStipulations, SecondaryAutopsy, SecondaryAutopsyDate, SecondaryAutopsyTime, SecondaryAutopsyLocation, SecondaryAutopsyBloodRequested, SecondaryAutopsyCopyRequested, SecondaryFuneralHomeSelected, SecondaryFuneralHomeName, SecondaryFuneralHomePhone, SecondaryFuneralHomeAddress, SecondaryFuneralHomeContact, SecondaryFuneralHomeNotified, SecondaryFuneralHomeMorgueCooled, SecondaryHoldOnBody, SecondaryHoldOnBodyTag, SecondaryBodyRefrigerationDate, SecondaryBodyRefrigerationTime, SecondaryBodyLocation, SecondaryBodyMedicalChartLocation, SecondaryBodyIDTagLocation, SecondaryBodyCoolingMethod, SecondaryUNOSNumber, SecondaryClientNumber, SecondaryCryolifeNumber, SecondaryMTFNumber, SecondaryLifeNetNumber, REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText, SecondaryHistorySubstanceAbuse, SecondarySubstanceAbuseDetail, SecondaryExtubationDate, SecondaryExtubationTime, SecondaryAutopsyReminderYN, SecondaryFHReminderYN, SecondaryBodyCareReminderYN, SecondaryWrapUpReminderYN, SecondaryNOKNotifiedBy, SecondaryNOKNotifiedDate, SecondaryNOKNotifiedTime, SecondaryNOKGender, SecondaryCODOther, SecondaryAutopsyLocationOther, SecondaryPatientHospitalPhone, SecondaryCoronerCase, SecondaryPatientABO, SecondaryPatientSuffix, SecondaryMDAttendingId, REPLACE(REPLACE(SecondaryAdditionalComments, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalComments, SecondaryRhythm, REPLACE(REPLACE(SecondaryAdditionalMedications, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryAdditionalMedications, SecondaryBodyHoldPlaced, SecondaryBodyHoldPlacedWith, SecondaryBodyFutureContact, SecondaryBodyHoldPhone, SecondaryBodyHoldInstructionsGiven, SecondarySteroid, SecondaryBodyHoldPlacedTime, SecondaryAntibiotic1Name, SecondaryAntibiotic1Dose, SecondaryAntibiotic1StartDate, SecondaryAntibiotic1EndDate, SecondaryAntibiotic2Name, SecondaryAntibiotic2Dose, SecondaryAntibiotic2StartDate, SecondaryAntibiotic2EndDate, SecondaryAntibiotic3Name, SecondaryAntibiotic3Dose, SecondaryAntibiotic3StartDate, SecondaryAntibiotic3EndDate, SecondaryAntibiotic4Name, SecondaryAntibiotic4Dose, SecondaryAntibiotic4StartDate, SecondaryAntibiotic4EndDate, SecondaryAntibiotic5Name, SecondaryAntibiotic5Dose, SecondaryAntibiotic5StartDate, SecondaryAntibiotic5EndDate, SecondaryBloodProductsReceived1Type, SecondaryBloodProductsReceived1Units, SecondaryBloodProductsReceived1TypeCC, SecondaryBloodProductsReceived1TypeUnitGiven, SecondaryBloodProductsReceived2Type, SecondaryBloodProductsReceived2Units, SecondaryBloodProductsReceived2TypeCC, SecondaryBloodProductsReceived2TypeUnitGiven, SecondaryBloodProductsReceived3Type, SecondaryBloodProductsReceived3Units, SecondaryBloodProductsReceived3TypeCC, SecondaryBloodProductsReceived3TypeUnitGiven, SecondaryColloidsInfused1Type, SecondaryColloidsInfused1Units, SecondaryColloidsInfused1CC, SecondaryColloidsInfused1UnitGiven, SecondaryColloidsInfused2Type, SecondaryColloidsInfused2Units, SecondaryColloidsInfused2CC, SecondaryColloidsInfused2UnitGiven, SecondaryColloidsInfused3Type, SecondaryColloidsInfused3Units, SecondaryColloidsInfused3CC, SecondaryColloidsInfused3UnitGiven, SecondaryCrystalloids1Type, SecondaryCrystalloids1Units, SecondaryCrystalloids1CC, SecondaryCrystalloids1UnitGiven, SecondaryCrystalloids2Type, SecondaryCrystalloids2Units, SecondaryCrystalloids2CC, SecondaryCrystalloids2UnitGiven, SecondaryCrystalloids3Type, SecondaryCrystalloids3Units, SecondaryCrystalloids3CC, SecondaryCrystalloids3UnitGiven, SecondaryWBC1Date, SecondaryWBC1, SecondaryWBC1Bands, SecondaryWBC2Date, SecondaryWBC2, SecondaryWBC2Bands, SecondaryWBC3Date, SecondaryWBC3, SecondaryWBC3Bands, SecondaryLabTemp1, SecondaryLabTemp1Date, SecondaryLabTemp1Time, SecondaryLabTemp2, SecondaryLabTemp2Date, SecondaryLabTemp2Time, SecondaryLabTemp3, SecondaryLabTemp3Date, SecondaryLabTemp3Time, SecondaryCulture1Type, SecondaryCulture1Other, SecondaryCulture1DrawnDate, SecondaryCulture1Growth, SecondaryCulture2Type, SecondaryCulture2Other, SecondaryCulture2DrawnDate, SecondaryCulture2Growth, SecondaryCulture3Type, SecondaryCulture3Other, SecondaryCulture3DrawnDate, SecondaryCulture3Growth, SecondaryCXRAvailable, SecondaryCXR1Date, REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding, SecondaryCXR2Date, REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding, SecondaryCXR3Date, REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding, SecondaryAntibiotic1NameOther, SecondaryAntibiotic2NameOther, SecondaryAntibiotic3NameOther, SecondaryAntibiotic4NameOther, SecondaryAntibiotic5NameOther, SecondaryBloodProductsReceived1TypeOther, SecondaryBloodProductsReceived2TypeOther, SecondaryBloodProductsReceived3TypeOther, SecondaryColloidsInfused1TypeOther, SecondaryColloidsInfused2TypeOther, SecondaryColloidsInfused3TypeOther, SecondaryCrystalloids1TypeOther, SecondaryCrystalloids2TypeOther, SecondaryCrystalloids3TypeOther, SecondaryApproached, SecondaryApproachedBy, SecondaryApproachType, SecondaryApproachOutcome, SecondaryApproachReason, SecondaryConsented, SecondaryConsentBy, SecondaryConsentOutcome, SecondaryConsentResearch, SecondaryRecoveryLocation, SecondaryHospitalApproach, SecondaryHospitalApproachedBy, SecondaryHospitalOutcome, SecondaryConsentMedSocPaperwork, SecondaryConsentMedSocObtainedBy, SecondaryConsentFuneralPlans, SecondaryConsentFuneralPlansOther, SecondaryConsentLongSleeves , Referral.LastModified FROM Call JOIN Referral ON Referral.CallID = Call.CallID LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Referral.CallID LEFT JOIN Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD LEFT JOIN Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID LEFT JOIN State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID LEFT JOIN Secondary on Secondary.CallID = Call.CallID LEFT JOIN Secondary2 on Secondary2.CallID = Call.CallID LEFT JOIN SecondaryApproach on SecondaryApproach.CallID = Call.CallID LEFT JOIN FSCase on FSCase.CallID = Call.CallID LEFT JOIN Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization LEFT JOIN COUNTY CTY ON CTY.CountyID = ME.CountyID
 WHERE Call.CallDateTime BETWEEN @vStartDateTime  AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  
 ORDER BY CallDateTime



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

