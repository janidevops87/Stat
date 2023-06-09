SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorCulture](
	[TcssDonorCultureId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[SampleDateTime] [smalldatetime] NULL,
	[TcssListCultureTypeId] [int] NULL,
	[TcssListCultureResultId] [int] NULL,
	[Comment] [varchar](2500) NULL,
 CONSTRAINT [PK_TcssDonorCulture] PRIMARY KEY CLUSTERED 
(
	[TcssDonorCultureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]') AND name = N'IX_TcssDonorCulture_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorCulture_TcssDonorId] ON [dbo].[TcssDonorCulture]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorCulture_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorCulture] ADD  CONSTRAINT [DF_TcssDonorCulture_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture] CHECK CONSTRAINT [FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId] FOREIGN KEY([TcssListCultureResultId])
REFERENCES [dbo].[TcssListCultureResult] ([TcssListCultureResultId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture] CHECK CONSTRAINT [FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId] FOREIGN KEY([TcssListCultureTypeId])
REFERENCES [dbo].[TcssListCultureType] ([TcssListCultureTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCulture]'))
ALTER TABLE [dbo].[TcssDonorCulture] CHECK CONSTRAINT [FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId]
GO
