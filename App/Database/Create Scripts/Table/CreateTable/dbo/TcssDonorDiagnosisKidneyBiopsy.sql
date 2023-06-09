SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyBiopsy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisKidneyBiopsy](
	[TcssDonorDiagnosisKidneyBiopsyId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListKidneyId] [int] NULL,
	[DateTime] [datetime] NULL,
	[Flow] [varchar](50) NULL,
	[PressureSystolic] [varchar](50) NULL,
	[PressureDiastolic] [varchar](50) NULL,
	[Resistance] [varchar](50) NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisKidneyBiopsy] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisKidneyBiopsyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisKidneyBiopsy]') AND name = N'IX_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId] ON [dbo].[TcssDonorDiagnosisKidneyBiopsy]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisKidneyBiopsy_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisKidneyBiopsy] ADD  CONSTRAINT [DF_TcssDonorDiagnosisKidneyBiopsy_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
