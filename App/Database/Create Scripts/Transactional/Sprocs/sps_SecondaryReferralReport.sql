SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryReferralReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryReferralReport]
GO




CREATE PROCEDURE sps_SecondaryReferralReport @CallID INT AS

SELECT
s.SecondaryNOKaware,                                                                                                                                         -- Case Info
s.SecondaryNOKNotifiedBy,                                                                                                                                    -- Case Info
s.SecondaryNOKNotifiedDate,                                                                                                                                  -- Case Info
s.SecondaryNOKNotifiedTime,                                                                                                                                  -- Case Info
s.SecondaryFamilyInterested,                                                                                                                                 -- Case Info
s.SecondaryFamilyConsent,                                                                                                                                    -- Case Info
s.SecondaryNOKatHospital,                                                                                                                                    -- Case Info
s.SecondaryEstTimeSinceLeft,                                                                                                                                 -- Case Info
s.SecondaryTimeLeftInMT,                                                                                                                                     -- Case Info
s.SecondaryNOKNextDest,                                                                                                                                      -- Case Info
s.SecondaryNOKETA,                                                                                                                                           -- Case Info
s.SecondaryFluidsGiven,                                                                                                                                      -- Treatment Info
s.SecondaryBloodLoss,                                                                                                                                        -- Treatment Info
s.SecondarySignOfInfection,                                                                                                                                  -- Treatment Info
--SecondaryCoronerCase                       =  r.ReferralCoronersCase,                                                                                      -- Coroner -  9/23/02 drh - This comes from Secondary table now
SecondaryCoronerCase                       =  s.SecondaryCoronerCase,                                                                                      -- Coroner -  9/23/02 drh - This comes from Secondary table now
s.SecondaryCoronerCaseNumber,                                                                                                                                -- Coroner
  SecondaryCoronerState                      = (SELECT TOP 1 StateAbbrv                                                                                      -- Coroner
                                                FROM State s
                                                JOIN Organization o ON o.StateID = s.StateID 
                                                WHERE o.OrganizationName = r.ReferralCoronerOrganization),

r.ReferralCoronerOrganization                   SecondaryCoronerOrganization,                                                                                -- Coroner
s.SecondaryCoronerCounty,                                                                                                                                    -- Coroner
  SecondaryCoronerInvestigatorName           =  r.ReferralCoronerName,                                                                                       -- Coroner
  SecondaryCoronerInvestigatorPhone          =  r.ReferralCoronerPhone,                                                                                      -- Coroner
s.SecondaryCoronerReleased,                                                                                                                                  -- Coroner
s.SecondaryCoronerReleasedStipulations,                                                                                                                      -- Coroner
s.SecondaryFuneralHomeSelected,                                                                                                                              -- Funeral Home
s.SecondaryFuneralHomeName,                                                                                                                                  -- Funeral Home
s.SecondaryFuneralHomePhone,                                                                                                                                 -- Funeral Home
s.SecondaryFuneralHomeAddress,                                                                                                                               -- Funeral Home
s.SecondaryFuneralHomeContact,                                                                                                                               -- Funeral Home
s.SecondaryFuneralHomeNotified,                                                                                                                              -- Funeral Home
s.SecondaryFuneralHomeMorgueCooled,                                                                                                                          -- Funeral Home
s.SecondaryHoldOnBody,                                                                                                                                       -- Funeral Home
s.SecondaryHoldOnBodyTag,                                                                                                                                    -- Funeral Home
  SecondaryFHReminder                        =  '',                                                                                                          -- Funeral Home
s.SecondaryFHReminderYN,                                                                                                                                     -- Funeral Home
s.SecondaryBodyRefrigerationDate,                                                                                                                            -- Body Care
s.SecondaryBodyRefrigerationTime,                                                                                                                            -- Body Care
s.SecondaryBodyLocation,                                                                                                                                     -- Body Care
s.SecondaryBodyMedicalChartLocation,                                                                                                                         -- Body Care
s.SecondaryBodyIDTagLocation,                                                                                                                                -- Body Care
s.SecondaryBodyCoolingMethod,                                                                                                                                -- Body Care
  SecondaryBodyCareReminder                  =  '',                                                                                                          -- Body Care
s.SecondaryBodyCareReminderYN,                                                                                                                               -- Body Care
  SecondaryWrapUpReminder                    =  '',                                                                                                          -- Wrap-Up Items
s.SecondaryWrapUpReminderYN,                                                                                                                                 -- Wrap-Up Items
s.SecondaryUNOSNumber,                                                                                                                                       -- Case Numbers
s.SecondaryClientNumber,                                                                                                                                     -- Case Numbers
s.SecondaryCryolifeNumber,                                                                                                                                   -- Case Numbers
s.SecondaryMTFNumber,                                                                                                                                        -- Case Numbers
s.SecondaryLifeNetNumber,                                                                                                                                    -- Case Numbers
s.SecondaryFreeText,                                                                                                                                         -- Case Numbers
  SecondaryPatientHospitalName              = (SELECT TOP 1 o.OrganizationName                                                                               -- Hospital
                                               FROM Organization o
                                               WHERE o.OrganizationID = r.ReferralCallerOrganizationID),
  SecondaryPatientPhone                     = (SELECT TOP 1 '(' + p.PhoneAreaCode + ') ' + p.PhonePrefix + '-' + p.PhoneNumber
                                               FROM Phone p
                                               WHERE p.PhoneID = r.ReferralCallerPhoneID),                                                                   -- Hospital
r.ReferralCallerPhoneID,

s.SecondaryPatientHospitalPhone,                                                                                                                             -- Hospital
SecondaryPatientHospitalUnit                = (SELECT TOP 1 sloc.SubLocationName 
                                               FROM SubLocation sloc
                                               WHERE sloc.SubLocationID = r.ReferralCallerSubLocationID),                                                    -- Hospital
  SecondaryPatientContactName               = (SELECT p.PersonFirst + RTRIM(' '+(ISNULL(p.PersonMI,''))) + ' ' + p.PersonLast
                                               FROM Person p
                                               WHERE p.PersonID = r.ReferralCallerPersonID),                                                                 -- Hospital
  SecondaryPatientContactTitle              = (SELECT TOP 1 pt.PersonTypeName 
                                               FROM Person p
                                               INNER JOIN PersonType pt ON p.PersonTypeID = pt.PersonTypeID 
                                               WHERE p.PersonID = r.ReferralCallerPersonID),                                                                 -- Hospital
  SecondaryPatientMedicalRecordNumber       =  r.ReferralDonorRecNumber,                                                                                     -- Hospital
  SecondaryPatientLastName                  =  r.ReferralDonorLastName,                                                                                      -- Patient
s.SecondaryPatientMiddleName,                                                                                                                                -- Patient
  SecondaryPatientFirstName                 =  r.ReferralDonorFirstName,                                                                                     -- Patient
  SecondaryPatientDOB                       =  r.ReferralDOB,                                                                                                -- Patient
  SecondaryPatientAge                       =  r.ReferralDonorAge,                                                                                           -- Patient
  SecondaryPatientGender                    =  r.ReferralDonorGender,                                                                                        -- Patient
  SecondaryPatientRace                      = (SELECT TOP 1 rc.RaceName                                                                                      -- Patient
                                               FROM Race rc
                                               WHERE rc.RaceID = r.ReferralDonorRaceID),
  SecondaryPatientSSN                       =  r.ReferralDonorSSN,                                                                                           -- Patient
  SecondaryPatientWeight                    =  r.ReferralDonorWeight,                                                                                        -- Stats
s.SecondaryPatientHeightFeet,                                                                                                                                -- Stats
s.SecondaryPatientHeightInches,                                                                                                                              -- Stats
s.SecondaryPatientBMICalc,                                                                                                                                   -- Stats
  SecondaryPatientDOD                       =  r.ReferralDonorDeathDate,                                                                                     -- DOD
  SecondaryPatientTOD                       =  r.ReferralDonorDeathTime,                                                                                     -- DOD
s.SecondaryPatientDeathType1,                                                                                                                                -- DOD
s.SecondaryPatientTOD1,                                                                                                                                      -- DOD
s.SecondaryPatientDeathType2,                                                                                                                                -- DOD
s.SecondaryPatientTOD2,                                                                                                                                      -- DOD
s.SecondaryTriageHX,                                                                                                                                         -- History
s.SecondaryCircumstanceOfDeath,                                                                                                                              -- History
s.SecondaryMedicalHistory,                                                                                                                                   -- History
s.SecondaryPhysicalAppearance,                                                                                                                               -- History
s.SecondaryHistorySubstanceAbuse,                                                                                                                            -- History
s.SecondarySubstanceAbuseDetail,                                                                                                                             -- History
s.SecondaryAdmissionDiagnosis,                                                                                                                               -- Admit/COD
  SecondaryAdmissionDate                    =  r.ReferralDonorAdmitDate,                                                                                     -- Admit/COD
  SecondaryAdmissionTime                    =  r.ReferralDonorAdmitTime,                                                                                     -- Admit/COD
  SecondaryCOD                             = (SELECT CASE s.SecondaryCOD
                                                       WHEN -1 THEN s.SecondaryCODOther
                                                       WHEN  0 THEN s.SecondaryCODOther
                                                       ELSE  (SELECT TOP 1 cod.FS_CauseOfDeathName 
                                                              FROM FS_CauseOfDeath cod
                                                              WHERE cod.FS_CauseOfDeathID = s.SecondaryCOD)
                                                     END),                                                                                                   -- Admit/COD
s.SecondaryCODSignatory,                                                                                                                                     -- Admit/COD
s.SecondaryCODTime,                                                                                                                                          -- Admit/COD
s.SecondaryCODSignedBy,                                                                                                                                      -- Admit/COD
s.SecondaryPatientVent,                                                                                                                                      -- Admit/COD
s.SecondaryIntubationDate,                                                                                                                                   -- Admit/COD
s.SecondaryIntubationTime,                                                                                                                                   -- Admit/COD
s.SecondaryExtubationDate,                                                                                                                                   -- Admit/COD
s.SecondaryExtubationTime,                                                                                                                                   -- Admit/COD
s.SecondaryBrainDeathDate,                                                                                                                                   -- Admit/COD
s.SecondaryBrainDeathTime,                                                                                                                                   -- Admit/COD
s.SecondaryDNRDate,                                                                                                                                          -- Admit/COD
s.SecondaryERORDeath,                                                                                                                                        -- ER/OR/Peds
s.SecondaryEMSArrivalToPatientDate,                                                                                                                          -- ER/OR/Peds
s.SecondaryEMSArrivalToPatientTime,                                                                                                                          -- ER/OR/Peds
s.SecondaryEMSArrivalToHospitalDate,                                                                                                                         -- ER/OR/Peds
s.SecondaryEMSArrivalToHospitalTime,                                                                                                                         -- ER/OR/Peds
s.SecondaryPatientTerminal,                                                                                                                                  -- ER/OR/Peds
s.SecondaryDeathWitnessed,                                                                                                                                   -- ER/OR/Peds
s.SecondaryDeathWitnessedBy,                                                                                                                                 -- ER/OR/Peds
s.SecondaryLSADate,                                                                                                                                          -- ER/OR/Peds
s.SecondaryLSATime,                                                                                                                                          -- ER/OR/Peds
s.SecondaryLSABy,                                                                                                                                            -- ER/OR/Peds
s.SecondaryACLSProvided,                                                                                                                                     -- ER/OR/Peds
s.SecondaryACLSProvidedTime,                                                                                                                                 -- ER/OR/Peds
s.SecondaryGestationalAge,                                                                                                                                   -- ER/OR/Peds
s.SecondaryParentName1,                                                                                                                                      -- ER/OR/Peds
s.SecondaryParentName2,                                                                                                                                      -- ER/OR/Peds
s.SecondaryBirthCBO,                                                                                                                                         -- ER/OR/Peds
s.SecondaryActiveInfection,                                                                                                                                  -- ER/OR/Peds
s.SecondaryActiveInfectionType,                                                                                                                              -- ER/OR/Peds
s.SecondaryMedication,                                                                                                                                       -- Medications
s.SecondaryAntibiotic,                                                                                                                                       -- Antibiotics
   SecondaryAntibiotic1Name                = (SELECT CASE s2.SecondaryAntibiotic1Name
                                                       WHEN -1 THEN s2.SecondaryAntibiotic1NameOther
                                                       WHEN  0 THEN s2.SecondaryAntibiotic1NameOther
                                                       ELSE  (SELECT TOP 1 m.MedicationName 
                                                              FROM Medication m 
                                                              WHERE m.MedicationID = s2.SecondaryAntibiotic1Name)
                                                     END),                                                                                                   -- Antibiotics
s2.SecondaryAntibiotic1Dose,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic1StartDate,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic1EndDate,                                                                                                                               -- Antibiotics
   SecondaryAntibiotic2Name                = (SELECT CASE s2.SecondaryAntibiotic2Name
                                                       WHEN -1 THEN s2.SecondaryAntibiotic2NameOther
                                                       WHEN  0 THEN s2.SecondaryAntibiotic2NameOther
                                                       ELSE  (SELECT TOP 1 m.MedicationName 
                                                              FROM Medication m 
                                                              WHERE m.MedicationID = s2.SecondaryAntibiotic2Name)
                                                     END),                                                                                                   -- Antibiotics
s2.SecondaryAntibiotic2Dose,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic2StartDate,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic2EndDate,                                                                                                                               -- Antibiotics
   SecondaryAntibiotic3Name                = (SELECT CASE s2.SecondaryAntibiotic3Name
                                                       WHEN -1 THEN s2.SecondaryAntibiotic3NameOther
                                                       WHEN  0 THEN s2.SecondaryAntibiotic3NameOther
                                                       ELSE  (SELECT TOP 1 m.MedicationName 
                                                              FROM Medication m 
                                                              WHERE m.MedicationID = s2.SecondaryAntibiotic3Name)
                                                     END),                                                                                                   -- Antibiotics
s2.SecondaryAntibiotic3Dose,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic3StartDate,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic3EndDate,                                                                                                                               -- Antibiotics

   SecondaryAntibiotic4Name                = (SELECT CASE s2.SecondaryAntibiotic4Name
                                                       WHEN -1 THEN s2.SecondaryAntibiotic4NameOther
                                                       WHEN  0 THEN s2.SecondaryAntibiotic4NameOther
                                                       ELSE  (SELECT TOP 1 m.MedicationName 
                                                              FROM Medication m 
                                                              WHERE m.MedicationID = s2.SecondaryAntibiotic4Name)
                                                     END),                                                                                                   -- Antibiotics
s2.SecondaryAntibiotic4Dose,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic4StartDate,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic4EndDate,                                                                                                                               -- Antibiotics

   SecondaryAntibiotic5Name                = (SELECT CASE s2.SecondaryAntibiotic5Name
                                                       WHEN -1 THEN s2.SecondaryAntibiotic5NameOther
                                                       WHEN  0 THEN s2.SecondaryAntibiotic5NameOther
                                                       ELSE  (SELECT TOP 1 m.MedicationName 
                                                              FROM Medication m 
                                                              WHERE m.MedicationID = s2.SecondaryAntibiotic5Name)
                                                     END),                                                                                                   -- Antibiotics
s2.SecondaryAntibiotic5Dose,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic5StartDate,                                                                                                                               -- Antibiotics
s2.SecondaryAntibiotic5EndDate,                                                                                                                               -- Antibiotics
s.SecondaryPCPName,                                                                                                                                          -- PCP/Attending
s.SecondaryPCPPhone,                                                                                                                                         -- PCP/Attending
s.SecondaryMDAttending,                                                                                                                                      -- PCP/Attending
s.SecondaryMDAttendingPhone,                                                                                                                                 -- PCP/Attending
s2.SecondaryWBC1,                                                                                                                                            -- WBC
s2.SecondaryWBC1Date,                                                                                                                                        -- WBC
s2.SecondaryWBC1Bands,                                                                                                                                       -- WBC
s2.SecondaryWBC2,                                                                                                                                            -- WBC
s2.SecondaryWBC2Date,                                                                                                                                        -- WBC
s2.SecondaryWBC2Bands,                                                                                                                                       -- WBC
s2.SecondaryWBC3,                                                                                                                                            -- WBC
s2.SecondaryWBC3Date,                                                                                                                                        -- WBC
s2.SecondaryWBC3Bands,                                                                                                                                       -- WBC
s2.SecondaryLabTemp1Date,                                                                                                                                    -- Temp
s2.SecondaryLabTemp1Time,                                                                                                                                    -- Temp
s2.SecondaryLabTemp1,                                                                                                                                        -- Temp
s2.SecondaryLabTemp2Date,                                                                                                                                    -- Temp
s2.SecondaryLabTemp2Time,                                                                                                                                    -- Temp
s2.SecondaryLabTemp2,                                                                                                                                        -- Temp
s2.SecondaryLabTemp3Date,                                                                                                                                    -- Temp
s2.SecondaryLabTemp3Time,                                                                                                                                    -- Temp
s2.SecondaryLabTemp3,                                                                                                                                        -- Temp
   SecondaryCulture1Type                   = (SELECT CASE s2.SecondaryCulture1Type
                                                       WHEN -1 THEN s2.SecondaryCulture1Other
                                                       WHEN  0 THEN s2.SecondaryCulture1Other
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCulture1Type)
                                                     END),                                                                                                   -- Culture

s2.SecondaryCulture1DrawnDate,                                                                                                                               -- Culture
s2.SecondaryCulture1Growth,                                                                                                                                  -- Culture
   SecondaryCulture2Type                   = (SELECT CASE s2.SecondaryCulture2Type
                                                       WHEN -1 THEN s2.SecondaryCulture2Other
                                                       WHEN  0 THEN s2.SecondaryCulture2Other
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCulture2Type)
                                                     END),                                                                                                   -- Culture

s2.SecondaryCulture2DrawnDate,                                                                                                                               -- Culture
s2.SecondaryCulture2Growth,                                                                                                                                  -- Culture
   SecondaryCulture3Type                   = (SELECT CASE s2.SecondaryCulture3Type
                                                       WHEN -1 THEN s2.SecondaryCulture3Other
                                                       WHEN  0 THEN s2.SecondaryCulture3Other
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCulture3Type)
                                                     END),                                                                                                   -- Culture
s2.SecondaryCulture3DrawnDate,                                                                                                                               -- Culture
s2.SecondaryCulture3Growth,                                                                                                                                  -- Culture
s.SecondarySputumCharacteristics,                                                                                                                            -- Culture
s2.SecondaryCXRAvailable,                                                                                                                                    -- CXR
s2.SecondaryCXR1Date,                                                                                                                                        -- CXR
s2.SecondaryCXR1Finding,                                                                                                                                     -- CXR

s2.SecondaryCXR2Date,                                                                                                                                        -- CXR
s2.SecondaryCXR2Finding,                                                                                                                                     -- CXR
s2.SecondaryCXR3Date,                                                                                                                                        -- CXR
s2.SecondaryCXR3Finding,                                                                                                                                     -- CXR
  SecondaryNOKName                           =  r.ReferralApproachNOK,                                                                                       -- NOK
  SecondaryNOKPhone                          =  r.ReferralNOKPhone,                                                                                          -- NOK
s.SecondaryNOKAltPhone,                                                                                                                                      -- NOK
  SecondaryNOKRelation                       =  r.ReferralApproachRelation,                                                                                  -- NOK
s.SecondaryNOKGender,                                                                                                                                        -- NOK
  SecondaryNOKAddress                        =  r.ReferralNOKAddress,                                                                                        -- NOK
s.SecondaryNOKLegal,                                                                                                                                         -- NOK
s.SecondaryNOKAltContact,                                                                                                                                    -- Alt Contact
s.SecondaryNOKAltContactPhone,                                                                                                                               -- Alt Contact
s.SecondaryNOKPostMortemAuthorization,                                                                                                                       -- Post-Mortem
s.SecondaryNOKPostMortemAuthorizationReminder,                                                                                                               -- Post-Mortem
s.SecondaryAutopsy,                                                                                                                                          -- Autopsy
s.SecondaryAutopsyDate,                                                                                                                                      -- Autopsy
s.SecondaryAutopsyTime,                                                                                                                                      -- Autopsy
  SecondaryAutopsyLocation                 = (SELECT CASE s.SecondaryAutopsyLocation
                                                       WHEN -1 THEN s.SecondaryAutopsyLocationOther
                                                       WHEN  0 THEN s.SecondaryAutopsyLocationOther
                                                       WHEN  1 THEN 'OR'
                                                       WHEN  2 THEN 'Morgue'
                                                       WHEN  3 THEN 'Funeral Home'
                                                       WHEN  4 THEN 'Coroners Office'
                                                       ELSE NULL
                                                     END),                                                                                                   -- Autopsy
s.SecondaryAutopsyBloodRequested,                                                                                                                            -- Autopsy
s.SecondaryAutopsyCopyRequested,                                                                                                                             -- Autopsy
  SecondaryAutopsyReminder                 =  '',                                                                                                            -- Autopsy
s.SecondaryAutopsyReminderYN,                                                                                                                                -- Autopsy
s.SecondaryInternalBloodLossCC,                                                                                                                              -- Blood Loss
s.SecondaryExternalBloodLossCC,                                                                                                                              -- Blood Loss
s.SecondaryBloodProducts,                                                                                                                                    -- Blood Products
   SecondaryBloodProductsReceived1Type     = (SELECT CASE s2.SecondaryBloodProductsReceived1Type
                                                       WHEN -1 THEN s2.SecondaryBloodProductsReceived1TypeOther
                                                       WHEN  0 THEN s2.SecondaryBloodProductsReceived1TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryBloodProductsReceived1Type)
                                                     END),                                                                                                   -- Blood Products
s2.SecondaryBloodProductsReceived1Units,                                                                                                                     -- Blood Products
s2.SecondaryBloodProductsReceived1TypeCC,                                                                                                                    -- Blood Products
s2.SecondaryBloodProductsReceived1TypeUnitGiven,                                                                                                             -- Blood Products
   SecondaryBloodProductsReceived2Type     = (SELECT CASE s2.SecondaryBloodProductsReceived2Type
                                                       WHEN -1 THEN s2.SecondaryBloodProductsReceived2TypeOther
                                                       WHEN  0 THEN s2.SecondaryBloodProductsReceived2TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryBloodProductsReceived2Type)
                                                     END),                                                                                                   -- Blood Products
s2.SecondaryBloodProductsReceived2Units,                                                                                                                     -- Blood Products
s2.SecondaryBloodProductsReceived2TypeCC,                                                                                                                    -- Blood Products
s2.SecondaryBloodProductsReceived2TypeUnitGiven,                                                                                                             -- Blood Products
   SecondaryBloodProductsReceived3Type     = (SELECT CASE s2.SecondaryBloodProductsReceived3Type
                                                       WHEN -1 THEN s2.SecondaryBloodProductsReceived3TypeOther
                                                       WHEN  0 THEN s2.SecondaryBloodProductsReceived3TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryBloodProductsReceived3Type)
                                                     END),                                                                                                   -- Blood Products
s2.SecondaryBloodProductsReceived3Units,                                                                                                                     -- Blood Products
s2.SecondaryBloodProductsReceived3TypeCC,                                                                                                                    -- Blood Products
s2.SecondaryBloodProductsReceived3TypeUnitGiven,                                                                                                             -- Blood Products
s.SecondaryColloidsInfused,                                                                                                                                  -- Colloids
   SecondaryColloidsInfused1Type           = (SELECT CASE s2.SecondaryColloidsInfused1Type
                                                       WHEN -1 THEN s2.SecondaryColloidsInfused1TypeOther
                                                       WHEN  0 THEN s2.SecondaryColloidsInfused1TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryColloidsInfused1Type)
                                                     END),
s2.SecondaryColloidsInfused1Units,                                                                                                                           -- Colloids
s2.SecondaryColloidsInfused1CC,                                                                                                                              -- Colloids
s2.SecondaryColloidsInfused1UnitGiven,                                                                                                                       -- Colloids
   SecondaryColloidsInfused2Type           = (SELECT CASE s2.SecondaryColloidsInfused2Type
                                                       WHEN -1 THEN s2.SecondaryColloidsInfused2TypeOther
                                                       WHEN  0 THEN s2.SecondaryColloidsInfused2TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryColloidsInfused2Type)
                                                     END),
s2.SecondaryColloidsInfused2Units,                                                                                                                           -- Colloids
s2.SecondaryColloidsInfused2CC,                                                                                                                              -- Colloids
s2.SecondaryColloidsInfused2UnitGiven,                                                                                                                       -- Colloids
   SecondaryColloidsInfused3Type           = (SELECT CASE s2.SecondaryColloidsInfused3Type
                                                       WHEN -1 THEN s2.SecondaryColloidsInfused3TypeOther
                                                       WHEN  0 THEN s2.SecondaryColloidsInfused3TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryColloidsInfused3Type)
                                                     END),
s2.SecondaryColloidsInfused3Units,                                                                                                                           -- Colloids
s2.SecondaryColloidsInfused3CC,                                                                                                                              -- Colloids
s2.SecondaryColloidsInfused3UnitGiven,                                                                                                                       -- Colloids
s.SecondaryCrystalloids,                                                                                                                                     -- Crystalloids
   SecondaryCrystalloids1Type              = (SELECT CASE s2.SecondaryCrystalloids1Type
                                                       WHEN -1 THEN s2.SecondaryCrystalloids1TypeOther
                                                       WHEN  0 THEN s2.SecondaryCrystalloids1TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCrystalloids1Type)
                                                     END),
s2.SecondaryCrystalloids1Units,                                                                                                                              -- Crystalloids
s2.SecondaryCrystalloids1CC,                                                                                                                                 -- Crystalloids
s2.SecondaryCrystalloids1UnitGiven,                                                                                                                          -- Crystalloids
   SecondaryCrystalloids2Type              = (SELECT CASE s2.SecondaryCrystalloids2Type
                                                       WHEN -1 THEN s2.SecondaryCrystalloids2TypeOther
                                                       WHEN  0 THEN s2.SecondaryCrystalloids2TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCrystalloids2Type)
                                                     END),
s2.SecondaryCrystalloids2Units,                                                                                                                              -- Crystalloids
s2.SecondaryCrystalloids2CC,                                                                                                                                 -- Crystalloids
s2.SecondaryCrystalloids2UnitGiven,                                                                                                                          -- Crystalloids
   SecondaryCrystalloids3Type              = (SELECT CASE s2.SecondaryCrystalloids3Type
                                                       WHEN -1 THEN s2.SecondaryCrystalloids3TypeOther
                                                       WHEN  0 THEN s2.SecondaryCrystalloids3TypeOther
                                                       ELSE  (SELECT TOP 1 bp.BloodProductName 
                                                              FROM BloodProduct bp 
                                                              WHERE bp.BloodProductID = s2.SecondaryCrystalloids3Type)
                                                     END),
s2.SecondaryCrystalloids3Units,                                                                                                                              -- Crystalloids
s2.SecondaryCrystalloids3CC,                                                                                                                                 -- Crystalloids
s2.SecondaryCrystalloids3UnitGiven,                                                                                                                          -- Crystalloids
s.SecondaryPreTransfusionSampleRequired,                                                                                                                     -- Pre-Transfusion
s.SecondaryPreTransfusionSampleAvailable,                                                                                                                    -- Pre-Transfusion
s.SecondaryPreTransfusionSampleDrawnDate,                                                                                                                    -- Pre-Transfusion
s.SecondaryPreTransfusionSampleDrawnTime,                                                                                                                    -- Pre-Transfusion
s.SecondaryPreTransfusionSampleQuantity,                                                                                                                     -- Pre-Transfusion
s.SecondaryPreTransfusionSampleHeldAt,                                                                                                                       -- Pre-Transfusion
s.SecondaryPreTransfusionSampleHeldDate,                                                                                                                     -- Pre-Transfusion
s.SecondaryPreTransfusionSampleHeldTime,                                                                                                                     -- Pre-Transfusion
s.SecondaryPreTransfusionSampleHeldTechnician,                                                                                                               -- Pre-Transfusion
s.SecondaryPostMordemSampleTestSuitable,                                                                                                                     -- Post Mortem
s.SecondaryPostMordemSampleLocation,                                                                                                                         -- Post Mortem
s.SecondaryPostMordemSampleContact,                                                                                                                          -- Post Mortem
s.SecondaryPostMordemSampleCollectionDate,                                                                                                                   -- Post Mortem
s.SecondaryPostMordemSampleCollectionTime,                                                                                                                   -- Post Mortem

  FSCaseOpen                               =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseOpenDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseOpenUserID),

  FSCaseSysEvents                          =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseSysEventsDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                              FROM StatEmployee se
                                              WHERE se.StatEmployeeId = fsc.FSCaseSysEventsUserID),

  FSCaseSecComp                            =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseSecCompDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseSecCompUserID),

  FSCaseApproach                           =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseApproachDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseApproachUserID),

  FSCaseFinal                              =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseFinalDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseFinalUserID),




  FSCaseBillSecondary                      =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillSecondaryUserID),

  FSCaseBillApproach                       =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillApproachDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillApproachUserID),

  FSCaseBillMedSoc                         =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillMedSocDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillMedSocUserID)

FROM Secondary s, Secondary2 s2, Referral r, FSCase fsc
WHERE s.CallID = s2.CallID
AND   s.CallID = r.CallID
AND   s.CallID = fsc.CallID
AND   s.CallID = @CallID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

