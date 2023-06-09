SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorUrinalysis](
	[TcssDonorUrinalysisId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[SampleDateTime] [smalldatetime] NULL,
	[Color] [varchar](10) NULL,
	[AppearanceId] [varchar](10) NULL,
	[Ph] [decimal](18, 2) NULL,
	[SpecificGravity] [decimal](18, 2) NULL,
	[TcssListUrinalysisProteinId] [int] NULL,
	[TcssListUrinalysisGlucoseId] [int] NULL,
	[TcssListUrinalysisBloodId] [int] NULL,
	[TcssListUrinalysisRbcId] [int] NULL,
	[TcssListUrinalysisWbcId] [int] NULL,
	[TcssListUrinalysisEpithId] [int] NULL,
	[TcssListUrinalysisCastId] [int] NULL,
	[TcssListUrinalysisBacteriaId] [int] NULL,
	[TcssListUrinalysisLeukocyteId] [int] NULL,
	[TcssUrinalysisProtein] [varchar](50) NULL,
	[TcssUrinalysisGlucose] [varchar](50) NULL,
	[TcssUrinalysisBlood] [varchar](50) NULL,
	[TcssUrinalysisRbc] [varchar](50) NULL,
	[TcssUrinalysisWbc] [varchar](50) NULL,
	[TcssUrinalysisEpith] [varchar](50) NULL,
	[TcssUrinalysisCast] [varchar](50) NULL,
	[TcssUrinalysisBacteria] [varchar](50) NULL,
	[TcssUrinalysisLeukocyte] [varchar](50) NULL,
 CONSTRAINT [PK_TcssDonorUrinalysis] PRIMARY KEY CLUSTERED 
(
	[TcssDonorUrinalysisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]') AND name = N'IX_TcssDonorUrinalysis_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorUrinalysis_TcssDonorId] ON [dbo].[TcssDonorUrinalysis]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorUrinalysis_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorUrinalysis] ADD  CONSTRAINT [DF_TcssDonorUrinalysis_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId] FOREIGN KEY([TcssListUrinalysisBacteriaId])
REFERENCES [dbo].[TcssListUrinalysisBacteria] ([TcssListUrinalysisBacteriaId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId] FOREIGN KEY([TcssListUrinalysisBloodId])
REFERENCES [dbo].[TcssListUrinalysisBlood] ([TcssListUrinalysisBloodId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId] FOREIGN KEY([TcssListUrinalysisCastId])
REFERENCES [dbo].[TcssListUrinalysisCast] ([TcssListUrinalysisCastId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId] FOREIGN KEY([TcssListUrinalysisEpithId])
REFERENCES [dbo].[TcssListUrinalysisEpith] ([TcssListUrinalysisEpithId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId] FOREIGN KEY([TcssListUrinalysisGlucoseId])
REFERENCES [dbo].[TcssListUrinalysisGlucose] ([TcssListUrinalysisGlucoseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId] FOREIGN KEY([TcssListUrinalysisLeukocyteId])
REFERENCES [dbo].[TcssListUrinalysisLeukocyte] ([TcssListUrinalysisLeukocyteId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId] FOREIGN KEY([TcssListUrinalysisProteinId])
REFERENCES [dbo].[TcssListUrinalysisProtein] ([TcssListUrinalysisProteinId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId] FOREIGN KEY([TcssListUrinalysisRbcId])
REFERENCES [dbo].[TcssListUrinalysisRbc] ([TcssListUrinalysisRbcId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId] FOREIGN KEY([TcssListUrinalysisWbcId])
REFERENCES [dbo].[TcssListUrinalysisWbc] ([TcssListUrinalysisWbcId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorUrinalysis]'))
ALTER TABLE [dbo].[TcssDonorUrinalysis] CHECK CONSTRAINT [FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId]
GO
