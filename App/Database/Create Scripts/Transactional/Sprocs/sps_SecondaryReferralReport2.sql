SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryReferralReport2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryReferralReport2]
GO


CREATE   PROCEDURE sps_SecondaryReferralReport2 @CallID INT AS

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
s.SecondaryBodyCoolingMethod,                                                                                                                                -- Body Care
s.SecondaryBodyHoldPlaced,											--Body Care
s.SecondaryBodyHoldPlacedTime,										--Body Care
s.SecondaryBodyHoldPlacedWith,										--Body Care
s.SecondaryBodyFutureContact,											--Body Care
s.SecondaryBodyHoldPhone,											--Body Care
s.SecondaryBodyHoldInstructionsGiven,										--Body Care
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
r.ReferralNotesCase,
r.ReferralCallerSubLocationLevel,											--Hospital

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
s.SecondaryPatientSuffix,                                                                                                                                -- Patient
SecondaryPatientABO	 = (SELECT TOP 1 ab.ABORefName  FROM ABORef ab WHERE ab.ABORefID = s.SecondaryPatientABO),             	-- Patient
  SecondaryPatientFirstName                 =  r.ReferralDonorFirstName,                                                                                     -- Patient
  SecondaryPatientDOB                       =  r.ReferralDOB,                                                                                                -- Patient
  SecondaryPatientAge                       =  r.ReferralDonorAge,                                                                                           -- Patient
  SecondaryPatientAgeUnit                       =  r.ReferralDonorAgeUnit,                                                                                           --Patient
  SecondaryPatientGender                    =  r.ReferralDonorGender,                                                                                        -- Patient
  SecondaryPatientRace                      = (SELECT TOP 1 rc.RaceName                                                                                      -- Patient
                                               FROM Race rc
                                               WHERE rc.RaceID = r.ReferralDonorRaceID),
  SecondaryPatientSSN                       =  r.ReferralDonorSSN,                                                                                           -- Patient
  SecondaryPatientWeight                    =  r.ReferralDonorWeight,                                                                                        -- Patient
s.SecondaryPatientHeightFeet,                                                                                                                                -- Patient
s.SecondaryPatientHeightInches,                                                                                                                              -- Patient
s.SecondaryPatientBMICalc,                                                                                                                                   -- Patient
  SecondaryPatientDOD                       =  r.ReferralDonorDeathDate,                                                                                     -- DOD/COD/PCP/Attending
  SecondaryPatientTOD                       =  r.ReferralDonorDeathTime,                                                                                     -- DOD/COD/PCP/Attending
s.SecondaryBrainDeathDate,                                                                                                                                   -- DOD/COD/PCP/Attending
s.SecondaryBrainDeathTime,                                                                                                                                   -- DOD/COD/PCP/Attending
s.SecondaryPCPName,                                                                                                                                          -- DOD/COD/PCP/Attending
s.SecondaryPCPPhone,                                                                                                                                         -- DOD/COD/PCP/Attending
r.ReferralAttendingMD,                                                                                                                                      -- DOD/COD/PCP/Attending
ReferralAttendingMD               = (SELECT p.PersonFirst + RTRIM(' '+(ISNULL(p.PersonMI,''))) + ' ' + p.PersonLast
                                               FROM Person p
                                               WHERE p.PersonID = r.ReferralAttendingMD),
s.SecondaryMDAttendingPhone,                                                                                                                                 -- DOD/COD/PCP/Attending
 SecondaryCOD                             = (SELECT CASE s.SecondaryCOD
                                                       WHEN -1 THEN s.SecondaryCODOther
                                                       WHEN  0 THEN s.SecondaryCODOther
                                                       ELSE  (SELECT TOP 1 cod.FS_CauseOfDeathName 
                                                              FROM FS_CauseOfDeath cod
                                                              WHERE cod.FS_CauseOfDeathID = s.SecondaryCOD)
                                                     END),                                                                                                   -- DOD/COD/PCP/Attending
s.SecondaryCODSignatory,                                                                                                                                     -- DOD/COD/PCP/Attending
s.SecondaryTriageHX,                                                                                                                                         -- History
s.SecondaryCircumstanceOfDeath,                                                                                                                              -- History
s.SecondaryMedicalHistory,                                                                                                                                   -- History
s.SecondaryPhysicalAppearance,                                                                                                                               -- History
s.SecondaryHistorySubstanceAbuse,                                                                                                                            -- History
s.SecondarySubstanceAbuseDetail,                                                                                                                             -- History
r.ReferralDonorOnVentilator,										--History
s.SecondarySignOfInfection,                                                                                                                                  --History
s.SecondaryAdditionalComments,                                                                                                                                  --History
s.SecondaryAdmissionDiagnosis,                                                                                                                               -- Admit
  SecondaryAdmissionDate                    =  r.ReferralDonorAdmitDate,                                                                                     -- Admit
  SecondaryAdmissionTime                    =  r.ReferralDonorAdmitTime,                                                                                     -- Admit
s.SecondaryDNRDate,                                                                                                                                          -- Admit
s.SecondaryDeathWitnessed,                                                                                                                                   -- Admit
s.SecondaryDeathWitnessedBy,                                                                                                                                 -- Admit
SecondaryRhythm = (SELECT TOP 1 rm.RhythmName  FROM Rhythm rm WHERE rm.RhythmId = s.SecondaryRhythm),             	-- Admit
s.SecondaryLSADate,                                                                                                                                          -- Admit
s.SecondaryLSATime,                                                                                                                                          -- Admit
s.SecondaryEMSArrivalToPatientTime,                                                                                                                          -- Admit
s.SecondaryEMSArrivalToHospitalTime,                                                                                                                         -- Admit
s.SecondaryMedication,                                                                                                                                       -- Medications
s.SecondaryAntibiotic,                                                                                                                                       -- Antibiotics
s.SecondarySteroid,                                                                                                                                       -- Steroids
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
                                                       ELSE  (SELECT TOP 1 c.CultureName 
                                                              FROM Culture c 
                                                              WHERE c.CultureID = s2.SecondaryCulture1Type)
                                                     END),                                                                                                   -- Culture

s2.SecondaryCulture1DrawnDate,                                                                                                                               -- Culture
s2.SecondaryCulture1Growth,                                                                                                                                  -- Culture
   SecondaryCulture2Type                   = (SELECT CASE s2.SecondaryCulture2Type
                                                       WHEN -1 THEN s2.SecondaryCulture2Other
                                                       WHEN  0 THEN s2.SecondaryCulture2Other
                                                       ELSE  (SELECT TOP 1 c.CultureName 
                                                              FROM Culture c 
                                                              WHERE c.CultureID = s2.SecondaryCulture2Type)
                                                     END),                                                                                                   -- Culture

s2.SecondaryCulture2DrawnDate,                                                                                                                               -- Culture
s2.SecondaryCulture2Growth,                                                                                                                                  -- Culture
   SecondaryCulture3Type                   = (SELECT CASE s2.SecondaryCulture3Type
                                                       WHEN -1 THEN s2.SecondaryCulture3Other
                                                       WHEN  0 THEN s2.SecondaryCulture3Other
                                                       ELSE  (SELECT TOP 1 c.CultureName 
                                                              FROM Culture c 
                                                              WHERE c.CultureID = s2.SecondaryCulture3Type)
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
s.SecondaryAdditionalMedications,
r.ReferralNOKID,				-- cachaput 07/18/2006 check for NOKID on referral table if exists post 8.0 if not pre 8.0                   -- NOK
r.ReferralApproachNOK,				-- Referral NOK before 8.0										     -- NOK
r.ReferralApproachRelation,			-- Referral NOK before 8.0										     -- NOK
r.ReferralNOKPhone,				-- Referral NOK before 8.0										     -- NOK
r.ReferralNOKAddress,				-- Referral NOK before 8.0										     -- NOK
						-- ccarroll 07/06/2006 to select NOK information from new 8.0 table
  SecondaryNOKName                           =  (SELECT NOK.NOKFirstName + ' ' + NOK.NOKLastName
							FROM NOK
							WHERE r.ReferralNOKID = NOK.NOKID),
							-- ccarroll 07/06/2006 was r.ReferralApproachNOK,                                                                                       -- NOK

  SecondaryNOKPhone                          =  (SELECT NOK.NOKPhone
							FROM NOK
							WHERE r.ReferralNOKID = NOK.NOKID),
							-- ccarroll 07/06/2006 was r.ReferralNOKPhone,                                                                                          -- NOK
s.SecondaryNOKAltPhone,

  SecondaryNOKRelation                       =  (SELECT NOK.NOKApproachRelation
							FROM NOK
							WHERE r.ReferralNOKID = NOK.NOKID),
							-- ccarroll 07/06/2006 was r.ReferralApproachRelation,                                                                                  -- NOK
s.SecondaryNOKGender,                                                                                                                                        -- NOK
  SecondaryNOKAddress                        =  (SELECT r.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + St.StateAbbrv + ' ' + NOK.NOKZip
							FROM NOK
							JOIN State AS St ON NOK.NOKStateID = St.StateID
							WHERE r.ReferralNOKID = NOK.NOKID),
							-- ccarroll 07/06/2006 was r.ReferralNOKAddress,                                                                                        -- NOK
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

  FSCaseBillUnavailable                       =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillFamUnavailDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillFamUnavailUserID),

  FSCaseBillApproach                       =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillApproachDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillApproachUserID),

  FSCaseBillApproachCount             =  (SELECT CONVERT(VARCHAR(10),fsc.FSCaseBillApproachCount, 100)
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillApproachUserID),

  FSCaseBillMedSoc                         =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillMedSocDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillMedSocUserID),

  FSCaseBillMedSocCount                =  (SELECT CONVERT(VARCHAR(10),fsc.FSCaseBillMedSocCount, 100)
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillMedSocUserID),

  FSCaseBillCryolifeForm                    =  (SELECT CONVERT(VARCHAR(255),fsc.FSCaseBillCryoFormDateTime, 100) + '  ' + se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillCryoFormUserID),

  FSCaseBillCryolifeFormCount           =  (SELECT CONVERT(VARCHAR(10),fsc.FSCaseBillCryoFormCount, 100)
                                               FROM StatEmployee se
                                               WHERE se.StatEmployeeId = fsc.FSCaseBillCryoFormUserID)

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

