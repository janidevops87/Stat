if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral]
GO

CREATE TABLE [dbo].[Referral] (
	[ReferralID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[ReferralCallerPhoneID] [int] NULL ,
	[ReferralCallerExtension] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCallerOrganizationID] [int] NULL ,
	[ReferralCallerSubLocationID] [int] NULL ,
	[ReferralCallerSubLocationLevel] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCallerPersonID] [int] NULL ,
	[ReferralDonorName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorRecNumber] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorAge] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorAgeUnit] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorRaceID] [int] NULL ,
	[ReferralDonorGender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorWeight] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorAdmitDate] [smalldatetime] NULL ,
	[ReferralDonorAdmitTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorDeathDate] [smalldatetime] NULL ,
	[ReferralDonorDeathTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorCauseOfDeathID] [int] NULL ,
	[ReferralDonorOnVentilator] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorDead] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralTypeID] [int] NULL ,
	[ReferralApproachTypeID] [int] NULL ,
	[ReferralApproachedByPersonID] [int] NULL ,
	[ReferralApproachNOK] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralApproachRelation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralOrganAppropriateID] [int] NULL ,
	[ReferralOrganApproachID] [int] NULL ,
	[ReferralOrganConsentID] [int] NULL ,
	[ReferralOrganConversionID] [int] NULL ,
	[ReferralBoneAppropriateID] [int] NULL ,
	[ReferralBoneApproachID] [int] NULL ,
	[ReferralBoneConsentID] [int] NULL ,
	[ReferralBoneConversionID] [int] NULL ,
	[ReferralTissueAppropriateID] [int] NULL ,
	[ReferralTissueApproachID] [int] NULL ,
	[ReferralTissueConsentID] [int] NULL ,
	[ReferralTissueConversionID] [int] NULL ,
	[ReferralSkinAppropriateID] [int] NULL ,
	[ReferralSkinApproachID] [int] NULL ,
	[ReferralSkinConsentID] [int] NULL ,
	[ReferralSkinConversionID] [int] NULL ,
	[ReferralEyesTransAppropriateID] [int] NULL ,
	[ReferralEyesTransApproachID] [int] NULL ,
	[ReferralEyesTransConsentID] [int] NULL ,
	[ReferralEyesTransConversionID] [int] NULL ,
	[ReferralEyesRschAppropriateID] [int] NULL ,
	[ReferralEyesRschApproachID] [int] NULL ,
	[ReferralEyesRschConsentID] [int] NULL ,
	[ReferralEyesRschConversionID] [int] NULL ,
	[ReferralValvesAppropriateID] [int] NULL ,
	[ReferralValvesApproachID] [int] NULL ,
	[ReferralValvesConsentID] [int] NULL ,
	[ReferralValvesConversionID] [int] NULL ,
	[ReferralNotesCase] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralNotesPrevious] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralVerifiedOptions] [smallint] NULL ,
	[ReferralCoronersCase] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[ReferralCallerLevelID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UnusedField1] [smallint] NULL ,
	[ReferralDonorFirstName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorLastName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralOrganDispositionID] [int] NULL ,
	[ReferralBoneDispositionID] [int] NULL ,
	[ReferralTissueDispositionID] [int] NULL ,
	[ReferralSkinDispositionID] [int] NULL ,
	[ReferralValvesDispositionID] [int] NULL ,
	[ReferralEyesDispositionID] [int] NULL ,
	[ReferralRschDispositionID] [int] NULL ,
	[ReferralAllTissueDispositionID] [int] NULL ,
	[ReferralPronouncingMD] [int] NULL ,
	[UnusedField3] [int] NULL ,
	[ReferralNOKPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralAttendingMD] [int] NULL ,
	[ReferralGeneralConsent] [smallint] NULL ,
	[ReferralNOKAddress] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCoronerName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCoronerPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCoronerOrganization] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralCoronerNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralApproachTime] [numeric](7, 0) NULL ,
	[ReferralConsentTime] [numeric](7, 0) NULL ,
	[Unused] [smalldatetime] NULL ,
	[ReferralDOA] [smallint] NULL ,
	[ReferralDOB] [datetime] NULL ,
	[ReferralDonorSSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[ReferralExtubated] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorRegistryType] [smallint] NULL ,
	[DonorRegId] [int] NULL ,
	[DonorDMVId] [int] NULL ,
	[DonorDMVTable] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorIntentDone] [smallint] NULL ,
	[DonorFaxSent] [smallint] NULL ,
	[DonorDSNID] [smallint] NULL ,
	[ReferralDonorHeartBeat] [int] NULL ,
	[ReferralCoronerOrgID] [int] NULL ,
	[CurrentReferralTypeId] [int] NULL ,
	[ReferralDonorBrainDeathDate] [smalldatetime] NULL ,
	[ReferralDonorBrainDeathTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralPronouncingMDPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralAttendingMDPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDOB_ILB] [smallint] NULL ,
	[ReferralDonorSpecificCOD] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralDonorNameMI] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralNOKID] [int] NULL ,
	[ReferralQAReviewComplete] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralCallerSubLocationID] ON [dbo].[Referral] ([ReferralCallerSubLocationID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralCallerPersonID] ON [dbo].[Referral] ([ReferralCallerPersonID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralDonorAge] ON [dbo].[Referral] ([ReferralDonorAge]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralApproachedByPersonID] ON [dbo].[Referral] ([ReferralApproachedByPersonID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralOrganAppropriateID] ON [dbo].[Referral] ([ReferralOrganAppropriateID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [LastModified] ON [dbo].[Referral] ([LastModified]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [ReferralDOB] ON [dbo].[Referral] ([ReferralDOB]) ')
GO

 CREATE  INDEX [CallID] ON [dbo].[Referral]([CallID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [DonorFirstName] ON [dbo].[Referral]([ReferralDonorFirstName]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [DonorLastName] ON [dbo].[Referral]([ReferralDonorLastName]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [PhoneID] ON [dbo].[Referral]([ReferralCallerPhoneID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [Referral33] ON [dbo].[Referral]([CallID], [ReferralCallerOrganizationID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE    INDEX [PK_Referral_1__24] ON [dbo].[Referral]([ReferralID]) WITH FILLFACTOR = 90 ON [IDX]
GO


