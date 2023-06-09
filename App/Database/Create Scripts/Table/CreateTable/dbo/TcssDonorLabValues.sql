SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorLabValues](
	[TcssDonorLabValuesId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[SampleDateTime] [smalldatetime] NULL,
	[Cpk] [varchar](50) NULL,
	[Ckmb] [varchar](50) NULL,
	[TroponinL] [varchar](50) NULL,
	[TroponinT] [varchar](50) NULL,
 CONSTRAINT [PK_TcssDonorLabValues] PRIMARY KEY CLUSTERED 
(
	[TcssDonorLabValuesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabValues]') AND name = N'IX_TcssDonorLabValues_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorLabValues_TcssDonorId] ON [dbo].[TcssDonorLabValues]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorLabValues_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorLabValues] ADD  CONSTRAINT [DF_TcssDonorLabValues_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabValues]'))
ALTER TABLE [dbo].[TcssDonorLabValues]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabValues]'))
ALTER TABLE [dbo].[TcssDonorLabValues] CHECK CONSTRAINT [FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
