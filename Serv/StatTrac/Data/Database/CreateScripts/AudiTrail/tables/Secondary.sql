if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Secondary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Secondary]
GO

CREATE TABLE [dbo].[Secondary] (
	[CallID] [int] NOT NULL ,
	[SecondaryWhoAreWe] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKaware] [smallint] NULL ,
	[SecondaryFamilyConsent] [smallint] NULL ,
	[SecondaryFamilyInterested] [smallint] NULL ,
	[SecondaryNOKatHospital] [smallint] NULL ,
	[SecondaryEstTimeSinceLeft] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryTimeLeftInMT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKNextDest] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKETA] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientMiddleName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientHeightFeet] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientHeightInches] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientBMICalc] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientTOD1] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientTOD2] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientDeathType1] [smalldatetime] NULL ,
	[SecondaryPatientDeathType2] [smalldatetime] NULL ,
	[SecondaryTriageHX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCircumstanceOfDeath] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMedicalHistory] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAdmissionDiagnosis] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCOD] [int] NULL ,
	[SecondaryCODSignatory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCODTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCODSignedBy] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientVent] [smallint] NULL ,
	[SecondaryIntubationDate] [smalldatetime] NULL ,
	[SecondaryIntubationTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBrainDeathDate] [smalldatetime] NULL ,
	[SecondaryBrainDeathTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryDNRDate] [smalldatetime] NULL ,
	[SecondaryERORDeath] [smallint] NULL ,
	[SecondaryEMSArrivalToPatientDate] [smalldatetime] NULL ,
	[SecondaryEMSArrivalToPatientTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryEMSArrivalToHospitalDate] [smalldatetime] NULL ,
	[SecondaryEMSArrivalToHospitalTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientTerminal] [smallint] NULL ,
	[SecondaryDeathWitnessed] [smallint] NULL ,
	[SecondaryDeathWitnessedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLSADate] [smalldatetime] NULL ,
	[SecondaryLSATime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLSABy] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryACLSProvided] [smallint] NULL ,
	[SecondaryACLSProvidedTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryGestationalAge] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryParentName1] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryParentName2] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBirthCBO] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryActiveInfection] [smallint] NULL ,
	[SecondaryActiveInfectionType] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFluidsGiven] [smallint] NULL ,
	[SecondaryBloodLoss] [smallint] NULL ,
	[SecondarySignOfInfection] [smallint] NULL ,
	[SecondaryMedication] [smallint] NULL ,
	[SecondaryAntibiotic] [smallint] NULL ,
	[SecondaryPCPName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPCPPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMDAttending] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMDAttendingPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPhysicalAppearance] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryInternalBloodLossCC] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryExternalBloodLossCC] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProducts] [smallint] NULL ,
	[SecondaryColloidsInfused] [smallint] NULL ,
	[SecondaryCrystalloids] [smallint] NULL ,
	[SecondaryPreTransfusionSampleRequired] [smallint] NULL ,
	[SecondaryPreTransfusionSampleAvailable] [smallint] NULL ,
	[SecondaryPreTransfusionSampleDrawnDate] [smalldatetime] NULL ,
	[SecondaryPreTransfusionSampleDrawnTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPreTransfusionSampleQuantity] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPreTransfusionSampleHeldAt] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPreTransfusionSampleHeldDate] [smalldatetime] NULL ,
	[SecondaryPreTransfusionSampleHeldTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPreTransfusionSampleHeldTechnician] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPostMordemSampleTestSuitable] [smallint] NULL ,
	[SecondaryPostMordemSampleLocation] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPostMordemSampleContact] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPostMordemSampleCollectionDate] [smalldatetime] NULL ,
	[SecondaryPostMordemSampleCollectionTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondarySputumCharacteristics] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKAltPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKLegal] [smallint] NULL ,
	[SecondaryNOKAltContact] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKAltContactPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKPostMortemAuthorization] [smallint] NULL ,
	[SecondaryNOKPostMortemAuthorizationReminder] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCoronerCaseNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCoronerCounty] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCoronerReleased] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCoronerReleasedStipulations] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAutopsy] [smallint] NULL ,
	[SecondaryAutopsyDate] [smalldatetime] NULL ,
	[SecondaryAutopsyTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAutopsyLocation] [int] NULL ,
	[SecondaryAutopsyBloodRequested] [smallint] NULL ,
	[SecondaryAutopsyCopyRequested] [smallint] NULL ,
	[SecondaryFuneralHomeSelected] [smallint] NULL ,
	[SecondaryFuneralHomeName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFuneralHomePhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFuneralHomeAddress] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFuneralHomeContact] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFuneralHomeNotified] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFuneralHomeMorgueCooled] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryHoldOnBody] [smallint] NULL ,
	[SecondaryHoldOnBodyTag] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyRefrigerationDate] [smalldatetime] NULL ,
	[SecondaryBodyRefrigerationTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyLocation] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyMedicalChartLocation] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyIDTagLocation] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyCoolingMethod] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryUNOSNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryClientNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCryolifeNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMTFNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLifeNetNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryFreeText] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryHistorySubstanceAbuse] [smallint] NULL ,
	[SecondarySubstanceAbuseDetail] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryExtubationDate] [smalldatetime] NULL ,
	[SecondaryExtubationTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAutopsyReminderYN] [smallint] NULL ,
	[SecondaryFHReminderYN] [smallint] NULL ,
	[SecondaryBodyCareReminderYN] [smallint] NULL ,
	[SecondaryWrapUpReminderYN] [smallint] NULL ,
	[SecondaryNOKNotifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKNotifiedDate] [smalldatetime] NULL ,
	[SecondaryNOKNotifiedTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryNOKGender] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCODOther] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAutopsyLocationOther] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryPatientHospitalPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCoronerCase] [smallint] NULL ,
	[SecondaryPatientABO] [int] NULL ,
	[SecondaryPatientSuffix] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMDAttendingId] [int] NULL ,
	[SecondaryAdditionalComments] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryRhythm] [int] NULL ,
	[SecondaryAdditionalMedications] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyHoldPlaced] [smalldatetime] NULL ,
	[SecondaryBodyHoldPlacedWith] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyFutureContact] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyHoldPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBodyHoldInstructionsGiven] [smallint] NULL ,
	[SecondarySteroid] [smallint] NULL ,
	[SecondaryBodyHoldPlacedTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondarySputumCharacteristics] ON [dbo].[Secondary] ([SecondarySputumCharacteristics]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryCoronerReleasedStipulations] ON [dbo].[Secondary] ([SecondaryCoronerReleasedStipulations]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryFreeText] ON [dbo].[Secondary] ([SecondaryFreeText]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryAdditionalComments] ON [dbo].[Secondary] ([SecondaryAdditionalComments]) ')
GO

 CREATE    INDEX [PK_Secondary] ON [dbo].[Secondary]([CallID]) WITH FILLFACTOR = 90 ON [IDX]
GO


