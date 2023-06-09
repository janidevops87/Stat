SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignSummary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorVitalSignSummary](
	[TcssDonorVitalSignSummaryId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[Sao2Initial] [varchar](50) NULL,
	[Sao2Peak] [varchar](50) NULL,
	[Sao2Current] [varchar](50) NULL,
	[Sao2InitialFromDate] [datetime] NULL,
	[Sao2InitialToDate] [datetime] NULL,
	[Sao2PeakFromDate] [datetime] NULL,
	[Sao2PeakToDate] [datetime] NULL,
	[Sao2CurrentFromDate] [datetime] NULL,
	[Sao2CurrentToDate] [datetime] NULL,
 CONSTRAINT [PK_TcssDonorVitalSignSummary] PRIMARY KEY CLUSTERED 
(
	[TcssDonorVitalSignSummaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignSummary]') AND name = N'IX_TcssDonorVitalSignSummary_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorVitalSignSummary_TcssDonorId] ON [dbo].[TcssDonorVitalSignSummary]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorVitalSignSummary_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorVitalSignSummary] ADD  CONSTRAINT [DF_TcssDonorVitalSignSummary_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignSummary]'))
ALTER TABLE [dbo].[TcssDonorVitalSignSummary]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorVitalSignSummary]'))
ALTER TABLE [dbo].[TcssDonorVitalSignSummary] CHECK CONSTRAINT [FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
