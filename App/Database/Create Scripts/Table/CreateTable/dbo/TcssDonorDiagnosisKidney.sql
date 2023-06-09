SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisKidney](
	[TcssDonorDiagnosisKidneyId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListKidneyId] [int] NULL,
	[TcssListKidneyAorticCuffId] [int] NULL,
	[TcssListKidneyFullVenaId] [int] NULL,
	[Length] [float] NULL,
	[Width] [float] NULL,
	[TcssListKidneyAorticPlaqueId] [int] NULL,
	[TcssListKidneyArterialPlaqueId] [int] NULL,
	[TcssListKidneyInfarctedAreaId] [int] NULL,
	[TcssListKidneyCapsularTearId] [int] NULL,
	[TcssListKidneySubcapsularId] [int] NULL,
	[TcssListKidneyHematomaId] [int] NULL,
	[TcssListKidneyFatCleanedId] [int] NULL,
	[TcssListKidneyCystsDiscolorationId] [int] NULL,
	[TcssListKidneyHorseshoeShapeId] [int] NULL,
	[TcssListKidneyRecoveryBiopsyId] [int] NULL,
	[GlomeruliObserved] [varchar](50) NULL,
	[GlomeruliSclerosed] [varchar](50) NULL,
	[SclerosedPercent] [decimal](18, 2) NULL,
	[TcssListKidneyBiopsyId] [int] NULL,
	[Comment] [varchar](5000) NULL,
	[TcssListKidneyPumpDeviceId] [int] NULL,
	[TcssListKidneyPumpSolutionId] [int] NULL,
	[BiopsyType] [varchar](20) NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisKidney] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisKidneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]') AND name = N'IX_TcssDonorDiagnosisKidney_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisKidney_TcssDonorId] ON [dbo].[TcssDonorDiagnosisKidney]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisKidney_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] ADD  CONSTRAINT [DF_TcssDonorDiagnosisKidney_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId] FOREIGN KEY([TcssListKidneyBiopsyId])
REFERENCES [dbo].[TcssListKidneyBiopsy] ([TcssListKidneyBiopsyId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId] FOREIGN KEY([TcssListKidneyId])
REFERENCES [dbo].[TcssListKidney] ([TcssListKidneyId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId] FOREIGN KEY([TcssListKidneyPumpDeviceId])
REFERENCES [dbo].[TcssListKidneyPumpDevice] ([TcssListKidneyPumpDeviceId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId] FOREIGN KEY([TcssListKidneyPumpSolutionId])
REFERENCES [dbo].[TcssListKidneyPumpSolution] ([TcssListKidneyPumpSolutionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidney]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidney] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId]
GO
