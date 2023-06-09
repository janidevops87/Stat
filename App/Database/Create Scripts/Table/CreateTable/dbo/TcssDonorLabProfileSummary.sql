SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorLabProfileSummary](
	[TcssDonorLabProfileSummaryId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[AlcHbalcInitial] [varchar](50) NULL,
	[AlcHbalcPeak] [varchar](50) NULL,
	[AlcHbalcCurrent] [varchar](50) NULL,
	[AlcHbalcInitialFromDate] [datetime] NULL,
	[AlcHbalcInitialToDate] [datetime] NULL,
	[AlcHbalcPeakFromDate] [datetime] NULL,
	[AlcHbalcPeakToDate] [datetime] NULL,
	[AlcHbalcCurrentFromDate] [datetime] NULL,
	[AlcHbalcCurrentToDate] [datetime] NULL,
 CONSTRAINT [PK_TcssDonorLabProfileSummary] PRIMARY KEY CLUSTERED 
(
	[TcssDonorLabProfileSummaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileSummary]') AND name = N'IX_TcssDonorLabProfileSummary_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorLabProfileSummary_TcssDonorId] ON [dbo].[TcssDonorLabProfileSummary]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorLabProfileSummary_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorLabProfileSummary] ADD  CONSTRAINT [DF_TcssDonorLabProfileSummary_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileSummary]'))
ALTER TABLE [dbo].[TcssDonorLabProfileSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorLabProfileSummary]'))
ALTER TABLE [dbo].[TcssDonorLabProfileSummary] CHECK CONSTRAINT [FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
