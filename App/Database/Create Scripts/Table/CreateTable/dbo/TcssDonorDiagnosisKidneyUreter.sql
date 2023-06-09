SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisKidneyUreter](
	[TcssDonorDiagnosisKidneyUreterId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListKidneyId] [int] NULL,
	[TcssListKidneyUreterId] [int] NULL,
	[Length] [float] NULL,
	[TcssListKidneyUreterTissueQualityId] [int] NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisKidneyUreter] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisKidneyUreterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]') AND name = N'IX_TcssDonorDiagnosisKidneyUreter_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisKidneyUreter_TcssDonorId] ON [dbo].[TcssDonorDiagnosisKidneyUreter]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisKidneyUreter_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter] ADD  CONSTRAINT [DF_TcssDonorDiagnosisKidneyUreter_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId] FOREIGN KEY([TcssListKidneyId])
REFERENCES [dbo].[TcssListKidney] ([TcssListKidneyId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId] FOREIGN KEY([TcssListKidneyUreterId])
REFERENCES [dbo].[TcssListKidneyUreter] ([TcssListKidneyUreterId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyUreter]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyUreter] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId]
GO
