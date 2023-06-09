SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorFluidBlood](
	[TcssDonorFluidBloodId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[IvFluids] [varchar](50) NULL,
	[TcssListDextroseInIvFluidsId] [int] NULL,
	[TcssListSteroidId] [int] NULL,
	[SteroidsDetail] [varchar](50) NULL,
	[TcssListDiureticId] [int] NULL,
	[TcssListT3Id] [int] NULL,
	[TcssListT4Id] [int] NULL,
	[TcssListInsulinId] [int] NULL,
	[InsulinBeginDateTime] [smalldatetime] NULL,
	[InsulinEndDateTime] [smalldatetime] NULL,
	[TcssListAntihypertensiveId] [int] NULL,
	[TcssListVasodilatorId] [int] NULL,
	[TcssListDdavpId] [int] NULL,
	[TcssListArginineVasopressinId] [int] NULL,
	[ArginlineBeginDateTime] [smalldatetime] NULL,
	[ArginlineEndDateTime] [smalldatetime] NULL,
	[TotalParenteralNutrition] [varchar](50) NULL,
	[OtherSpecify1] [varchar](40) NULL,
	[OtherSpecify2] [varchar](40) NULL,
	[OtherSpecify3] [varchar](40) NULL,
	[TcssListNumberOfTransfusionId] [int] NULL,
	[TcssListOtherBloodProductId] [int] NULL,
	[OtherBloodProductsDetails] [varchar](500) NULL,
	[DiureticDetail] [varchar](50) NULL,
	[HeparinBeginDate] [smalldatetime] NULL,
	[HeparinEndDate] [smalldatetime] NULL,
	[HeparinDosage] [varchar](50) NULL,
	[TcssListHeparinId] [int] NULL,
	[TcssListTotalParenteralNutritionId] [int] NULL,
 CONSTRAINT [PK_TcssDonorFluidBlood] PRIMARY KEY CLUSTERED 
(
	[TcssDonorFluidBloodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]') AND name = N'IX_TcssDonorFluidBlood_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorFluidBlood_TcssDonorId] ON [dbo].[TcssDonorFluidBlood]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorFluidBlood_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorFluidBlood] ADD  CONSTRAINT [DF_TcssDonorFluidBlood_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId] FOREIGN KEY([TcssListAntihypertensiveId])
REFERENCES [dbo].[TcssListAntihypertensive] ([TcssListAntihypertensiveId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId] FOREIGN KEY([TcssListArginineVasopressinId])
REFERENCES [dbo].[TcssListArginineVasopressin] ([TcssListArginineVasopressinId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId] FOREIGN KEY([TcssListDdavpId])
REFERENCES [dbo].[TcssListDdavp] ([TcssListDdavpId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId] FOREIGN KEY([TcssListDextroseInIvFluidsId])
REFERENCES [dbo].[TcssListDextroseInIvFluids] ([TcssListDextroseInIvFluidsId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId] FOREIGN KEY([TcssListDiureticId])
REFERENCES [dbo].[TcssListDiuretic] ([TcssListDiureticId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId] FOREIGN KEY([TcssListHeparinId])
REFERENCES [dbo].[TcssListHeparin] ([TcssListHeparinId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId] FOREIGN KEY([TcssListInsulinId])
REFERENCES [dbo].[TcssListInsulin] ([TcssListInsulinId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId] FOREIGN KEY([TcssListNumberOfTransfusionId])
REFERENCES [dbo].[TcssListNumberOfTransfusion] ([TcssListNumberOfTransfusionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId] FOREIGN KEY([TcssListOtherBloodProductId])
REFERENCES [dbo].[TcssListOtherBloodProduct] ([TcssListOtherBloodProductId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId] FOREIGN KEY([TcssListSteroidId])
REFERENCES [dbo].[TcssListSteroid] ([TcssListSteroidId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id] FOREIGN KEY([TcssListT3Id])
REFERENCES [dbo].[TcssListT3] ([TcssListT3Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id] FOREIGN KEY([TcssListT4Id])
REFERENCES [dbo].[TcssListT4] ([TcssListT4Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId] FOREIGN KEY([TcssListVasodilatorId])
REFERENCES [dbo].[TcssListVasodilator] ([TcssListVasodilatorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorFluidBlood]'))
ALTER TABLE [dbo].[TcssDonorFluidBlood] CHECK CONSTRAINT [FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId]
GO
