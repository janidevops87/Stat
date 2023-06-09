SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisKidneyArtery](
	[TcssDonorDiagnosisKidneyArteryId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListKidneyId] [int] NULL,
	[TcssListKidneyArteryId] [int] NULL,
	[Length] [float] NULL,
	[Diameter] [float] NULL,
	[Distance] [float] NULL,
	[ArteriesOnCommonCuff] [bit] NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisKidneyArtery] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisKidneyArteryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]') AND name = N'IX_TcssDonorDiagnosisKidneyArtery_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisKidneyArtery_TcssDonorId] ON [dbo].[TcssDonorDiagnosisKidneyArtery]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisKidneyArtery_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery] ADD  CONSTRAINT [DF_TcssDonorDiagnosisKidneyArtery_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId] FOREIGN KEY([TcssListKidneyArteryId])
REFERENCES [dbo].[TcssListKidneyArtery] ([TcssListKidneyArteryId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId] FOREIGN KEY([TcssListKidneyId])
REFERENCES [dbo].[TcssListKidney] ([TcssListKidneyId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyArtery]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyArtery] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId]
GO
