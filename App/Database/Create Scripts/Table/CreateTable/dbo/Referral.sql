SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Referral](
	[ReferralID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[ReferralCallerPhoneID] [int] NULL,
	[ReferralCallerExtension] [varchar](10) NULL,
	[ReferralCallerOrganizationID] [int] NULL,
	[ReferralCallerSubLocationID] [int] NULL,
	[ReferralCallerSubLocationLevel] [varchar](4) NULL,
	[ReferralCallerPersonID] [int] NULL,
	[ReferralDonorName] [varchar](80) NULL,
	[ReferralDonorRecNumber] [varchar](30) NULL,
	[ReferralDonorAge] [varchar](4) NULL,
	[ReferralDonorAgeUnit] [varchar](10) NULL,
	[ReferralDonorRaceID] [int] NULL,
	[ReferralDonorGender] [char](1) NULL,
	[ReferralDonorWeight] [varchar](7) NULL,
	[ReferralDonorAdmitDate] [smalldatetime] NULL,
	[ReferralDonorAdmitTime] [varchar](10) NULL,
	[ReferralDonorDeathDate] [smalldatetime] NULL,
	[ReferralDonorDeathTime] [varchar](10) NULL,
	[ReferralDonorCauseOfDeathID] [int] NULL,
	[ReferralDonorOnVentilator] [varchar](20) NULL,
	[ReferralDonorDead] [varchar](4) NULL,
	[ReferralTypeID] [int] NULL,
	[ReferralApproachTypeID] [int] NULL,
	[ReferralApproachedByPersonID] [int] NULL,
	[ReferralApproachNOK] [varchar](50) NULL,
	[ReferralApproachRelation] [varchar](50) NULL,
	[ReferralOrganAppropriateID] [int] NULL,
	[ReferralOrganApproachID] [int] NULL,
	[ReferralOrganConsentID] [int] NULL,
	[ReferralOrganConversionID] [int] NULL,
	[ReferralBoneAppropriateID] [int] NULL,
	[ReferralBoneApproachID] [int] NULL,
	[ReferralBoneConsentID] [int] NULL,
	[ReferralBoneConversionID] [int] NULL,
	[ReferralTissueAppropriateID] [int] NULL,
	[ReferralTissueApproachID] [int] NULL,
	[ReferralTissueConsentID] [int] NULL,
	[ReferralTissueConversionID] [int] NULL,
	[ReferralSkinAppropriateID] [int] NULL,
	[ReferralSkinApproachID] [int] NULL,
	[ReferralSkinConsentID] [int] NULL,
	[ReferralSkinConversionID] [int] NULL,
	[ReferralEyesTransAppropriateID] [int] NULL,
	[ReferralEyesTransApproachID] [int] NULL,
	[ReferralEyesTransConsentID] [int] NULL,
	[ReferralEyesTransConversionID] [int] NULL,
	[ReferralEyesRschAppropriateID] [int] NULL,
	[ReferralEyesRschApproachID] [int] NULL,
	[ReferralEyesRschConsentID] [int] NULL,
	[ReferralEyesRschConversionID] [int] NULL,
	[ReferralValvesAppropriateID] [int] NULL,
	[ReferralValvesApproachID] [int] NULL,
	[ReferralValvesConsentID] [int] NULL,
	[ReferralValvesConversionID] [int] NULL,
	[ReferralNotesCase] [varchar](400) NULL,
	[ReferralNotesPrevious] [varchar](255) NULL,
	[ReferralVerifiedOptions] [smallint] NULL,
	[ReferralCoronersCase] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[ReferralCallerLevelID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UnusedField1] [smallint] NULL,
	[ReferralDonorFirstName] [varchar](40) NULL,
	[ReferralDonorLastName] [varchar](40) NULL,
	[ReferralOrganDispositionID] [int] NULL,
	[ReferralBoneDispositionID] [int] NULL,
	[ReferralTissueDispositionID] [int] NULL,
	[ReferralSkinDispositionID] [int] NULL,
	[ReferralValvesDispositionID] [int] NULL,
	[ReferralEyesDispositionID] [int] NULL,
	[ReferralRschDispositionID] [int] NULL,
	[ReferralAllTissueDispositionID] [int] NULL,
	[ReferralPronouncingMD] [int] NULL,
	[UnusedField3] [int] NULL,
	[ReferralNOKPhone] [varchar](14) NULL,
	[ReferralAttendingMD] [int] NULL,
	[ReferralGeneralConsent] [smallint] NULL,
	[ReferralNOKAddress] [varchar](255) NULL,
	[ReferralCoronerName] [varchar](80) NULL,
	[ReferralCoronerPhone] [varchar](14) NULL,
	[ReferralCoronerOrganization] [varchar](80) NULL,
	[ReferralCoronerNote] [varchar](255) NULL,
	[ReferralApproachTime] [numeric](7, 0) NULL,
	[ReferralConsentTime] [numeric](7, 0) NULL,
	[Unused] [smalldatetime] NULL,
	[ReferralDOA] [smallint] NULL,
	[ReferralDOB] [datetime] NULL,
	[ReferralDonorSSN] [varchar](11) NULL,
	[UpdatedFlag] [smallint] NULL,
	[ReferralExtubated] [varchar](15) NULL,
	[DonorRegistryType] [smallint] NULL,
	[DonorRegId] [int] NULL,
	[DonorDMVId] [int] NULL,
	[DonorDMVTable] [varchar](255) NULL,
	[DonorIntentDone] [smallint] NULL,
	[DonorFaxSent] [smallint] NULL,
	[DonorDSNID] [smallint] NULL,
	[ReferralDonorHeartBeat] [int] NULL,
	[ReferralCoronerOrgID] [int] NULL,
	[CurrentReferralTypeId] [int] NULL,
	[ReferralDonorBrainDeathDate] [smalldatetime] NULL,
	[ReferralDonorBrainDeathTime] [varchar](10) NULL,
	[ReferralPronouncingMDPhone] [varchar](14) NULL,
	[ReferralAttendingMDPhone] [varchar](14) NULL,
	[ReferralDOB_ILB] [smallint] NULL,
	[ReferralDonorSpecificCOD] [varchar](250) NULL,
	[ReferralDonorNameMI] [varchar](2) NULL,
	[ReferralNOKID] [int] NULL,
	[ReferralQAReviewComplete] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[ReferralDonorLSADate] [smalldatetime] NULL,
	[ReferralDonorLSATime] [nvarchar](10) NULL,
	[ReferralDCDPotential] [smallint] NULL,
	[ReferralPendingCase] [smallint] NULL,
	[ReferralPendingCaseCoordinator] [smallint] NULL,
	[ReferralPendingCaseComment] [varchar](50) NULL,
	[ReferralPendingCaseLastModified] [datetime] NULL,
	[ReferralDonorRecNumberSearchable] [varchar](30) NULL,
	[Hiv] [int] NULL,
	[Aids] [int] NULL,
	[HepB] [int] NULL,
	[HepC] [int] NULL,
	[Ivda] [int] NULL,
	[IdentityUnknown] [int] NULL,
	[AgeEstimated] [int] NULL,
	[WeightEstimated] [int] NULL,
	[PastMedicalHistory] [varchar](950) NULL,
	[AdmittingDiagnosis] [varchar](950) NULL,
	[IsERferralCase] [bit] NULL,
 CONSTRAINT [PK_Referral_1__24] PRIMARY KEY NONCLUSTERED 
(
	[ReferralID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_LastModified')
CREATE NONCLUSTERED INDEX [IDX_Referral_LastModified] ON [dbo].[Referral]
(
	[LastModified] ASC
)
INCLUDE([ReferralID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_ReferralCallerPhoneID')
CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralCallerPhoneID] ON [dbo].[Referral]
(
	[ReferralCallerPhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_ReferralPendingCase')
CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralPendingCase] ON [dbo].[Referral]
(
	[ReferralPendingCase] ASC
)
INCLUDE([CallID],[ReferralCallerOrganizationID],[ReferralDonorName],[CurrentReferralTypeId],[ReferralPendingCaseCoordinator],[ReferralPendingCaseComment],[ReferralPendingCaseLastModified]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'ix_Referral_ReferralCallerOrganizationID_includes')
CREATE NONCLUSTERED INDEX [ix_Referral_ReferralCallerOrganizationID_includes] ON [dbo].[Referral]
(
	[ReferralCallerOrganizationID] ASC
)
INCLUDE([CallID],[UnusedField1],[UnusedField3]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_UnusedField3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_UnusedField3]  DEFAULT (0) FOR [UnusedField3]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_DonorRegistryType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorRegistryType]  DEFAULT (0) FOR [DonorRegistryType]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_DonorRegId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorRegId]  DEFAULT (0) FOR [DonorRegId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_DonorDMVId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorDMVId]  DEFAULT (0) FOR [DonorDMVId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_DonorIntentDone]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorIntentDone]  DEFAULT (0) FOR [DonorIntentDone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referral_DonorFaxSent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referral] ADD  CONSTRAINT [DF_Referral_DonorFaxSent]  DEFAULT (0) FOR [DonorFaxSent]
END
GO		

-- check if Hiv exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'Hiv'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column Hiv';
	ALTER TABLE [Referral]
		ADD [Hiv] [int] NULL;
END	
GO
-- check if Aids exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'Aids'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column Aids';
	ALTER TABLE [Referral]
		ADD [Aids] [int] NULL;
END
GO	
-- check if HepB exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'HepB'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column HepB';
	ALTER TABLE [Referral]
		ADD [HepB] [int] NULL;
END	
GO
-- check if HepC exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'HepC'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column HepC';
	ALTER TABLE [Referral]
		ADD [HepC] [int] NULL;
END	
GO
-- check if Ivda exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'Ivda'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column Ivda';
	ALTER TABLE [Referral]
		ADD [Ivda] [int] NULL;
END	
GO
-- check if IdentityUnknown exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'IdentityUnknown'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column IdentityUnknown';
	ALTER TABLE [Referral]
		ADD [IdentityUnknown] [int] NULL;
END	
GO
-- check if AgeEstimated exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'AgeEstimated'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column AgeEstimated';
	ALTER TABLE [Referral]
		ADD [AgeEstimated] [int] NULL;
END	
GO
-- check if WeightEstimated exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'WeightEstimated'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column WeightEstimated';
	ALTER TABLE [Referral]
		ADD [WeightEstimated] [int] NULL;
END	
GO
-- check if PastMedicalHistory exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'PastMedicalHistory'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column PastMedicalHistory';
	ALTER TABLE [Referral]
		ADD [PastMedicalHistory] [varchar](950) NULL;
END	
GO
-- check if AdmittingDiagnosis exists
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'AdmittingDiagnosis'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column AdmittingDiagnosis';
	ALTER TABLE [Referral]
		ADD [AdmittingDiagnosis] [varchar](950) NULL;
END	
GO

IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Referral]')
	AND syscolumns.name = 'IsERferralCase'
	)
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Column IsERferralCase';
	ALTER TABLE [Referral]
		ADD [IsERferralCase] [bit] NULL;
END	
GO

-- check if FK_dbo_Referral_Hiv_dbo_YesNoNa_Ref_YesNoNa_RefId exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_Hiv_dbo_YesNoNa_Ref_YesNoNa_RefId')
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Constraint FK_dbo_Referral_Hiv_dbo_YesNoNa_Ref_YesNoNa_RefId';
	ALTER TABLE [dbo].[Referral]
		WITH NOCHECK
		ADD CONSTRAINT FK_dbo_Referral_Hiv_dbo_YesNoNa_Ref_YesNoNa_RefId FOREIGN KEY (Hiv)
		REFERENCES [dbo].[YesNoNa_Ref] (YesNoNa_RefId)
		NOT FOR REPLICATION;
END
GO
-- check if FK_dbo_Referral_Aids_dbo_YesNoNa_Ref_YesNoNa_RefId exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_Aids_dbo_YesNoNa_Ref_YesNoNa_RefId')
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Constraint FK_dbo_Referral_Aids_dbo_YesNoNa_Ref_YesNoNa_RefId';
	ALTER TABLE [dbo].[Referral]
		WITH NOCHECK
		ADD CONSTRAINT FK_dbo_Referral_Aids_dbo_YesNoNa_Ref_YesNoNa_RefId FOREIGN KEY (Aids)
		REFERENCES [dbo].[YesNoNa_Ref] (YesNoNa_RefId)
		NOT FOR REPLICATION;
END
GO
-- check if FK_dbo_Referral_HepB_dbo_YesNoNa_Ref_YesNoNa_RefId exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_HepB_dbo_YesNoNa_Ref_YesNoNa_RefId')
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Constraint FK_dbo_Referral_HepB_dbo_YesNoNa_Ref_YesNoNa_RefId';
	ALTER TABLE [dbo].[Referral]
		WITH NOCHECK
		ADD CONSTRAINT FK_dbo_Referral_HepB_dbo_YesNoNa_Ref_YesNoNa_RefId FOREIGN KEY (HepB)
		REFERENCES [dbo].[YesNoNa_Ref] (YesNoNa_RefId)
		NOT FOR REPLICATION;
END
GO
-- check if FK_dbo_Referral_HepC_dbo_YesNoNa_Ref_YesNoNa_RefId exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_HepC_dbo_YesNoNa_Ref_YesNoNa_RefId')
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Constraint FK_dbo_Referral_HepC_dbo_YesNoNa_Ref_YesNoNa_RefId';
	ALTER TABLE [dbo].[Referral]
		WITH NOCHECK
		ADD CONSTRAINT FK_dbo_Referral_HepC_dbo_YesNoNa_Ref_YesNoNa_RefId FOREIGN KEY (HepC)
		REFERENCES [dbo].[YesNoNa_Ref] (YesNoNa_RefId)
		NOT FOR REPLICATION;
END
GO
-- check if FK_dbo_Referral_Ivda_dbo_YesNoNa_Ref_YesNoNa_RefId exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_Ivda_dbo_YesNoNa_Ref_YesNoNa_RefId')
BEGIN
	PRINT 'ALTERING TABLE Referral Adding Constraint FK_dbo_Referral_Ivda_dbo_YesNoNa_Ref_YesNoNa_RefId';
	ALTER TABLE [dbo].[Referral]
		WITH NOCHECK
		ADD CONSTRAINT FK_dbo_Referral_Ivda_dbo_YesNoNa_Ref_YesNoNa_RefId FOREIGN KEY (Ivda)
		REFERENCES [dbo].[YesNoNa_Ref] (YesNoNa_RefId)
		NOT FOR REPLICATION;
END
GO

-- Reporting only indexes
IF DB_NAME() = '_ReferralProdReport'
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_DonorDeathDateTime')
	CREATE NONCLUSTERED INDEX [IDX_Referral_DonorDeathDateTime] ON [dbo].[Referral]
	(
		[ReferralDonorDeathDate], [ReferralDonorDeathTime]
	)
	INCLUDE([CallID], [ReferralCallerOrganizationID])
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
END
GO