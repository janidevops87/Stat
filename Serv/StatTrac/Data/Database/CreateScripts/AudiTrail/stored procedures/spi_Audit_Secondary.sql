SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_Secondary]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_Secondary]
GO

create procedure "spi_Audit_Secondary" 
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
	@c150 smalldatetime

AS
BEGIN


insert into 
	"Secondary"
	( 
		"CallID",
		"SecondaryWhoAreWe",
		"SecondaryNOKaware",
		"SecondaryFamilyConsent",
		"SecondaryFamilyInterested",
		"SecondaryNOKatHospital",
		"SecondaryEstTimeSinceLeft",
		"SecondaryTimeLeftInMT",
		"SecondaryNOKNextDest",
		"SecondaryNOKETA",
		"SecondaryPatientMiddleName",
		"SecondaryPatientHeightFeet",
		"SecondaryPatientHeightInches",
		"SecondaryPatientBMICalc",
		"SecondaryPatientTOD1",
		"SecondaryPatientTOD2",
		"SecondaryPatientDeathType1",
		"SecondaryPatientDeathType2",
		"SecondaryTriageHX",
		"SecondaryCircumstanceOfDeath",
		"SecondaryMedicalHistory",
		"SecondaryAdmissionDiagnosis",
		"SecondaryCOD",
		"SecondaryCODSignatory",
		"SecondaryCODTime",
		"SecondaryCODSignedBy",
		"SecondaryPatientVent",
		"SecondaryIntubationDate",
		"SecondaryIntubationTime",
		"SecondaryBrainDeathDate",
		"SecondaryBrainDeathTime",
		"SecondaryDNRDate",
		"SecondaryERORDeath",
		"SecondaryEMSArrivalToPatientDate",
		"SecondaryEMSArrivalToPatientTime",
		"SecondaryEMSArrivalToHospitalDate",
		"SecondaryEMSArrivalToHospitalTime",
		"SecondaryPatientTerminal",
		"SecondaryDeathWitnessed",
		"SecondaryDeathWitnessedBy",
		"SecondaryLSADate",
		"SecondaryLSATime",
		"SecondaryLSABy",
		"SecondaryACLSProvided",
		"SecondaryACLSProvidedTime",
		"SecondaryGestationalAge",
		"SecondaryParentName1",
		"SecondaryParentName2",
		"SecondaryBirthCBO",
		"SecondaryActiveInfection",
		"SecondaryActiveInfectionType",
		"SecondaryFluidsGiven",
		"SecondaryBloodLoss",
		"SecondarySignOfInfection",
		"SecondaryMedication",
		"SecondaryAntibiotic",
		"SecondaryPCPName",
		"SecondaryPCPPhone",
		"SecondaryMDAttending",
		"SecondaryMDAttendingPhone",
		"SecondaryPhysicalAppearance",
		"SecondaryInternalBloodLossCC",
		"SecondaryExternalBloodLossCC",
		"SecondaryBloodProducts",
		"SecondaryColloidsInfused",
		"SecondaryCrystalloids",
		"SecondaryPreTransfusionSampleRequired",
		"SecondaryPreTransfusionSampleAvailable",
		"SecondaryPreTransfusionSampleDrawnDate",
		"SecondaryPreTransfusionSampleDrawnTime",
		"SecondaryPreTransfusionSampleQuantity",
		"SecondaryPreTransfusionSampleHeldAt",
		"SecondaryPreTransfusionSampleHeldDate",
		"SecondaryPreTransfusionSampleHeldTime",
		"SecondaryPreTransfusionSampleHeldTechnician",
		"SecondaryPostMordemSampleTestSuitable",
		"SecondaryPostMordemSampleLocation",
		"SecondaryPostMordemSampleContact",
		"SecondaryPostMordemSampleCollectionDate",
		"SecondaryPostMordemSampleCollectionTime",
		"SecondarySputumCharacteristics",
		"SecondaryNOKAltPhone",
		"SecondaryNOKLegal",
		"SecondaryNOKAltContact",
		"SecondaryNOKAltContactPhone",
		"SecondaryNOKPostMortemAuthorization",
		"SecondaryNOKPostMortemAuthorizationReminder",
		"SecondaryCoronerCaseNumber",
		"SecondaryCoronerCounty",
		"SecondaryCoronerReleased",
		"SecondaryCoronerReleasedStipulations",
		"SecondaryAutopsy",
		"SecondaryAutopsyDate",
		"SecondaryAutopsyTime",
		"SecondaryAutopsyLocation",
		"SecondaryAutopsyBloodRequested",
		"SecondaryAutopsyCopyRequested",
		"SecondaryFuneralHomeSelected",
		"SecondaryFuneralHomeName",
		"SecondaryFuneralHomePhone",
		"SecondaryFuneralHomeAddress",
		"SecondaryFuneralHomeContact",
		"SecondaryFuneralHomeNotified",
		"SecondaryFuneralHomeMorgueCooled"
 ,
		"SecondaryHoldOnBody",
		"SecondaryHoldOnBodyTag",
		"SecondaryBodyRefrigerationDate",
		"SecondaryBodyRefrigerationTime",
		"SecondaryBodyLocation",
		"SecondaryBodyMedicalChartLocation",
		"SecondaryBodyIDTagLocation",
		"SecondaryBodyCoolingMethod",
		"SecondaryUNOSNumber",
		"SecondaryClientNumber",
		"SecondaryCryolifeNumber",
		"SecondaryMTFNumber",
		"SecondaryLifeNetNumber",
		"SecondaryFreeText",
		"SecondaryHistorySubstanceAbuse",
		"SecondarySubstanceAbuseDetail",
		"SecondaryExtubationDate",
		"SecondaryExtubationTime",
		"SecondaryAutopsyReminderYN",
		"SecondaryFHReminderYN",
		"SecondaryBodyCareReminderYN",
		"SecondaryWrapUpReminderYN",
		"SecondaryNOKNotifiedBy",
		"SecondaryNOKNotifiedDate",
		"SecondaryNOKNotifiedTime",
		"SecondaryNOKGender",
		"SecondaryCODOther",
		"SecondaryAutopsyLocationOther",
		"SecondaryPatientHospitalPhone",
		"SecondaryCoronerCase",
		"SecondaryPatientABO",
		"SecondaryPatientSuffix",
		"SecondaryMDAttendingId",
		"SecondaryAdditionalComments",
		"SecondaryRhythm",
		"SecondaryAdditionalMedications",
		"SecondaryBodyHoldPlaced",
		"SecondaryBodyHoldPlacedWith",
		"SecondaryBodyFutureContact",
		"SecondaryBodyHoldPhone",
		"SecondaryBodyHoldInstructionsGiven",
		"SecondarySteroid",
		"SecondaryBodyHoldPlacedTime",
		"LastStatEmployeeID",
		"AuditLogTypeID",
		"LastModified"
	)

values 
	( 
		@c1,
		@c2,
		@c3,
		@c4,
		@c5,
		@c6,
		@c7,
		@c8,
		@c9,
		@c10,
		@c11,
		@c12,
		@c13,
		@c14,
		@c15,
		@c16,
		@c17,
		@c18,
		@c19,
		@c20,
		@c21,
		@c22,
		@c23,
		@c24,
		@c25,
		@c26,
		@c27,
		@c28,
		@c29,
		@c30,
		@c31,
		@c32,
		@c33,
		@c34,
		@c35,
		@c36,
		@c37,
		@c38,
		@c39,
		@c40,
		@c41,
		@c42,
		@c43,
		@c44,
		@c45,
		@c46,
		@c47,
		@c48,
		@c49,
		@c50,
		@c51,
		@c52,
		@c53,
		@c54,
		@c55,
		@c56,
		@c57,
		@c58,
		@c59,
		@c60,
		@c61,
		@c62,
		@c63,
		@c64,
		@c65,
		@c66,
		@c67,
		@c68,
		@c69,
		@c70,
		@c71,
		@c72,
		@c73,
		@c74,
		@c75,
		@c76,
		@c77,
		@c78,
		@c79,
		@c80,
		@c81,
		@c82,
		@c83,
		@c84,
		@c85,
		@c86,
		@c87,
		@c88,
		@c89,
		@c90,
		@c91,
		@c92,
		@c93,
		@c94,
		@c95,
		@c96,
		@c97,
		@c98,
		@c99,
		@c100,
		@c101,
		@c102,
		@c103,
		@c104,
		@c105,
		@c106,
		@c107,
		@c108,
		@c109,
		@c110,
		@c111,
		@c112,
		@c113,
		@c114,
		@c115,
		@c116,
		@c117,
		@c118,
		@c119,
		@c120,
		@c121,
		@c122,
		@c123,
		@c124,
		@c125,
		@c126,
		@c127,
		@c128,
		@c129,
		@c130,
		@c131,
		@c132,
		@c133,
		@c134,
		@c135,
		@c136,
		@c137,
		@c138,
		@c139,
		@c140,
		@c141,
		@c142,
		@c143,
		@c144,
		@c145,
		@c146,
		@c147,
		@c148,
		@c149,
		@c150
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

