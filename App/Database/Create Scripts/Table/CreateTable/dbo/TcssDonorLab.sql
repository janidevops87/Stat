SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorLab](
	[TcssDonorLabId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListToxicologyScreenId] [int] NULL,
	[Results] [varchar](500) NULL,
	[OtherLabs] [varchar](500) NULL,
	[HbA1c] [decimal](18, 1) NULL,
	[HbA1cDateTime] [smalldatetime] NULL,
 CONSTRAINT [PK_TcssDonorLab] PRIMARY KEY CLUSTERED 
(
	[TcssDonorLabId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]') AND name = N'IX_TcssDonorLab_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorLab_TcssDonorId] ON [dbo].[TcssDonorLab]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorLab_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorLab] ADD  CONSTRAINT [DF_TcssDonorLab_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]'))
ALTER TABLE [dbo].[TcssDonorLab]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]'))
ALTER TABLE [dbo].[TcssDonorLab] CHECK CONSTRAINT [FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]'))
ALTER TABLE [dbo].[TcssDonorLab]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId] FOREIGN KEY([TcssListToxicologyScreenId])
REFERENCES [dbo].[TcssListToxicologyScreen] ([TcssListToxicologyScreenId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLab]'))
ALTER TABLE [dbo].[TcssDonorLab] CHECK CONSTRAINT [FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId]
GO
