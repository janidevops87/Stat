SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisPancreas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorDiagnosisPancreas](
	[TcssDonorDiagnosisPancreasId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[Comment] [varchar](5000) NULL,
 CONSTRAINT [PK_TcssDonorDiagnosisPancreas] PRIMARY KEY CLUSTERED 
(
	[TcssDonorDiagnosisPancreasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisPancreas]') AND name = N'IX_TcssDonorDiagnosisPancreas_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorDiagnosisPancreas_TcssDonorId] ON [dbo].[TcssDonorDiagnosisPancreas]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorDiagnosisPancreas_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorDiagnosisPancreas] ADD  CONSTRAINT [DF_TcssDonorDiagnosisPancreas_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisPancreas]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisPancreas]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorDiagnosisPancreas]'))
ALTER TABLE [dbo].[TcssDonorDiagnosisPancreas] CHECK CONSTRAINT [FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
