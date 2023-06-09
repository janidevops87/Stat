SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloseCaseQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CloseCaseQueue](
	[CloseCaseQueueID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[LastModified] [datetime] NULL,
	[ExportFileID] [int] NULL,
	[Enabled] [bit] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseCaseQueue]') AND name = N'CloseCaseQueue_ExportFileID_Enabled')
CREATE CLUSTERED INDEX [CloseCaseQueue_ExportFileID_Enabled] ON [dbo].[CloseCaseQueue]
(
	[ExportFileID] ASC,
	[Enabled] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
