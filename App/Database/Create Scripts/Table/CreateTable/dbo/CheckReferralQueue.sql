SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CheckReferralQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CheckReferralQueue](
	[CheckReferralQueueID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[LastModified] [datetime] NULL,
	[ExportFileID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CheckReferralQueue]') AND name = N'IDX_CheckReferralQueue_CallId_ExportFileId')
CREATE NONCLUSTERED INDEX [IDX_CheckReferralQueue_CallId_ExportFileId] ON [dbo].[CheckReferralQueue]
(
	[ExportFileID] ASC,
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CheckReferralQueue]') AND name = N'IDX_CheckReferralQueue_ExportFileId')
CREATE NONCLUSTERED INDEX [IDX_CheckReferralQueue_ExportFileId] ON [dbo].[CheckReferralQueue]
(
	[ExportFileID] ASC
)
INCLUDE([CallID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
