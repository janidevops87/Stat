SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSign]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorVitalSign](
	[TcssDonorVitalSignId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[FromDateTime] [smalldatetime] NULL,
	[ToDateTime] [smalldatetime] NULL,
 CONSTRAINT [PK_TcssDonorVitalSign] PRIMARY KEY CLUSTERED 
(
	[TcssDonorVitalSignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSign]') AND name = N'IX_TcssDonorVitalSign_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorVitalSign_TcssDonorId] ON [dbo].[TcssDonorVitalSign]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorVitalSign_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorVitalSign] ADD  CONSTRAINT [DF_TcssDonorVitalSign_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSign]'))
ALTER TABLE [dbo].[TcssDonorVitalSign]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSign]'))
ALTER TABLE [dbo].[TcssDonorVitalSign] CHECK CONSTRAINT [FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
