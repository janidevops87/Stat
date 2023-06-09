SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorAbg](
	[TcssDonorAbgId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[SampleDateTime] [smalldatetime] NULL,
	[Ph] [decimal](18, 2) NULL,
	[Pco2] [decimal](18, 2) NULL,
	[Po2] [decimal](18, 2) NULL,
	[Hco3] [decimal](18, 2) NULL,
	[O2sat] [decimal](18, 2) NULL,
	[TcssListVentSettingModeId] [int] NULL,
	[ModeOther] [varchar](50) NULL,
	[Fio2] [decimal](18, 2) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Vt] [decimal](18, 2) NULL,
	[Peep] [decimal](18, 2) NULL,
	[Pip] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TcssDonorAbg] PRIMARY KEY CLUSTERED 
(
	[TcssDonorAbgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]') AND name = N'IX_TcssDonorAbg_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorAbg_TcssDonorId] ON [dbo].[TcssDonorAbg]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorAbg_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorAbg] ADD  CONSTRAINT [DF_TcssDonorAbg_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]'))
ALTER TABLE [dbo].[TcssDonorAbg]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]'))
ALTER TABLE [dbo].[TcssDonorAbg] CHECK CONSTRAINT [FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]'))
ALTER TABLE [dbo].[TcssDonorAbg]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId] FOREIGN KEY([TcssListVentSettingModeId])
REFERENCES [dbo].[TcssListVentSettingMode] ([TcssListVentSettingModeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbg]'))
ALTER TABLE [dbo].[TcssDonorAbg] CHECK CONSTRAINT [FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId]
GO
