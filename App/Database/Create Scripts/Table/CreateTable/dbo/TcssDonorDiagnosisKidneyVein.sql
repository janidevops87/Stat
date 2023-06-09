SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisKidneyVein](
	[TcssDonorDiagnosisKidneyVeinId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListKidneyId] [int] NULL,
	[TcssListKidneyVeinId] [int] NULL,
	[Length] [float] NULL,
	[Diameter] [float] NULL,
	[Distance] [float] NULL,
	[VeinsOnVenaCava] [bit] NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisKidneyVein] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisKidneyVeinId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]') AND name = N'IX_TcssDonorDiagnosisKidneyVein_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisKidneyVein_TcssDonorId] ON [dbo].[TcssDonorDiagnosisKidneyVein]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisKidneyVein_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein] ADD  CONSTRAINT [DF_TcssDonorDiagnosisKidneyVein_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId] FOREIGN KEY([TcssListKidneyId])
REFERENCES [dbo].[TcssListKidney] ([TcssListKidneyId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId] FOREIGN KEY([TcssListKidneyVeinId])
REFERENCES [dbo].[TcssListKidneyVein] ([TcssListKidneyVeinId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyVein]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyVein] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId]
GO
