SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Secondary]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
	PRINT 'Dropping Procedure spu_Audit_Secondary'
	drop procedure [dbo].[spu_Audit_Secondary]
GO

	PRINT 'Creating Procedure spu_Audit_Secondary'
GO

create procedure "spu_Audit_Secondary" 
	@c1 int,
	@c2 varchar(25),
	@c3 smallint,
	@c4 smallint,
	@c5 smallint,
	@c6 smallint,
	@c7 varchar(10),
	@c8 varchar(10),
	@c9 varchar(25),
	@c10 varchar(10),
	@c11 varchar(25),
	@c12 varchar(2),
	@c13 varchar(2),
	@c14 varchar(10),
	@c15 varchar(10),
	@c16 varchar(10),
	@c17 smalldatetime,
	@c18 smalldatetime,
	@c19 varchar(255),
	@c20 varchar(1000),
	@c21 varchar(1000),
	@c22 varchar(100),
	@c23 int,
	@c24 varchar(50),
	@c25 varchar(10),
	@c26 varchar(25),
	@c27 smallint,
	@c28 smalldatetime,
	@c29 varchar(10),
	@c30 smalldatetime,
	@c31 varchar(10),
	@c32 smalldatetime,
	@c33 smallint,
	@c34 smalldatetime,
	@c35 varchar(10),
	@c36 smalldatetime,
	@c37 varchar(10),
	@c38 smallint,
	@c39 smallint,
	@c40 varchar(50),
	@c41 smalldatetime,
	@c42 varchar(10),
	@c43 varchar(25),
	@c44 smallint,
	@c45 varchar(10),
	@c46 varchar(10),
	@c47 varchar(25),
	@c48 varchar(25),
	@c49 varchar(10),
	@c50 smallint,
	@c51 varchar(25),
	@c52 smallint,
	@c53 smallint,
	@c54 smallint,
	@c55 smallint,
	@c56 smallint,
	@c57 varchar(50),
	@c58 varchar(14),
	@c59 varchar(50),
	@c60 varchar(14),
	@c61 varchar(1000),
	@c62 varchar(10),
	@c63 varchar(10),
	@c64 smallint,
	@c65 smallint,
	@c66 smallint,
	@c67 smallint,
	@c68 smallint,
	@c69 smalldatetime,
	@c70 varchar(10),
	@c71 varchar(10),
	@c72 varchar(25),
	@c73 smalldatetime,
	@c74 varchar(10),
	@c75 varchar(25),
	@c76 smallint,
	@c77 varchar(25),
	@c78 varchar(25),
	@c79 smalldatetime,
	@c80 varchar(10),
	@c81 varchar(255),
	@c82 varchar(14),
	@c83 smallint,
	@c84 varchar(25),
	@c85 varchar(14),
	@c86 smallint,
	@c87 varchar(25),
	@c88 varchar(25),
	@c89 varchar(25),
	@c90 varchar(25),
	@c91 varchar(255),
	@c92 smallint,
	@c93 smalldatetime,
	@c94 varchar(10),
	@c95 int,
	@c96 smallint,
	@c97 smallint,
	@c98 smallint,
	@c99 varchar(100),
	@c100 varchar(14),
	@c101 varchar(100),
	@c102 varchar(25),
	@c103 varchar(2),
	@c104 varchar(2),
	@c105 smallint,
	@c106 varchar(25),
	@c107 smalldatetime,
	@c108 varchar(10),
	@c109 varchar(25),
	@c110 varchar(25),
	@c111 varchar(25),
	@c112 varchar(50),
	@c113 varchar(25),
	@c114 varchar(25),
	@c115 varchar(25),
	@c116 varchar(25),
	@c117 varchar(25),
	@c118 varchar(255),
	@c119 smallint,
	@c120 varchar(255),
	@c121 smalldatetime,
	@c122 varchar(10),
	@c123 smallint,
	@c124 smallint,
	@c125 smallint,
	@c126 smallint,
	@c127 varchar(50),
	@c128 smalldatetime,
	@c129 varchar(10),
	@c130 varchar(50),
	@c131 varchar(200),
	@c132 varchar(100),
	@c133 varchar(14),
	@c134 smallint,
	@c135 int,
	@c136 varchar(10),
	@c137 int,
	@c138 varchar(255),
	@c139 int,
	@c140 varchar(150),
	@c141 smalldatetime,
	@c142 varchar(25),
	@c143 varchar(25),
	@c144 varchar(14),
	@c145 smallint,
	@c146 smallint,
	@c147 varchar(10),
	@c148 int,
	@c149 int,
	@c150 smalldatetime,
	@pkc1 int,
	@bitmap binary(19)
as

	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryWhoAreWe
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryNOKaware
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryFamilyConsent
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryFamilyInterested
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryNOKatHospital
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryEstTimeSinceLeft
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryTimeLeftInMT
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryNOKNextDest
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryNOKETA
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryPatientMiddleName
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryPatientHeightFeet
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryPatientHeightInches
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryPatientBMICalc
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryPatientTOD1
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryPatientTOD2
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryPatientDeathType1
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryPatientDeathType2
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryTriageHX
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- SecondaryCircumstanceOfDeath
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- SecondaryMedicalHistory
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- SecondaryAdmissionDiagnosis
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryCOD
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryCODSignatory
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- SecondaryCODTime
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- SecondaryCODSignedBy
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- SecondaryPatientVent
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- SecondaryIntubationDate
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- SecondaryIntubationTime
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- SecondaryBrainDeathDate
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- SecondaryBrainDeathTime
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- SecondaryDNRDate
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- SecondaryERORDeath
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- SecondaryEMSArrivalToPatientDate
		AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- SecondaryEMSArrivalToPatientTime
		AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- SecondaryEMSArrivalToHospitalDate
		AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- SecondaryEMSArrivalToHospitalTime
		AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- SecondaryPatientTerminal
		AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- SecondaryDeathWitnessed
		AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- SecondaryDeathWitnessedBy
		AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- SecondaryLSADate
		AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- SecondaryLSATime
		AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- SecondaryLSABy
		AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- SecondaryACLSProvided
		AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- SecondaryACLSProvidedTime
		AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- SecondaryGestationalAge
		AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- SecondaryParentName1
		AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- SecondaryParentName2
		AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- SecondaryBirthCBO
		AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- SecondaryActiveInfection
		AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- SecondaryActiveInfectionType
		AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- SecondaryFluidsGiven
		AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- SecondaryBloodLoss
		AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- SecondarySignOfInfection
		AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- SecondaryMedication
		AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- SecondaryAntibiotic
		AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- SecondaryPCPName
		AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- SecondaryPCPPhone
		AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- SecondaryMDAttending
		AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- SecondaryMDAttendingPhone
		AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- SecondaryPhysicalAppearance
		AND SUBSTRING(@bitmap, 8, 1) & 32 <> 32 -- SecondaryInternalBloodLossCC
		AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- SecondaryExternalBloodLossCC
		AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- SecondaryBloodProducts
		AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- SecondaryColloidsInfused
		AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- SecondaryCrystalloids
		AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- SecondaryPreTransfusionSampleRequired
		AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- SecondaryPreTransfusionSampleAvailable
		AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- SecondaryPreTransfusionSampleDrawnDate
		AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- SecondaryPreTransfusionSampleDrawnTime
		AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- SecondaryPreTransfusionSampleQuantity
		AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- SecondaryPreTransfusionSampleHeldAt
		AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- SecondaryPreTransfusionSampleHeldDate
		AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- SecondaryPreTransfusionSampleHeldTime
		AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- SecondaryPreTransfusionSampleHeldTechnician
		AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- SecondaryPostMordemSampleTestSuitable
		AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- SecondaryPostMordemSampleLocation
		AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- SecondaryPostMordemSampleContact
		AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- SecondaryPostMordemSampleCollectionDate
		AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- SecondaryPostMordemSampleCollectionTime
		AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- SecondarySputumCharacteristics
		AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- SecondaryNOKAltPhone
		AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- SecondaryNOKLegal
		AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- SecondaryNOKAltContact
		AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- SecondaryNOKAltContactPhone
		AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- SecondaryNOKPostMortemAuthorization
		AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- SecondaryNOKPostMortemAuthorizationReminder
		AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- SecondaryCoronerCaseNumber
		AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- SecondaryCoronerCounty
		AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- SecondaryCoronerReleased
		AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- SecondaryCoronerReleasedStipulations
		AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- SecondaryAutopsy
		AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- SecondaryAutopsyDate
		AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- SecondaryAutopsyTime
		AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- SecondaryAutopsyLocation
		AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- SecondaryAutopsyBloodRequested
		AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- SecondaryAutopsyCopyRequested
		AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- SecondaryFuneralHomeSelected
		AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- SecondaryFuneralHomeName
		AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- SecondaryFuneralHomePhone
		AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- SecondaryFuneralHomeAddress
		AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- SecondaryFuneralHomeContact
		AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- SecondaryFuneralHomeNotified
		AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- SecondaryFuneralHomeMorgueCooled
		AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- SecondaryHoldOnBody
		AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- SecondaryHoldOnBodyTag
		AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- SecondaryBodyRefrigerationDate
		AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- SecondaryBodyRefrigerationTime
		AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- SecondaryBodyLocation
		AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- SecondaryBodyMedicalChartLocation
		AND SUBSTRING(@bitmap, 14, 1) & 64 <> 64 -- SecondaryBodyIDTagLocation
		AND SUBSTRING(@bitmap, 14, 1) & 128 <> 128 -- SecondaryBodyCoolingMethod
		AND SUBSTRING(@bitmap, 15, 1) & 1 <> 1 -- SecondaryUNOSNumber
		AND SUBSTRING(@bitmap, 15, 1) & 2 <> 2 -- SecondaryClientNumber
		AND SUBSTRING(@bitmap, 15, 1) & 4 <> 4 -- SecondaryCryolifeNumber
		AND SUBSTRING(@bitmap, 15, 1) & 8 <> 8 -- SecondaryMTFNumber
		AND SUBSTRING(@bitmap, 15, 1) & 16 <> 16 -- SecondaryLifeNetNumber
		AND SUBSTRING(@bitmap, 15, 1) & 32 <> 32 -- SecondaryFreeText
		AND SUBSTRING(@bitmap, 15, 1) & 64 <> 64 -- SecondaryHistorySubstanceAbuse
		AND SUBSTRING(@bitmap, 15, 1) & 128 <> 128 -- SecondarySubstanceAbuseDetail
		AND SUBSTRING(@bitmap, 16, 1) & 1 <> 1 -- SecondaryExtubationDate
		AND SUBSTRING(@bitmap, 16, 1) & 2 <> 2 -- SecondaryExtubationTime
		AND SUBSTRING(@bitmap, 16, 1) & 4 <> 4 -- SecondaryAutopsyReminderYN
		AND SUBSTRING(@bitmap, 16, 1) & 8 <> 8 -- SecondaryFHReminderYN
		AND SUBSTRING(@bitmap, 16, 1) & 16 <> 16 -- SecondaryBodyCareReminderYN
		AND SUBSTRING(@bitmap, 16, 1) & 32 <> 32 -- SecondaryWrapUpReminderYN
		AND SUBSTRING(@bitmap, 16, 1) & 64 <> 64 -- SecondaryNOKNotifiedBy
		AND SUBSTRING(@bitmap, 16, 1) & 128 <> 128 -- SecondaryNOKNotifiedDate
		AND SUBSTRING(@bitmap, 17, 1) & 1 <> 1 -- SecondaryNOKNotifiedTime
		AND SUBSTRING(@bitmap, 17, 1) & 2 <> 2 -- SecondaryNOKGender
		AND SUBSTRING(@bitmap, 17, 1) & 4 <> 4 -- SecondaryCODOther
		AND SUBSTRING(@bitmap, 17, 1) & 8 <> 8 -- SecondaryAutopsyLocationOther
		AND SUBSTRING(@bitmap, 17, 1) & 16 <> 16 -- SecondaryPatientHospitalPhone
		AND SUBSTRING(@bitmap, 17, 1) & 32 <> 32 -- SecondaryCoronerCase
		AND SUBSTRING(@bitmap, 17, 1) & 64 <> 64 -- SecondaryPatientABO
		AND SUBSTRING(@bitmap, 17, 1) & 128 <> 128 -- SecondaryPatientSuffix
		AND SUBSTRING(@bitmap, 18, 1) & 1 <> 1 -- SecondaryMDAttendingId
		AND SUBSTRING(@bitmap, 18, 1) & 2 <> 2 -- SecondaryAdditionalComments
		AND SUBSTRING(@bitmap, 18, 1) & 4 <> 4 -- SecondaryRhythm
		AND SUBSTRING(@bitmap, 18, 1) & 8 <> 8 -- SecondaryAdditionalMedications
		AND SUBSTRING(@bitmap, 18, 1) & 16 <> 16 -- SecondaryBodyHoldPlaced
		AND SUBSTRING(@bitmap, 18, 1) & 32 <> 32 -- SecondaryBodyHoldPlacedWith
		AND SUBSTRING(@bitmap, 18, 1) & 64 <> 64 -- SecondaryBodyFutureContact
		AND SUBSTRING(@bitmap, 18, 1) & 128 <> 128 -- SecondaryBodyHoldPhone
		AND SUBSTRING(@bitmap, 19, 1) & 1 <> 1 -- SecondaryBodyHoldInstructionsGiven
		AND SUBSTRING(@bitmap, 19, 1) & 2 <> 2 -- SecondarySteroid
		AND SUBSTRING(@bitmap, 19, 1) & 4 <> 4 -- SecondaryBodyHoldPlacedTime
		AND SUBSTRING(@bitmap, 19, 1) & 8 <> 8 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 19, 1) & 16 <> 16 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 19, 1) & 32 = 32 -- LastModified

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c149, AuditLogTypeID)
	FROM
		Secondary
	WHERE 
		CallID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryWhoAreWe
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryNOKaware
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryFamilyConsent
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryFamilyInterested
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryNOKatHospital
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryEstTimeSinceLeft
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryTimeLeftInMT
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryNOKNextDest
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryNOKETA
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryPatientMiddleName
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryPatientHeightFeet
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryPatientHeightInches
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryPatientBMICalc
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryPatientTOD1
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryPatientTOD2
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryPatientDeathType1
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryPatientDeathType2
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryTriageHX
	AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- SecondaryCircumstanceOfDeath
	AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- SecondaryMedicalHistory
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- SecondaryAdmissionDiagnosis
	AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryCOD
	AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryCODSignatory
	AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- SecondaryCODTime
	AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- SecondaryCODSignedBy
	AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- SecondaryPatientVent
	AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- SecondaryIntubationDate
	AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- SecondaryIntubationTime
	AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- SecondaryBrainDeathDate
	AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- SecondaryBrainDeathTime
	AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- SecondaryDNRDate
	AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- SecondaryERORDeath
	AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- SecondaryEMSArrivalToPatientDate
	AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- SecondaryEMSArrivalToPatientTime
	AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- SecondaryEMSArrivalToHospitalDate
	AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- SecondaryEMSArrivalToHospitalTime
	AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- SecondaryPatientTerminal
	AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- SecondaryDeathWitnessed
	AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- SecondaryDeathWitnessedBy
	AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- SecondaryLSADate
	AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- SecondaryLSATime
	AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- SecondaryLSABy
	AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- SecondaryACLSProvided
	AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- SecondaryACLSProvidedTime
	AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- SecondaryGestationalAge
	AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- SecondaryParentName1
	AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- SecondaryParentName2
	AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- SecondaryBirthCBO
	AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- SecondaryActiveInfection
	AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- SecondaryActiveInfectionType
	AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- SecondaryFluidsGiven
	AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- SecondaryBloodLoss
	AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- SecondarySignOfInfection
	AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- SecondaryMedication
	AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- SecondaryAntibiotic
	AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- SecondaryPCPName
	AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- SecondaryPCPPhone
	AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- SecondaryMDAttending
	AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- SecondaryMDAttendingPhone
	AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- SecondaryPhysicalAppearance
	AND SUBSTRING(@bitmap, 8, 1) & 32 <> 32 -- SecondaryInternalBloodLossCC
	AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- SecondaryExternalBloodLossCC
	AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- SecondaryBloodProducts
	AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- SecondaryColloidsInfused
	AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- SecondaryCrystalloids
	AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- SecondaryPreTransfusionSampleRequired
	AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- SecondaryPreTransfusionSampleAvailable
	AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- SecondaryPreTransfusionSampleDrawnDate
	AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- SecondaryPreTransfusionSampleDrawnTime
	AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- SecondaryPreTransfusionSampleQuantity
	AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- SecondaryPreTransfusionSampleHeldAt
	AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- SecondaryPreTransfusionSampleHeldDate
	AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- SecondaryPreTransfusionSampleHeldTime
	AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- SecondaryPreTransfusionSampleHeldTechnician
	AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- SecondaryPostMordemSampleTestSuitable
	AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- SecondaryPostMordemSampleLocation
	AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- SecondaryPostMordemSampleContact
	AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- SecondaryPostMordemSampleCollectionDate
	AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- SecondaryPostMordemSampleCollectionTime
	AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- SecondarySputumCharacteristics
	AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- SecondaryNOKAltPhone
	AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- SecondaryNOKLegal
	AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- SecondaryNOKAltContact
	AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- SecondaryNOKAltContactPhone
	AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- SecondaryNOKPostMortemAuthorization
	AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- SecondaryNOKPostMortemAuthorizationReminder
	AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- SecondaryCoronerCaseNumber
	AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- SecondaryCoronerCounty
	AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- SecondaryCoronerReleased
	AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- SecondaryCoronerReleasedStipulations
	AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- SecondaryAutopsy
	AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- SecondaryAutopsyDate
	AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- SecondaryAutopsyTime
	AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- SecondaryAutopsyLocation
	AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- SecondaryAutopsyBloodRequested
	AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- SecondaryAutopsyCopyRequested
	AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- SecondaryFuneralHomeSelected
	AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- SecondaryFuneralHomeName
	AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- SecondaryFuneralHomePhone
	AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- SecondaryFuneralHomeAddress
	AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- SecondaryFuneralHomeContact
	AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- SecondaryFuneralHomeNotified
	AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- SecondaryFuneralHomeMorgueCooled
	AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- SecondaryHoldOnBody
	AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- SecondaryHoldOnBodyTag
	AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- SecondaryBodyRefrigerationDate
	AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- SecondaryBodyRefrigerationTime
	AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- SecondaryBodyLocation
	AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- SecondaryBodyMedicalChartLocation
	AND SUBSTRING(@bitmap, 14, 1) & 64 <> 64 -- SecondaryBodyIDTagLocation
	AND SUBSTRING(@bitmap, 14, 1) & 128 <> 128 -- SecondaryBodyCoolingMethod
	AND SUBSTRING(@bitmap, 15, 1) & 1 <> 1 -- SecondaryUNOSNumber
	AND SUBSTRING(@bitmap, 15, 1) & 2 <> 2 -- SecondaryClientNumber
	AND SUBSTRING(@bitmap, 15, 1) & 4 <> 4 -- SecondaryCryolifeNumber
	AND SUBSTRING(@bitmap, 15, 1) & 8 <> 8 -- SecondaryMTFNumber
	AND SUBSTRING(@bitmap, 15, 1) & 16 <> 16 -- SecondaryLifeNetNumber
	AND SUBSTRING(@bitmap, 15, 1) & 32 <> 32 -- SecondaryFreeText
	AND SUBSTRING(@bitmap, 15, 1) & 64 <> 64 -- SecondaryHistorySubstanceAbuse
	AND SUBSTRING(@bitmap, 15, 1) & 128 <> 128 -- SecondarySubstanceAbuseDetail
	AND SUBSTRING(@bitmap, 16, 1) & 1 <> 1 -- SecondaryExtubationDate
	AND SUBSTRING(@bitmap, 16, 1) & 2 <> 2 -- SecondaryExtubationTime
	AND SUBSTRING(@bitmap, 16, 1) & 4 <> 4 -- SecondaryAutopsyReminderYN
	AND SUBSTRING(@bitmap, 16, 1) & 8 <> 8 -- SecondaryFHReminderYN
	AND SUBSTRING(@bitmap, 16, 1) & 16 <> 16 -- SecondaryBodyCareReminderYN
	AND SUBSTRING(@bitmap, 16, 1) & 32 <> 32 -- SecondaryWrapUpReminderYN
	AND SUBSTRING(@bitmap, 16, 1) & 64 <> 64 -- SecondaryNOKNotifiedBy
	AND SUBSTRING(@bitmap, 16, 1) & 128 <> 128 -- SecondaryNOKNotifiedDate
	AND SUBSTRING(@bitmap, 17, 1) & 1 <> 1 -- SecondaryNOKNotifiedTime
	AND SUBSTRING(@bitmap, 17, 1) & 2 <> 2 -- SecondaryNOKGender
	AND SUBSTRING(@bitmap, 17, 1) & 4 <> 4 -- SecondaryCODOther
	AND SUBSTRING(@bitmap, 17, 1) & 8 <> 8 -- SecondaryAutopsyLocationOther
	AND SUBSTRING(@bitmap, 17, 1) & 16 <> 16 -- SecondaryPatientHospitalPhone
	AND SUBSTRING(@bitmap, 17, 1) & 32 <> 32 -- SecondaryCoronerCase
	AND SUBSTRING(@bitmap, 17, 1) & 64 <> 64 -- SecondaryPatientABO
	AND SUBSTRING(@bitmap, 17, 1) & 128 <> 128 -- SecondaryPatientSuffix
	AND SUBSTRING(@bitmap, 18, 1) & 1 <> 1 -- SecondaryMDAttendingId
	AND SUBSTRING(@bitmap, 18, 1) & 2 <> 2 -- SecondaryAdditionalComments
	AND SUBSTRING(@bitmap, 18, 1) & 4 <> 4 -- SecondaryRhythm
	AND SUBSTRING(@bitmap, 18, 1) & 8 <> 8 -- SecondaryAdditionalMedications
	AND SUBSTRING(@bitmap, 18, 1) & 16 <> 16 -- SecondaryBodyHoldPlaced
	AND SUBSTRING(@bitmap, 18, 1) & 32 <> 32 -- SecondaryBodyHoldPlacedWith
	AND SUBSTRING(@bitmap, 18, 1) & 64 <> 64 -- SecondaryBodyFutureContact
	AND SUBSTRING(@bitmap, 18, 1) & 128 <> 128 -- SecondaryBodyHoldPhone
	AND SUBSTRING(@bitmap, 19, 1) & 1 <> 1 -- SecondaryBodyHoldInstructionsGiven
	AND SUBSTRING(@bitmap, 19, 1) & 2 <> 2 -- SecondarySteroid
	AND SUBSTRING(@bitmap, 19, 1) & 4 <> 4 -- SecondaryBodyHoldPlacedTime
	--AND SUBSTRING(@bitmap, 19, 1) & 8 <> 8 -- LastStatEmployeeID
	--AND SUBSTRING(@bitmap, 19, 1) & 16 <> 16 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 19, 1) & 32 = 32 -- LastModified
	AND @auditLogTypeID = 3	
	
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"Secondary"
	( 
		CallID,  --c1
		SecondaryWhoAreWe,  --c2
		SecondaryNOKaware,  --c3
		SecondaryFamilyConsent,  --c4
		SecondaryFamilyInterested,  --c5
		SecondaryNOKatHospital,  --c6
		SecondaryEstTimeSinceLeft,  --c7
		SecondaryTimeLeftInMT,  --c8
		SecondaryNOKNextDest,  --c9
		SecondaryNOKETA,  --c10
		SecondaryPatientMiddleName,  --c11
		SecondaryPatientHeightFeet,  --c12
		SecondaryPatientHeightInches,  --c13
		SecondaryPatientBMICalc,  --c14
		SecondaryPatientTOD1,  --c15
		SecondaryPatientTOD2,  --c16
		SecondaryPatientDeathType1,  --c17
		SecondaryPatientDeathType2,  --c18
		SecondaryTriageHX,  --c19
		SecondaryCircumstanceOfDeath,  --c20
		SecondaryMedicalHistory,  --c21
		SecondaryAdmissionDiagnosis,  --c22
		SecondaryCOD,  --c23
		SecondaryCODSignatory,  --c24
		SecondaryCODTime,  --c25
		SecondaryCODSignedBy,  --c26
		SecondaryPatientVent,  --c27
		SecondaryIntubationDate,  --c28
		SecondaryIntubationTime,  --c29
		SecondaryBrainDeathDate,  --c30
		SecondaryBrainDeathTime,  --c31
		SecondaryDNRDate,  --c32
		SecondaryERORDeath,  --c33
		SecondaryEMSArrivalToPatientDate,  --c34
		SecondaryEMSArrivalToPatientTime,  --c35
		SecondaryEMSArrivalToHospitalDate,  --c36
		SecondaryEMSArrivalToHospitalTime,  --c37
		SecondaryPatientTerminal,  --c38
		SecondaryDeathWitnessed,  --c39
		SecondaryDeathWitnessedBy,  --c40
		SecondaryLSADate,  --c41
		SecondaryLSATime,  --c42
		SecondaryLSABy,  --c43
		SecondaryACLSProvided,  --c44
		SecondaryACLSProvidedTime,  --c45
		SecondaryGestationalAge,  --c46
		SecondaryParentName1,  --c47
		SecondaryParentName2,  --c48
		SecondaryBirthCBO,  --c49
		SecondaryActiveInfection,  --c50
		SecondaryActiveInfectionType,  --c51
		SecondaryFluidsGiven,  --c52
		SecondaryBloodLoss,  --c53
		SecondarySignOfInfection,  --c54
		SecondaryMedication,  --c55
		SecondaryAntibiotic,  --c56
		SecondaryPCPName,  --c57
		SecondaryPCPPhone,  --c58
		SecondaryMDAttending,  --c59
		SecondaryMDAttendingPhone,  --c60
		SecondaryPhysicalAppearance,  --c61
		SecondaryInternalBloodLossCC,  --c62
		SecondaryExternalBloodLossCC,  --c63
		SecondaryBloodProducts,  --c64
		SecondaryColloidsInfused,  --c65
		SecondaryCrystalloids,  --c66
		SecondaryPreTransfusionSampleRequired,  --c67
		SecondaryPreTransfusionSampleAvailable,  --c68
		SecondaryPreTransfusionSampleDrawnDate,  --c69
		SecondaryPreTransfusionSampleDrawnTime,  --c70
		SecondaryPreTransfusionSampleQuantity,  --c71
		SecondaryPreTransfusionSampleHeldAt,  --c72
		SecondaryPreTransfusionSampleHeldDate,  --c73
		SecondaryPreTransfusionSampleHeldTime,  --c74
		SecondaryPreTransfusionSampleHeldTechnician,  --c75
		SecondaryPostMordemSampleTestSuitable,  --c76
		SecondaryPostMordemSampleLocation,  --c77
		SecondaryPostMordemSampleContact,  --c78
		SecondaryPostMordemSampleCollectionDate,  --c79
		SecondaryPostMordemSampleCollectionTime,  --c80
		SecondarySputumCharacteristics,  --c81
		SecondaryNOKAltPhone,  --c82
		SecondaryNOKLegal,  --c83
		SecondaryNOKAltContact,  --c84
		SecondaryNOKAltContactPhone,  --c85
		SecondaryNOKPostMortemAuthorization,  --c86
		SecondaryNOKPostMortemAuthorizationReminder,  --c87
		SecondaryCoronerCaseNumber,  --c88
		SecondaryCoronerCounty,  --c89
		SecondaryCoronerReleased,  --c90
		SecondaryCoronerReleasedStipulations,  --c91
		SecondaryAutopsy,  --c92
		SecondaryAutopsyDate,  --c93
		SecondaryAutopsyTime,  --c94
		SecondaryAutopsyLocation,  --c95
		SecondaryAutopsyBloodRequested,  --c96
		SecondaryAutopsyCopyRequested,  --c97
		SecondaryFuneralHomeSelected,  --c98
		SecondaryFuneralHomeName,  --c99
		SecondaryFuneralHomePhone,  --c100
		SecondaryFuneralHomeAddress,  --c101
		SecondaryFuneralHomeContact,  --c102
		SecondaryFuneralHomeNotified,  --c103
		SecondaryFuneralHomeMorgueCooled,  --c104
		SecondaryHoldOnBody,  --c105
		SecondaryHoldOnBodyTag,  --c106
		SecondaryBodyRefrigerationDate,  --c107
		SecondaryBodyRefrigerationTime,  --c108
		SecondaryBodyLocation,  --c109
		SecondaryBodyMedicalChartLocation,  --c110
		SecondaryBodyIDTagLocation,  --c111
		SecondaryBodyCoolingMethod,  --c112
		SecondaryUNOSNumber,  --c113
		SecondaryClientNumber,  --c114
		SecondaryCryolifeNumber,  --c115
		SecondaryMTFNumber,  --c116
		SecondaryLifeNetNumber,  --c117
		SecondaryFreeText,  --c118
		SecondaryHistorySubstanceAbuse,  --c119
		SecondarySubstanceAbuseDetail,  --c120
		SecondaryExtubationDate,  --c121
		SecondaryExtubationTime,  --c122
		SecondaryAutopsyReminderYN,  --c123
		SecondaryFHReminderYN,  --c124
		SecondaryBodyCareReminderYN,  --c125
		SecondaryWrapUpReminderYN,  --c126
		SecondaryNOKNotifiedBy,  --c127
		SecondaryNOKNotifiedDate,  --c128
		SecondaryNOKNotifiedTime,  --c129
		SecondaryNOKGender,  --c130
		SecondaryCODOther,  --c131
		SecondaryAutopsyLocationOther,  --c132
		SecondaryPatientHospitalPhone,  --c133
		SecondaryCoronerCase,  --c134
		SecondaryPatientABO,  --c135
		SecondaryPatientSuffix,  --c136
		SecondaryMDAttendingId,  --c137
		SecondaryAdditionalComments,  --c138
		SecondaryRhythm,  --c139
		SecondaryAdditionalMedications,  --c140
		SecondaryBodyHoldPlaced,  --c141
		SecondaryBodyHoldPlacedWith,  --c142
		SecondaryBodyFutureContact,  --c143
		SecondaryBodyHoldPhone,  --c144
		SecondaryBodyHoldInstructionsGiven,  --c145
		SecondarySteroid,  --c146
		SecondaryBodyHoldPlacedTime,  --c147
		LastStatEmployeeID,  --c148
		AuditLogTypeID,  --c149
		LastModified  --c150

	)

values 
	( 
		@pkc1,
		CASE WHEN /*SecondaryWhoAreWe*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, '') = '' THEN 'ILB' ELSE @c2 END,
		CASE WHEN /*SecondaryNOKaware*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 THEN IsNull(@c3, 0) END,
		CASE WHEN /*SecondaryFamilyConsent*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, -1) IN ( -1, 0) THEN -2 ELSE @c4 END,
		CASE WHEN /*SecondaryFamilyInterested*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, -1) IN ( -1, 0) THEN -2 ELSE @c5 END,
		CASE WHEN /*SecondaryNOKatHospital*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*SecondaryEstTimeSinceLeft*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
		CASE WHEN /*SecondaryTimeLeftInMT*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN 'ILB' ELSE @c8 END,
		CASE WHEN /*SecondaryNOKNextDest*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN 'ILB' ELSE @c9 END,
		CASE WHEN /*SecondaryNOKETA*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, '') = '' THEN 'ILB' ELSE @c10 END,
		CASE WHEN /*SecondaryPatientMiddleName*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, '') = '' THEN 'ILB' ELSE @c11 END,
		CASE WHEN /*SecondaryPatientHeightFeet*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN 'ILB' ELSE @c12 END,
		CASE WHEN /*SecondaryPatientHeightInches*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, '') = '' THEN 'ILB' ELSE @c13 END,
		CASE WHEN /*SecondaryPatientBMICalc*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, '') = '' THEN 'ILB' ELSE @c14 END,
		CASE WHEN /*SecondaryPatientTOD1*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN 'ILB' ELSE @c15 END,
		CASE WHEN /*SecondaryPatientTOD2*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, '') = '' THEN 'ILB' ELSE @c16 END,
		CASE WHEN /*SecondaryPatientDeathType1*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, '') = '' THEN '01/01/1900' ELSE @c17 END,
		CASE WHEN /*SecondaryPatientDeathType2*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c18, '') = '' THEN '01/01/1900' ELSE @c18 END,
		CASE WHEN /*SecondaryTriageHX*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, '') = '' THEN 'ILB' ELSE @c19 END,
		CASE WHEN /*SecondaryCircumstanceOfDeath*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@c20, '') = '' THEN 'ILB' ELSE @c20 END,
		CASE WHEN /*SecondaryMedicalHistory*/ SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@c21, '') = '' THEN 'ILB' ELSE @c21 END,
		CASE WHEN /*SecondaryAdmissionDiagnosis*/ SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@c22, '') = '' THEN 'ILB' ELSE @c22 END,
		CASE WHEN /*SecondaryCOD*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, -1) IN ( -1, 0) THEN -2 ELSE @c23 END,
		CASE WHEN /*SecondaryCODSignatory*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, '') = '' THEN 'ILB' ELSE @c24 END,
		CASE WHEN /*SecondaryCODTime*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@c25, '') = '' THEN 'ILB' ELSE @c25 END,
		CASE WHEN /*SecondaryCODSignedBy*/ SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@c26, '') = '' THEN 'ILB' ELSE @c26 END,
		CASE WHEN /*SecondaryPatientVent*/ SUBSTRING(@bitmap, 4, 1) & 4 = 4 THEN IsNull(@c27, 0) END,
		CASE WHEN /*SecondaryIntubationDate*/ SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@c28, '') = '' THEN '01/01/1900' ELSE @c28 END,
		CASE WHEN /*SecondaryIntubationTime*/ SUBSTRING(@bitmap, 4, 1) & 16 = 16 AND IsNull(@c29, '') = '' THEN 'ILB' ELSE @c29 END,
		CASE WHEN /*SecondaryBrainDeathDate*/ SUBSTRING(@bitmap, 4, 1) & 32 = 32 AND IsNull(@c30, '') = '' THEN '01/01/1900' ELSE @c30 END,
		CASE WHEN /*SecondaryBrainDeathTime*/ SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@c31, '') = '' THEN 'ILB' ELSE @c31 END,
		CASE WHEN /*SecondaryDNRDate*/ SUBSTRING(@bitmap, 4, 1) & 128 = 128 AND IsNull(@c32, '') = '' THEN '01/01/1900' ELSE @c32 END,
		CASE WHEN /*SecondaryERORDeath*/ SUBSTRING(@bitmap, 5, 1) & 1 = 1 AND IsNull(@c33, -1) IN ( -1, 0) THEN -2 ELSE @c33 END,
		CASE WHEN /*SecondaryEMSArrivalToPatientDate*/ SUBSTRING(@bitmap, 5, 1) & 2 = 2 AND IsNull(@c34, '') = '' THEN '01/01/1900' ELSE @c34 END,
		CASE WHEN /*SecondaryEMSArrivalToPatientTime*/ SUBSTRING(@bitmap, 5, 1) & 4 = 4 AND IsNull(@c35, '') = '' THEN 'ILB' ELSE @c35 END,
		CASE WHEN /*SecondaryEMSArrivalToHospitalDate*/ SUBSTRING(@bitmap, 5, 1) & 8 = 8 AND IsNull(@c36, '') = '' THEN '01/01/1900' ELSE @c36 END,
		CASE WHEN /*SecondaryEMSArrivalToHospitalTime*/ SUBSTRING(@bitmap, 5, 1) & 16 = 16 AND IsNull(@c37, '') = '' THEN 'ILB' ELSE @c37 END,
		CASE WHEN /*SecondaryPatientTerminal*/ SUBSTRING(@bitmap, 5, 1) & 32 = 32 AND IsNull(@c38, -1) IN ( -1, 0) THEN -2 ELSE @c38 END,
		CASE WHEN /*SecondaryDeathWitnessed*/ SUBSTRING(@bitmap, 5, 1) & 64 = 64 AND IsNull(@c39, -1) IN ( -1, 0) THEN -2 ELSE @c39 END,
		CASE WHEN /*SecondaryDeathWitnessedBy*/ SUBSTRING(@bitmap, 5, 1) & 128 = 128 AND IsNull(@c40, '') = '' THEN 'ILB' ELSE @c40 END,
		CASE WHEN /*SecondaryLSADate*/ SUBSTRING(@bitmap, 6, 1) & 1 = 1 AND IsNull(@c41, '') = '' THEN '01/01/1900' ELSE @c41 END,
		CASE WHEN /*SecondaryLSATime*/ SUBSTRING(@bitmap, 6, 1) & 2 = 2 AND IsNull(@c42, '') = '' THEN 'ILB' ELSE @c42 END,
		CASE WHEN /*SecondaryLSABy*/ SUBSTRING(@bitmap, 6, 1) & 4 = 4 AND IsNull(@c43, '') = '' THEN 'ILB' ELSE @c43 END,
		CASE WHEN /*SecondaryACLSProvided*/ SUBSTRING(@bitmap, 6, 1) & 8 = 8 AND IsNull(@c44, -1) IN ( -1, 0) THEN -2 ELSE @c44 END,
		CASE WHEN /*SecondaryACLSProvidedTime*/ SUBSTRING(@bitmap, 6, 1) & 16 = 16 AND IsNull(@c45, '') = '' THEN 'ILB' ELSE @c45 END,
		CASE WHEN /*SecondaryGestationalAge*/ SUBSTRING(@bitmap, 6, 1) & 32 = 32 AND IsNull(@c46, '') = '' THEN 'ILB' ELSE @c46 END,
		CASE WHEN /*SecondaryParentName1*/ SUBSTRING(@bitmap, 6, 1) & 64 = 64 AND IsNull(@c47, '') = '' THEN 'ILB' ELSE @c47 END,
		CASE WHEN /*SecondaryParentName2*/ SUBSTRING(@bitmap, 6, 1) & 128 = 128 AND IsNull(@c48, '') = '' THEN 'ILB' ELSE @c48 END,
		CASE WHEN /*SecondaryBirthCBO*/ SUBSTRING(@bitmap, 7, 1) & 1 = 1 AND IsNull(@c49, '') = '' THEN 'ILB' ELSE @c49 END,
		CASE WHEN /*SecondaryActiveInfection*/ SUBSTRING(@bitmap, 7, 1) & 2 = 2 AND IsNull(@c50, -1) IN ( -1, 0) THEN -2 ELSE @c50 END,
		CASE WHEN /*SecondaryActiveInfectionType*/ SUBSTRING(@bitmap, 7, 1) & 4 = 4 AND IsNull(@c51, '') = '' THEN 'ILB' ELSE @c51 END,
		CASE WHEN /*SecondaryFluidsGiven*/ SUBSTRING(@bitmap, 7, 1) & 8 = 8 AND IsNull(@c52, -1) IN ( -1, 0) THEN -2 ELSE @c52 END,
		CASE WHEN /*SecondaryBloodLoss*/ SUBSTRING(@bitmap, 7, 1) & 16 = 16 AND IsNull(@c53, -1) IN ( -1, 0) THEN -2 ELSE @c53 END,
		CASE WHEN /*SecondarySignOfInfection*/ SUBSTRING(@bitmap, 7, 1) & 32 = 32 AND IsNull(@c54, -1) IN ( -1, 0) THEN -2 ELSE @c54 END,
		CASE WHEN /*SecondaryMedication*/ SUBSTRING(@bitmap, 7, 1) & 64 = 64 AND IsNull(@c55, -1) IN ( -1, 0) THEN -2 ELSE @c55 END,
		CASE WHEN /*SecondaryAntibiotic*/ SUBSTRING(@bitmap, 7, 1) & 128 = 128 AND IsNull(@c56, -1) IN ( -1, 0) THEN -2 ELSE @c56 END,
		CASE WHEN /*SecondaryPCPName*/ SUBSTRING(@bitmap, 8, 1) & 1 = 1 AND IsNull(@c57, '') = '' THEN 'ILB' ELSE @c57 END,
		CASE WHEN /*SecondaryPCPPhone*/ SUBSTRING(@bitmap, 8, 1) & 2 = 2 AND IsNull(@c58, '') = '' THEN 'ILB' ELSE @c58 END,
		CASE WHEN /*SecondaryMDAttending*/ SUBSTRING(@bitmap, 8, 1) & 4 = 4 AND IsNull(@c59, '') = '' THEN 'ILB' ELSE @c59 END,
		CASE WHEN /*SecondaryMDAttendingPhone*/ SUBSTRING(@bitmap, 8, 1) & 8 = 8 AND IsNull(@c60, '') = '' THEN 'ILB' ELSE @c60 END,
		CASE WHEN /*SecondaryPhysicalAppearance*/ SUBSTRING(@bitmap, 8, 1) & 16 = 16 AND IsNull(@c61, '') = '' THEN 'ILB' ELSE @c61 END,
		CASE WHEN /*SecondaryInternalBloodLossCC*/ SUBSTRING(@bitmap, 8, 1) & 32 = 32 AND IsNull(@c62, '') = '' THEN 'ILB' ELSE @c62 END,
		CASE WHEN /*SecondaryExternalBloodLossCC*/ SUBSTRING(@bitmap, 8, 1) & 64 = 64 AND IsNull(@c63, '') = '' THEN 'ILB' ELSE @c63 END,
		CASE WHEN /*SecondaryBloodProducts*/ SUBSTRING(@bitmap, 8, 1) & 128 = 128 AND IsNull(@c64, -1) IN ( -1, 0) THEN -2 ELSE @c64 END,
		CASE WHEN /*SecondaryColloidsInfused*/ SUBSTRING(@bitmap, 9, 1) & 1 = 1 AND IsNull(@c65, -1) IN ( -1, 0) THEN -2 ELSE @c65 END,
		CASE WHEN /*SecondaryCrystalloids*/ SUBSTRING(@bitmap, 9, 1) & 2 = 2 AND IsNull(@c66, -1) IN ( -1, 0) THEN -2 ELSE @c66 END,
		CASE WHEN /*SecondaryPreTransfusionSampleRequired*/ SUBSTRING(@bitmap, 9, 1) & 4 = 4 AND IsNull(@c67, -1) IN ( -1, 0) THEN -2 ELSE @c67 END,
		CASE WHEN /*SecondaryPreTransfusionSampleAvailable*/ SUBSTRING(@bitmap, 9, 1) & 8 = 8 AND IsNull(@c68, -1) IN ( -1, 0) THEN -2 ELSE @c68 END,
		CASE WHEN /*SecondaryPreTransfusionSampleDrawnDate*/ SUBSTRING(@bitmap, 9, 1) & 16 = 16 AND IsNull(@c69, '') = '' THEN '01/01/1900' ELSE @c69 END,
		CASE WHEN /*SecondaryPreTransfusionSampleDrawnTime*/ SUBSTRING(@bitmap, 9, 1) & 32 = 32 AND IsNull(@c70, '') = '' THEN 'ILB' ELSE @c70 END,
		CASE WHEN /*SecondaryPreTransfusionSampleQuantity*/ SUBSTRING(@bitmap, 9, 1) & 64 = 64 AND IsNull(@c71, '') = '' THEN 'ILB' ELSE @c71 END,
		CASE WHEN /*SecondaryPreTransfusionSampleHeldAt*/ SUBSTRING(@bitmap, 9, 1) & 128 = 128 AND IsNull(@c72, '') = '' THEN 'ILB' ELSE @c72 END,
		CASE WHEN /*SecondaryPreTransfusionSampleHeldDate*/ SUBSTRING(@bitmap, 10, 1) & 1 = 1 AND IsNull(@c73, '') = '' THEN '01/01/1900' ELSE @c73 END,
		CASE WHEN /*SecondaryPreTransfusionSampleHeldTime*/ SUBSTRING(@bitmap, 10, 1) & 2 = 2 AND IsNull(@c74, '') = '' THEN 'ILB' ELSE @c74 END,
		CASE WHEN /*SecondaryPreTransfusionSampleHeldTechnician*/ SUBSTRING(@bitmap, 10, 1) & 4 = 4 AND IsNull(@c75, '') = '' THEN 'ILB' ELSE @c75 END,
		CASE WHEN /*SecondaryPostMordemSampleTestSuitable*/ SUBSTRING(@bitmap, 10, 1) & 8 = 8 AND IsNull(@c76, -1) IN ( -1, 0) THEN -2 ELSE @c76 END,
		CASE WHEN /*SecondaryPostMordemSampleLocation*/ SUBSTRING(@bitmap, 10, 1) & 16 = 16 AND IsNull(@c77, '') = '' THEN 'ILB' ELSE @c77 END,
		CASE WHEN /*SecondaryPostMordemSampleContact*/ SUBSTRING(@bitmap, 10, 1) & 32 = 32 AND IsNull(@c78, '') = '' THEN 'ILB' ELSE @c78 END,
		CASE WHEN /*SecondaryPostMordemSampleCollectionDate*/ SUBSTRING(@bitmap, 10, 1) & 64 = 64 AND IsNull(@c79, '') = '' THEN '01/01/1900' ELSE @c79 END,
		CASE WHEN /*SecondaryPostMordemSampleCollectionTime*/ SUBSTRING(@bitmap, 10, 1) & 128 = 128 AND IsNull(@c80, '') = '' THEN 'ILB' ELSE @c80 END,
		CASE WHEN /*SecondarySputumCharacteristics*/ SUBSTRING(@bitmap, 11, 1) & 1 = 1 AND IsNull(@c81, '') = '' THEN 'ILB' ELSE @c81 END,
		CASE WHEN /*SecondaryNOKAltPhone*/ SUBSTRING(@bitmap, 11, 1) & 2 = 2 AND IsNull(@c82, '') = '' THEN 'ILB' ELSE @c82 END,
		CASE WHEN /*SecondaryNOKLegal*/ SUBSTRING(@bitmap, 11, 1) & 4 = 4 AND IsNull(@c83, -1) IN ( -1, 0) THEN -2 ELSE @c83 END,
		CASE WHEN /*SecondaryNOKAltContact*/ SUBSTRING(@bitmap, 11, 1) & 8 = 8 AND IsNull(@c84, '') = '' THEN 'ILB' ELSE @c84 END,
		CASE WHEN /*SecondaryNOKAltContactPhone*/ SUBSTRING(@bitmap, 11, 1) & 16 = 16 AND IsNull(@c85, '') = '' THEN 'ILB' ELSE @c85 END,
		CASE WHEN /*SecondaryNOKPostMortemAuthorization*/ SUBSTRING(@bitmap, 11, 1) & 32 = 32 AND IsNull(@c86, -1) IN ( -1, 0) THEN -2 ELSE @c86 END,
		CASE WHEN /*SecondaryNOKPostMortemAuthorizationReminder*/ SUBSTRING(@bitmap, 11, 1) & 64 = 64 AND IsNull(@c87, '') = '' THEN 'ILB' ELSE @c87 END,
		CASE WHEN /*SecondaryCoronerCaseNumber*/ SUBSTRING(@bitmap, 11, 1) & 128 = 128 AND IsNull(@c88, '') = '' THEN 'ILB' ELSE @c88 END,
		CASE WHEN /*SecondaryCoronerCounty*/ SUBSTRING(@bitmap, 12, 1) & 1 = 1 AND IsNull(@c89, '') = '' THEN 'ILB' ELSE @c89 END,
		CASE WHEN /*SecondaryCoronerReleased*/ SUBSTRING(@bitmap, 12, 1) & 2 = 2 AND IsNull(@c90, '') = '' THEN 'ILB' ELSE @c90 END,
		CASE WHEN /*SecondaryCoronerReleasedStipulations*/ SUBSTRING(@bitmap, 12, 1) & 4 = 4 AND IsNull(@c91, '') = '' THEN 'ILB' ELSE @c91 END,
		CASE WHEN /*SecondaryAutopsy*/ SUBSTRING(@bitmap, 12, 1) & 8 = 8 AND IsNull(@c92, -1) IN ( -1, 0) THEN -2 ELSE @c92 END,
		CASE WHEN /*SecondaryAutopsyDate*/ SUBSTRING(@bitmap, 12, 1) & 16 = 16 AND IsNull(@c93, '') = '' THEN '01/01/1900' ELSE @c93 END,
		CASE WHEN /*SecondaryAutopsyTime*/ SUBSTRING(@bitmap, 12, 1) & 32 = 32 AND IsNull(@c94, '') = '' THEN 'ILB' ELSE @c94 END,
		CASE WHEN /*SecondaryAutopsyLocation*/ SUBSTRING(@bitmap, 12, 1) & 64 = 64 AND IsNull(@c95, -1) IN ( -1, 0) THEN -2 ELSE @c95 END,
		CASE WHEN /*SecondaryAutopsyBloodRequested*/ SUBSTRING(@bitmap, 12, 1) & 128 = 128 AND IsNull(@c96, -1) IN ( -1, 0) THEN -2 ELSE @c96 END,
		CASE WHEN /*SecondaryAutopsyCopyRequested*/ SUBSTRING(@bitmap, 13, 1) & 1 = 1 AND IsNull(@c97, -1) IN ( -1, 0) THEN -2 ELSE @c97 END,
		CASE WHEN /*SecondaryFuneralHomeSelected*/ SUBSTRING(@bitmap, 13, 1) & 2 = 2 AND IsNull(@c98, -1) IN ( -1, 0) THEN -2 ELSE @c98 END,
		CASE WHEN /*SecondaryFuneralHomeName*/ SUBSTRING(@bitmap, 13, 1) & 4 = 4 AND IsNull(@c99, '') = '' THEN 'ILB' ELSE @c99 END,
		CASE WHEN /*SecondaryFuneralHomePhone*/ SUBSTRING(@bitmap, 13, 1) & 8 = 8 AND IsNull(@c100, '') = '' THEN 'ILB' ELSE @c100 END,
		CASE WHEN /*SecondaryFuneralHomeAddress*/ SUBSTRING(@bitmap, 13, 1) & 16 = 16 AND IsNull(@c101, '') = '' THEN 'ILB' ELSE @c101 END,
		CASE WHEN /*SecondaryFuneralHomeContact*/ SUBSTRING(@bitmap, 13, 1) & 32 = 32 AND IsNull(@c102, '') = '' THEN 'ILB' ELSE @c102 END,
		CASE WHEN /*SecondaryFuneralHomeNotified*/ SUBSTRING(@bitmap, 13, 1) & 64 = 64 AND IsNull(@c103, '') = '' THEN 'ILB' ELSE @c103 END,
		CASE WHEN /*SecondaryFuneralHomeMorgueCooled*/ SUBSTRING(@bitmap, 13, 1) & 128 = 128 AND IsNull(@c104, '') = '' THEN 'ILB' ELSE @c104 END,
		CASE WHEN /*SecondaryHoldOnBody*/ SUBSTRING(@bitmap, 14, 1) & 1 = 1 AND IsNull(@c105, -1) IN ( -1, 0) THEN -2 ELSE @c105 END,
		CASE WHEN /*SecondaryHoldOnBodyTag*/ SUBSTRING(@bitmap, 14, 1) & 2 = 2 AND IsNull(@c106, '') = '' THEN 'ILB' ELSE @c106 END,
		CASE WHEN /*SecondaryBodyRefrigerationDate*/ SUBSTRING(@bitmap, 14, 1) & 4 = 4 AND IsNull(@c107, '') = '' THEN '01/01/1900' ELSE @c107 END,
		CASE WHEN /*SecondaryBodyRefrigerationTime*/ SUBSTRING(@bitmap, 14, 1) & 8 = 8 AND IsNull(@c108, '') = '' THEN 'ILB' ELSE @c108 END,
		CASE WHEN /*SecondaryBodyLocation*/ SUBSTRING(@bitmap, 14, 1) & 16 = 16 AND IsNull(@c109, '') = '' THEN 'ILB' ELSE @c109 END,
		CASE WHEN /*SecondaryBodyMedicalChartLocation*/ SUBSTRING(@bitmap, 14, 1) & 32 = 32 AND IsNull(@c110, '') = '' THEN 'ILB' ELSE @c110 END,
		CASE WHEN /*SecondaryBodyIDTagLocation*/ SUBSTRING(@bitmap, 14, 1) & 64 = 64 AND IsNull(@c111, '') = '' THEN 'ILB' ELSE @c111 END,
		CASE WHEN /*SecondaryBodyCoolingMethod*/ SUBSTRING(@bitmap, 14, 1) & 128 = 128 AND IsNull(@c112, '') = '' THEN 'ILB' ELSE @c112 END,
		CASE WHEN /*SecondaryUNOSNumber*/ SUBSTRING(@bitmap, 15, 1) & 1 = 1 AND IsNull(@c113, '') = '' THEN 'ILB' ELSE @c113 END,
		CASE WHEN /*SecondaryClientNumber*/ SUBSTRING(@bitmap, 15, 1) & 2 = 2 AND IsNull(@c114, '') = '' THEN 'ILB' ELSE @c114 END,
		CASE WHEN /*SecondaryCryolifeNumber*/ SUBSTRING(@bitmap, 15, 1) & 4 = 4 AND IsNull(@c115, '') = '' THEN 'ILB' ELSE @c115 END,
		CASE WHEN /*SecondaryMTFNumber*/ SUBSTRING(@bitmap, 15, 1) & 8 = 8 AND IsNull(@c116, '') = '' THEN 'ILB' ELSE @c116 END,
		CASE WHEN /*SecondaryLifeNetNumber*/ SUBSTRING(@bitmap, 15, 1) & 16 = 16 AND IsNull(@c117, '') = '' THEN 'ILB' ELSE @c117 END,
		CASE WHEN /*SecondaryFreeText*/ SUBSTRING(@bitmap, 15, 1) & 32 = 32 AND IsNull(@c118, '') = '' THEN 'ILB' ELSE @c118 END,
		CASE WHEN /*SecondaryHistorySubstanceAbuse*/ SUBSTRING(@bitmap, 15, 1) & 64 = 64 AND IsNull(@c119, -1) IN ( -1, 0) THEN -2 ELSE @c119 END,
		CASE WHEN /*SecondarySubstanceAbuseDetail*/ SUBSTRING(@bitmap, 15, 1) & 128 = 128 AND IsNull(@c120, '') = '' THEN 'ILB' ELSE @c120 END,
		CASE WHEN /*SecondaryExtubationDate*/ SUBSTRING(@bitmap, 16, 1) & 1 = 1 AND IsNull(@c121, '') = '' THEN '01/01/1900' ELSE @c121 END,
		CASE WHEN /*SecondaryExtubationTime*/ SUBSTRING(@bitmap, 16, 1) & 2 = 2 AND IsNull(@c122, '') = '' THEN 'ILB' ELSE @c122 END,
		CASE WHEN /*SecondaryAutopsyReminderYN*/ SUBSTRING(@bitmap, 16, 1) & 4 = 4 AND IsNull(@c123, -1) IN ( -1, 0) THEN -2 ELSE @c123 END,
		CASE WHEN /*SecondaryFHReminderYN*/ SUBSTRING(@bitmap, 16, 1) & 8 = 8 AND IsNull(@c124, -1) IN ( -1, 0) THEN -2 ELSE @c124 END,
		CASE WHEN /*SecondaryBodyCareReminderYN*/ SUBSTRING(@bitmap, 16, 1) & 16 = 16 AND IsNull(@c125, -1) IN ( -1, 0) THEN -2 ELSE @c125 END,
		CASE WHEN /*SecondaryWrapUpReminderYN*/ SUBSTRING(@bitmap, 16, 1) & 32 = 32 AND IsNull(@c126, -1) IN ( -1, 0) THEN -2 ELSE @c126 END,
		CASE WHEN /*SecondaryNOKNotifiedBy*/ SUBSTRING(@bitmap, 16, 1) & 64 = 64 AND IsNull(@c127, '') = '' THEN 'ILB' ELSE @c127 END,
		CASE WHEN /*SecondaryNOKNotifiedDate*/ SUBSTRING(@bitmap, 16, 1) & 128 = 128 AND IsNull(@c128, '') = '' THEN '01/01/1900' ELSE @c128 END,
		CASE WHEN /*SecondaryNOKNotifiedTime*/ SUBSTRING(@bitmap, 17, 1) & 1 = 1 AND IsNull(@c129, '') = '' THEN 'ILB' ELSE @c129 END,
		CASE WHEN /*SecondaryNOKGender*/ SUBSTRING(@bitmap, 17, 1) & 2 = 2 AND IsNull(@c130, '') = '' THEN 'ILB' ELSE @c130 END,
		CASE WHEN /*SecondaryCODOther*/ SUBSTRING(@bitmap, 17, 1) & 4 = 4 AND IsNull(@c131, '') = '' THEN 'ILB' ELSE @c131 END,
		CASE WHEN /*SecondaryAutopsyLocationOther*/ SUBSTRING(@bitmap, 17, 1) & 8 = 8 AND IsNull(@c132, '') = '' THEN 'ILB' ELSE @c132 END,
		CASE WHEN /*SecondaryPatientHospitalPhone*/ SUBSTRING(@bitmap, 17, 1) & 16 = 16 AND IsNull(@c133, '') = '' THEN 'ILB' ELSE @c133 END,
		CASE WHEN /*SecondaryCoronerCase*/ SUBSTRING(@bitmap, 17, 1) & 32 = 32 THEN IsNull(@c134, 0) ELSE Null END,
		CASE WHEN /*SecondaryPatientABO*/ SUBSTRING(@bitmap, 17, 1) & 64 = 64 AND IsNull(@c135, -1) IN ( -1, 0) THEN -2 ELSE @c135 END,
		CASE WHEN /*SecondaryPatientSuffix*/ SUBSTRING(@bitmap, 17, 1) & 128 = 128 AND IsNull(@c136, '') = '' THEN 'ILB' ELSE @c136 END,
		CASE WHEN /*SecondaryMDAttendingId*/ SUBSTRING(@bitmap, 18, 1) & 1 = 1 AND IsNull(@c137, -1) IN ( -1, 0) THEN -2 ELSE @c137 END,
		CASE WHEN /*SecondaryAdditionalComments*/ SUBSTRING(@bitmap, 18, 1) & 2 = 2 AND IsNull(@c138, '') = '' THEN 'ILB' ELSE @c138 END,
		CASE WHEN /*SecondaryRhythm*/ SUBSTRING(@bitmap, 18, 1) & 4 = 4 AND IsNull(@c139, -1) IN ( -1, 0) THEN -2 ELSE @c139 END,
		CASE WHEN /*SecondaryAdditionalMedications*/ SUBSTRING(@bitmap, 18, 1) & 8 = 8 AND IsNull(@c140, '') = '' THEN 'ILB' ELSE @c140 END,
		CASE WHEN /*SecondaryBodyHoldPlaced*/ SUBSTRING(@bitmap, 18, 1) & 16 = 16 AND IsNull(@c141, '') = '' THEN '01/01/1900' ELSE @c141 END,
		CASE WHEN /*SecondaryBodyHoldPlacedWith*/ SUBSTRING(@bitmap, 18, 1) & 32 = 32 AND IsNull(@c142, '') = '' THEN 'ILB' ELSE @c142 END,
		CASE WHEN /*SecondaryBodyFutureContact*/ SUBSTRING(@bitmap, 18, 1) & 64 = 64 AND IsNull(@c143, '') = '' THEN 'ILB' ELSE @c143 END,
		CASE WHEN /*SecondaryBodyHoldPhone*/ SUBSTRING(@bitmap, 18, 1) & 128 = 128 AND IsNull(@c144, '') = '' THEN 'ILB' ELSE @c144 END,
		CASE WHEN /*SecondaryBodyHoldInstructionsGiven*/ SUBSTRING(@bitmap, 19, 1) & 1 = 1 AND IsNull(@c145, -1) IN ( -1, 0) THEN -2 ELSE @c145 END,
		CASE WHEN /*SecondarySteroid*/ SUBSTRING(@bitmap, 19, 1) & 2 = 2 AND IsNull(@c146, -1) IN ( -1, 0) THEN -2 ELSE @c146 END,
		CASE WHEN /*SecondaryBodyHoldPlacedTime*/ SUBSTRING(@bitmap, 19, 1) & 4 = 4 AND IsNull(@c147, '') = '' THEN 'ILB' ELSE @c147 END,
		ISNULL(@c148, @LastStatEmployeeID),
		ISNULL(@c149, @auditLogTypeID),
		ISNULL(@c150, @lastModified)
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

