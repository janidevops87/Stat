SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisHeart](
	[TcssDonorDiagnosisHeartId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[LvEjectionFraction] [decimal](18, 2) NULL,
	[TcssListDiagnosisHeartMethodId] [int] NULL,
	[ShorteningFraction] [decimal](18, 2) NULL,
	[SeptalWallThickness] [int] NULL,
	[LvPosteriorWallThickness] [int] NULL,
	[Comment] [varchar](5000) NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisHeart] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisHeartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]') AND name = N'IX_TcssDonorDiagnosisHeart_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisHeart_TcssDonorId] ON [dbo].[TcssDonorDiagnosisHeart]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisHeart_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisHeart] ADD  CONSTRAINT [DF_TcssDonorDiagnosisHeart_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisHeart]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisHeart] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisHeart]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId] FOREIGN KEY([TcssListDiagnosisHeartMethodId])
REFERENCES [dbo].[TcssListDiagnosisHeartMethod] ([TcssListDiagnosisHeartMethodId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisHeart]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisHeart] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId]
GO
