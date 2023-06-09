SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisLung]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisLung](
	[TcssDonorDiagnosisLungId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[DateIntubated] [datetime] NULL,
	[LengthOfRightLung] [decimal](18, 2) NULL,
	[LengthOfLeftLung] [decimal](18, 2) NULL,
	[AorticKnobWidth] [decimal](18, 2) NULL,
	[DiaphragmWidth] [decimal](18, 2) NULL,
	[DistanceRcpaToLcpa] [decimal](18, 2) NULL,
	[ChestCircLandmark] [decimal](18, 2) NULL,
	[TcssListDiagnosisLungChestXrayId] [int] NULL,
	[LeftLungComments] [varchar](500) NULL,
	[RightLungComments] [varchar](5000) NULL,
	[DonorPredictedTotalLungCapacity] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisLung] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisLungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisLung]') AND name = N'IX_TcssDonorDiagnosisLung_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisLung_TcssDonorId] ON [dbo].[TcssDonorDiagnosisLung]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisLung_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisLung] ADD  CONSTRAINT [DF_TcssDonorDiagnosisLung_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisLung]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisLung]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisLung]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisLung] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
