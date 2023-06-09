SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorLabProfileDetail](
	[TcssDonorLabProfileDetailId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssDonorLabProfileId] [int] NULL,
	[TcssListLabId] [int] NULL,
	[Answer] [varchar](50) NULL,
 CONSTRAINT [PK_TcssDonorLabProfileDetail] PRIMARY KEY CLUSTERED 
(
	[TcssDonorLabProfileDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]') AND name = N'IX_TcssDonorLabProfileDetail_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorLabProfileDetail_TcssDonorId] ON [dbo].[TcssDonorLabProfileDetail]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorLabProfileDetail_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorLabProfileDetail] ADD  CONSTRAINT [DF_TcssDonorLabProfileDetail_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId] FOREIGN KEY([TcssDonorLabProfileId])
REFERENCES [dbo].[TcssDonorLabProfile] ([TcssDonorLabProfileId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId] FOREIGN KEY([TcssListLabId])
REFERENCES [dbo].[TcssListLab] ([TcssListLabId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileDetail]'))
ALTER TABLE [dbo].[TcssDonorLabProfileDetail] CHECK CONSTRAINT [FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId]
GO
