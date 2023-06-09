SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevel](
	[ServiceLevelID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ServiceLevelGroupName] [varchar](80) NULL,
	[ServiceLevelTriageLevel] [smallint] NULL,
	[ServiceLevelOTEMROLevel] [smallint] NULL,
	[ServiceLevelTEMROLevel] [smallint] NULL,
	[ServiceLevelEMROLevel] [smallint] NULL,
	[ServiceLevelLastName] [smallint] NULL,
	[ServiceLevelFirstName] [smallint] NULL,
	[ServiceLevelRecNum] [smallint] NULL,
	[ServiceLevelSSN] [smallint] NULL,
	[ServiceLevelGender] [smallint] NULL,
	[ServiceLevelAge] [smallint] NULL,
	[ServiceLevelWeight] [smallint] NULL,
	[ServiceLevelWeightAgeLimit] [numeric](3, 0) NULL,
	[ServiceLevelRace] [smallint] NULL,
	[ServiceLevelVent] [smallint] NULL,
	[ServiceLevelPrevVentClass] [smallint] NULL,
	[ServiceLevelDead] [smallint] NULL,
	[ServiceLevelDeathDate] [smallint] NULL,
	[ServiceLevelDeathTime] [smallint] NULL,
	[ServiceLevelAdmitDate] [smallint] NULL,
	[ServiceLevelAdmitTime] [smallint] NULL,
	[ServiceLevelCOD] [smallint] NULL,
	[ServiceLevelDOB] [smallint] NULL,
	[ServiceLevelDOA] [smallint] NULL,
	[ServiceLevelCoroner] [smallint] NULL,
	[ServiceLevelAttendingMD] [smallint] NULL,
	[ServiceLevelPronouncingMD] [smallint] NULL,
	[ServiceLevelApproachMethod] [smallint] NULL,
	[ServiceLevelApproachBy] [smallint] NULL,
	[ServiceLevelApproachOTEPrompt] [smallint] NULL,
	[ServiceLevelApproachTEPrompt] [smallint] NULL,
	[ServiceLevelApproachEPrompt] [smallint] NULL,
	[ServiceLevelApproachROPrompt] [smallint] NULL,
	[ServiceLevelNOK] [smallint] NULL,
	[ServiceLevelRelation] [smallint] NULL,
	[ServiceLevelNOKPhone] [smallint] NULL,
	[ServiceLevelNOKAddress] [smallint] NULL,
	[ServiceLevelAppropriateOrgan] [smallint] NULL,
	[ServiceLevelAppropriateBone] [smallint] NULL,
	[ServiceLevelAppropriateTissue] [smallint] NULL,
	[ServiceLevelAppropriateSkin] [smallint] NULL,
	[ServiceLevelAppropriateValves] [smallint] NULL,
	[ServiceLevelAppropriateEyes] [smallint] NULL,
	[ServiceLevelAppropriateRsch] [smallint] NULL,
	[ServiceLevelApproachOrgan] [smallint] NULL,
	[ServiceLevelApproachBone] [smallint] NULL,
	[ServiceLevelApproachTissue] [smallint] NULL,
	[ServiceLevelApproachSkin] [smallint] NULL,
	[ServiceLevelApproachValves] [smallint] NULL,
	[ServiceLevelApproachEyes] [smallint] NULL,
	[ServiceLevelApproachRsch] [smallint] NULL,
	[ServiceLevelConsentOrgan] [smallint] NULL,
	[ServiceLevelConsentBone] [smallint] NULL,
	[ServiceLevelConsentTissue] [smallint] NULL,
	[ServiceLevelConsentSkin] [smallint] NULL,
	[ServiceLevelConsentValves] [smallint] NULL,
	[ServiceLevelConsentEyes] [smallint] NULL,
	[ServiceLevelConsentRsch] [smallint] NULL,
	[ServiceLevelRecoveryOrgan] [smallint] NULL,
	[ServiceLevelRecoveryBone] [smallint] NULL,
	[ServiceLevelRecoveryTissue] [smallint] NULL,
	[ServiceLevelRecoverySkin] [smallint] NULL,
	[ServiceLevelRecoveryValves] [smallint] NULL,
	[ServiceLevelRecoveryEyes] [smallint] NULL,
	[ServiceLevelRecoveryRsch] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[ServiceLevelExcludePrevVent] [smallint] NULL,
	[ServiceLevelCheckRegistry] [smallint] NULL,
	[ServiceLevelDonorIntentFaxYN] [smallint] NULL,
	[ServiceLevelDonorIntentNurseScript] [varchar](255) NULL,
	[ServiceLevelDonorIntentOrganizationId] [int] NULL,
	[ServiceLevelDonorIntentFaxId] [int] NULL,
	[ServiceLevelDonorIntentPersonId] [int] NULL,
	[ServiceLevelDonorIntentRetries] [int] NULL,
	[ServiceLevelDonorIntentDocumentName] [varchar](50) NULL,
	[ServiceLevelRegCheckRegistry] [smallint] NULL,
	[ServiceLevelStatus] [smallint] NULL,
	[WorkingStatusUpdatedFlag] [smallint] NULL,
	[WorkingServiceLevelId] [int] NULL,
	[ServiceLevelEyeCareReminder] [varchar](255) NULL,
	[ServiceLevelHeartBeat] [smallint] NULL,
	[ServiceLevelNOKConsent] [smallint] NULL,
	[ServiceLevelNOKRegistration] [smallint] NULL,
	[ServiceLevelEmailDisposition] [smallint] NULL,
	[ServiceLevelDonorBrainDeathDate] [smallint] NULL,
	[ServiceLevelDonorBrainDeathTime] [smallint] NULL,
	[ServiceLevelPronouncingMDPhone] [smallint] NULL,
	[ServiceLevelAttendingMDPhone] [smallint] NULL,
	[ServiceLevelDOB_ILB] [smallint] NULL,
	[ServiceLevelDonorNameMI] [smallint] NULL,
	[ServiceLevelDonorSpecificCOD] [smallint] NULL,
	[ServiceLevelApproachLevel] [int] NULL,
	[ServiceLevelDisableASPSave] [int] NULL,
	[ServiceLevelAlwaysPopRegistry] [smallint] NULL,
	[ServiceLevelBillSecondaryManualEnable] [smallint] NULL,
	[ServiceLevelBillFamilyApproachManualEnable] [smallint] NULL,
	[ServiceLevelBillMedSocManualEnable] [smallint] NULL,
	[ServiceLevelVerifyWeight] [smallint] NULL,
	[ServiceLevelVerifySex] [smallint] NULL,
	[ServiceLevelBillApproachOnly] [smallint] NULL,
	[ServiceLevelPNEAllowSaveWithoutContactRequired] [smallint] NULL,
	[ServiceLevelDCDPotentialMessageEnabled] [smallint] NOT NULL,
	[ServiceLevelPendingCase] [smallint] NOT NULL,
 CONSTRAINT [PK_ServiceLevel_1__31] PRIMARY KEY CLUSTERED 
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel]') AND name = N'IX_ServiceLevel_ServiceLevelStatus')
CREATE NONCLUSTERED INDEX [IX_ServiceLevel_ServiceLevelStatus] ON [dbo].[ServiceLevel]
(
	[ServiceLevelStatus] ASC
)
INCLUDE([ServiceLevelID],[ServiceLevelGroupName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__4EECC904]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__4EECC904]  DEFAULT (0) FOR [ServiceLevelGroupName]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__4FE0ED3D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__4FE0ED3D]  DEFAULT (0) FOR [ServiceLevelTriageLevel]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__50D51176]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__50D51176]  DEFAULT (0) FOR [ServiceLevelOTEMROLevel]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__51C935AF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__51C935AF]  DEFAULT (0) FOR [ServiceLevelTEMROLevel]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__52BD59E8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__52BD59E8]  DEFAULT (0) FOR [ServiceLevelEMROLevel]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__53B17E21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__53B17E21]  DEFAULT (0) FOR [ServiceLevelLastName]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__54A5A25A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__54A5A25A]  DEFAULT (0) FOR [ServiceLevelFirstName]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5599C693]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5599C693]  DEFAULT (0) FOR [ServiceLevelRecNum]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__568DEACC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__568DEACC]  DEFAULT (0) FOR [ServiceLevelSSN]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__57820F05]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__57820F05]  DEFAULT (0) FOR [ServiceLevelGender]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5876333E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5876333E]  DEFAULT (0) FOR [ServiceLevelAge]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__596A5777]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__596A5777]  DEFAULT (0) FOR [ServiceLevelWeight]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5A5E7BB0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5A5E7BB0]  DEFAULT (0) FOR [ServiceLevelWeightAgeLimit]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5B529FE9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5B529FE9]  DEFAULT (0) FOR [ServiceLevelRace]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5C46C422]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5C46C422]  DEFAULT (0) FOR [ServiceLevelVent]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5D3AE85B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5D3AE85B]  DEFAULT (0) FOR [ServiceLevelPrevVentClass]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5E2F0C94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5E2F0C94]  DEFAULT (0) FOR [ServiceLevelDead]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__5F2330CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__5F2330CD]  DEFAULT (0) FOR [ServiceLevelDeathDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__60175506]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__60175506]  DEFAULT (0) FOR [ServiceLevelDeathTime]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__610B793F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__610B793F]  DEFAULT (0) FOR [ServiceLevelAdmitDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__61FF9D78]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__61FF9D78]  DEFAULT (0) FOR [ServiceLevelAdmitTime]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__62F3C1B1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__62F3C1B1]  DEFAULT (0) FOR [ServiceLevelCOD]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__63E7E5EA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__63E7E5EA]  DEFAULT (0) FOR [ServiceLevelDOB]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__64DC0A23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__64DC0A23]  DEFAULT (0) FOR [ServiceLevelDOA]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__65D02E5C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__65D02E5C]  DEFAULT (0) FOR [ServiceLevelCoroner]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__66C45295]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__66C45295]  DEFAULT (0) FOR [ServiceLevelAttendingMD]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__67B876CE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__67B876CE]  DEFAULT (0) FOR [ServiceLevelPronouncingMD]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__68AC9B07]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__68AC9B07]  DEFAULT (0) FOR [ServiceLevelApproachMethod]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__69A0BF40]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__69A0BF40]  DEFAULT (0) FOR [ServiceLevelApproachBy]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6A94E379]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6A94E379]  DEFAULT (0) FOR [ServiceLevelApproachOTEPrompt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6B8907B2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6B8907B2]  DEFAULT (0) FOR [ServiceLevelApproachTEPrompt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6C7D2BEB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6C7D2BEB]  DEFAULT (0) FOR [ServiceLevelApproachEPrompt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6D715024]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6D715024]  DEFAULT (0) FOR [ServiceLevelApproachROPrompt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6E65745D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6E65745D]  DEFAULT (0) FOR [ServiceLevelNOK]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6F599896]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__6F599896]  DEFAULT (0) FOR [ServiceLevelRelation]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__704DBCCF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__704DBCCF]  DEFAULT (0) FOR [ServiceLevelNOKPhone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7141E108]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7141E108]  DEFAULT (0) FOR [ServiceLevelNOKAddress]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__72360541]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__72360541]  DEFAULT (0) FOR [ServiceLevelAppropriateOrgan]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__732A297A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__732A297A]  DEFAULT (0) FOR [ServiceLevelAppropriateBone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__741E4DB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__741E4DB3]  DEFAULT (0) FOR [ServiceLevelAppropriateTissue]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__751271EC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__751271EC]  DEFAULT (0) FOR [ServiceLevelAppropriateSkin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__76069625]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__76069625]  DEFAULT (0) FOR [ServiceLevelAppropriateValves]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__76FABA5E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__76FABA5E]  DEFAULT (0) FOR [ServiceLevelAppropriateEyes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__77EEDE97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__77EEDE97]  DEFAULT (0) FOR [ServiceLevelAppropriateRsch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__78E302D0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__78E302D0]  DEFAULT (0) FOR [ServiceLevelApproachOrgan]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__79D72709]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__79D72709]  DEFAULT (0) FOR [ServiceLevelApproachBone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7ACB4B42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7ACB4B42]  DEFAULT (0) FOR [ServiceLevelApproachTissue]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7BBF6F7B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7BBF6F7B]  DEFAULT (0) FOR [ServiceLevelApproachSkin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7CB393B4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7CB393B4]  DEFAULT (0) FOR [ServiceLevelApproachValves]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7DA7B7ED]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7DA7B7ED]  DEFAULT (0) FOR [ServiceLevelApproachEyes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7E9BDC26]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7E9BDC26]  DEFAULT (0) FOR [ServiceLevelApproachRsch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__7F90005F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__7F90005F]  DEFAULT (0) FOR [ServiceLevelConsentOrgan]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__00842498]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__00842498]  DEFAULT (0) FOR [ServiceLevelConsentBone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__017848D1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__017848D1]  DEFAULT (0) FOR [ServiceLevelConsentTissue]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__026C6D0A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__026C6D0A]  DEFAULT (0) FOR [ServiceLevelConsentSkin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__03609143]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__03609143]  DEFAULT (0) FOR [ServiceLevelConsentValves]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__0454B57C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__0454B57C]  DEFAULT (0) FOR [ServiceLevelConsentEyes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__0548D9B5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__0548D9B5]  DEFAULT (0) FOR [ServiceLevelConsentRsch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__063CFDEE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__063CFDEE]  DEFAULT (0) FOR [ServiceLevelRecoveryOrgan]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__07312227]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__07312227]  DEFAULT (0) FOR [ServiceLevelRecoveryBone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__08254660]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__08254660]  DEFAULT (0) FOR [ServiceLevelRecoveryTissue]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__09196A99]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__09196A99]  DEFAULT (0) FOR [ServiceLevelRecoverySkin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__0A0D8ED2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__0A0D8ED2]  DEFAULT (0) FOR [ServiceLevelRecoveryValves]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__0B01B30B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__0B01B30B]  DEFAULT (0) FOR [ServiceLevelRecoveryEyes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__0BF5D744]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF__ServiceLe__Servi__0BF5D744]  DEFAULT (0) FOR [ServiceLevelRecoveryRsch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ServiceLevel_ServiceLevelExcludePrevVent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF_ServiceLevel_ServiceLevelExcludePrevVent]  DEFAULT (0) FOR [ServiceLevelExcludePrevVent]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ServiceLevel_ServiceLevelCheckRegistry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF_ServiceLevel_ServiceLevelCheckRegistry]  DEFAULT (0) FOR [ServiceLevelCheckRegistry]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ServiceLevel_ServiceLevelDonorIntentFaxYN]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF_ServiceLevel_ServiceLevelDonorIntentFaxYN]  DEFAULT (0) FOR [ServiceLevelDonorIntentFaxYN]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ServiceLevel_ServiceLevelRegCheckRegistry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [DF_ServiceLevel_ServiceLevelRegCheckRegistry]  DEFAULT (0) FOR [ServiceLevelRegCheckRegistry]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelAlwaysPopRegistry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelAlwaysPopRegistry]  DEFAULT ((-1)) FOR [ServiceLevelAlwaysPopRegistry]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelBillSecondaryManualEnableDflt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelBillSecondaryManualEnableDflt]  DEFAULT (0) FOR [ServiceLevelBillSecondaryManualEnable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelBillFamilyApproachManualEnableDflt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelBillFamilyApproachManualEnableDflt]  DEFAULT (0) FOR [ServiceLevelBillFamilyApproachManualEnable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelBillMedSocManualEnableDflt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelBillMedSocManualEnableDflt]  DEFAULT ((-1)) FOR [ServiceLevelBillMedSocManualEnable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelVerifyWeightEnable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelVerifyWeightEnable]  DEFAULT ((-1)) FOR [ServiceLevelVerifyWeight]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelVerifySexEnable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelVerifySexEnable]  DEFAULT ((-1)) FOR [ServiceLevelVerifySex]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelBillApproachOnlydflt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  CONSTRAINT [ServiceLevelBillApproachOnlydflt]  DEFAULT (0) FOR [ServiceLevelBillApproachOnly]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__4974805D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  DEFAULT ((0)) FOR [ServiceLevelPNEAllowSaveWithoutContactRequired]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__6C9E8C60]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  DEFAULT ((-1)) FOR [ServiceLevelDCDPotentialMessageEnabled]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ServiceLe__Servi__2F2B69CC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ServiceLevel] ADD  DEFAULT ((0)) FOR [ServiceLevelPendingCase]
END
GO
