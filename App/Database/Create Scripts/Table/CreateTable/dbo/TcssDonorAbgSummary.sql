SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorAbgSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorAbgSummary](
	[TcssDonorAbgSummaryId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[HowManyDaysVented] [int] NULL,
 CONSTRAINT [PK_TcssDonorAbgSummary] PRIMARY KEY CLUSTERED 
(
	[TcssDonorAbgSummaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorAbgSummary]') AND name = N'IX_TcssDonorAbgSummary_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorAbgSummary_TcssDonorId] ON [dbo].[TcssDonorAbgSummary]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorAbgSummary_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorAbgSummary] ADD  CONSTRAINT [DF_TcssDonorAbgSummary_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbgSummary]'))
ALTER TABLE [dbo].[TcssDonorAbgSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorAbgSummary]'))
ALTER TABLE [dbo].[TcssDonorAbgSummary] CHECK CONSTRAINT [FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
