SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExportFileQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExportFileQueue](
	[ExportFileQueueID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[ExportFileID] [int] NULL,
	[Enabled] [bit] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExportFileQueue]') AND name = N'IDX_ExportFileQueue_ExportFileId')
CREATE CLUSTERED INDEX [IDX_ExportFileQueue_ExportFileId] ON [dbo].[ExportFileQueue]
(
	[ExportFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO
