SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorVitalSignDetail](
	[TcssDonorVitalSignDetailId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssDonorVitalSignId] [int] NULL,
	[TcssListVitalSignId] [int] NULL,
	[Answer] [varchar](200) NULL,
 CONSTRAINT [PK_TcssDonorVitalSignDetail] PRIMARY KEY CLUSTERED 
(
	[TcssDonorVitalSignDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]') AND name = N'IX_TcssDonorVitalSignDetail_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorVitalSignDetail_TcssDonorId] ON [dbo].[TcssDonorVitalSignDetail]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorVitalSignDetail_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorVitalSignDetail] ADD  CONSTRAINT [DF_TcssDonorVitalSignDetail_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId] FOREIGN KEY([TcssDonorVitalSignId])
REFERENCES [dbo].[TcssDonorVitalSign] ([TcssDonorVitalSignId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId] FOREIGN KEY([TcssListVitalSignId])
REFERENCES [dbo].[TcssListVitalSign] ([TcssListVitalSignId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignDetail]'))
ALTER TABLE [dbo].[TcssDonorVitalSignDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId]
GO
