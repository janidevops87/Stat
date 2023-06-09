SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorMedSoc](
	[TcssDonorMedSocId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListHistoryOfDiabetesId] [int] NULL,
	[TcssListHistoryOfCancerId] [int] NULL,
	[TcssListHypertensionHistoryId] [int] NULL,
	[TcssListCompliantWithTreatmentId] [int] NULL,
	[TcssListHistoryOfCoronaryArteryDiseaseId] [int] NULL,
	[TcssListHistoryOfGastrointestinalDiseaseId] [int] NULL,
	[TcssListChestTraumaId] [int] NULL,
	[TcssListCigaretteUseId] [int] NULL,
	[TcssListCigaretteUseContinuedId] [int] NULL,
	[TcssListOtherDrugUseId] [int] NULL,
	[TcssListHeavyAlcoholUseId] [int] NULL,
	[TcssListDonorMeetCdcGuidelinesId] [int] NULL,
	[Comments] [varchar](5000) NULL,
 CONSTRAINT [PK_TcssDonorMedSoc] PRIMARY KEY CLUSTERED 
(
	[TcssDonorMedSocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]') AND name = N'IX_TcssDonorMedSoc_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorMedSoc_TcssDonorId] ON [dbo].[TcssDonorMedSoc]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorMedSoc_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorMedSoc] ADD  CONSTRAINT [DF_TcssDonorMedSoc_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease] FOREIGN KEY([TcssListHistoryOfCoronaryArteryDiseaseId])
REFERENCES [dbo].[TcssListHistoryOfCoronaryArteryDisease] ([TcssListHistoryOfCoronaryArteryDiseaseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId] FOREIGN KEY([TcssListChestTraumaId])
REFERENCES [dbo].[TcssListChestTrauma] ([TcssListChestTraumaId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId] FOREIGN KEY([TcssListCigaretteUseContinuedId])
REFERENCES [dbo].[TcssListCigaretteUseContinued] ([TcssListCigaretteUseContinuedId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId] FOREIGN KEY([TcssListCigaretteUseId])
REFERENCES [dbo].[TcssListCigaretteUse] ([TcssListCigaretteUseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId] FOREIGN KEY([TcssListCompliantWithTreatmentId])
REFERENCES [dbo].[TcssListCompliantWithTreatment] ([TcssListCompliantWithTreatmentId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId] FOREIGN KEY([TcssListDonorMeetCdcGuidelinesId])
REFERENCES [dbo].[TcssListDonorMeetCdcGuidelines] ([TcssListDonorMeetCdcGuidelinesId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId] FOREIGN KEY([TcssListHeavyAlcoholUseId])
REFERENCES [dbo].[TcssListHeavyAlcoholUse] ([TcssListHeavyAlcoholUseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId] FOREIGN KEY([TcssListHistoryOfCancerId])
REFERENCES [dbo].[TcssListHistoryOfCancer] ([TcssListHistoryOfCancerId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId] FOREIGN KEY([TcssListHistoryOfDiabetesId])
REFERENCES [dbo].[TcssListHistoryOfDiabetes] ([TcssListHistoryOfDiabetesId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease] FOREIGN KEY([TcssListHistoryOfGastrointestinalDiseaseId])
REFERENCES [dbo].[TcssListHistoryOfGastrointestinalDisease] ([TcssListHistoryOfGastrointestinalDiseaseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId] FOREIGN KEY([TcssListHypertensionHistoryId])
REFERENCES [dbo].[TcssListHypertensionHistory] ([TcssListHypertensionHistoryId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId] FOREIGN KEY([TcssListOtherDrugUseId])
REFERENCES [dbo].[TcssListOtherDrugUse] ([TcssListOtherDrugUseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedSoc]'))
ALTER TABLE [dbo].[TcssDonorMedSoc] CHECK CONSTRAINT [FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId]
GO
