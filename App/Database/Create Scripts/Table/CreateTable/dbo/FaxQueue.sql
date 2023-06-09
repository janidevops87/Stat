SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FaxQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FaxQueue](
	[FaxQueueID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FaxQueueCallId] [int] NULL,
	[FaxQueueById] [int] NULL,
	[FaxQueueTo] [varchar](50) NULL,
	[FaxQueueOrg] [varchar](50) NULL,
	[FaxQueueOrgId] [int] NULL,
	[FaxQueueFaxNo] [varchar](11) NULL,
	[FaxQueueSubmitDate] [datetime] NULL,
	[FaxQueueSentDate] [datetime] NULL,
	[FaxQueueJobId] [varchar](50) NULL,
	[FaxQueueConfirmedDate] [datetime] NULL,
	[FaxQueueDeleteDate] [datetime] NULL,
	[FaxQueueDmvTable] [varchar](50) NULL,
	[FaxQueueDmvId] [int] NULL,
	[FaxQueueRegId] [int] NULL,
	[FaxQueueFormName] [varchar](50) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[FaxQueueDSNID] [smallint] NULL,
 CONSTRAINT [PK_FaxQueue] PRIMARY KEY NONCLUSTERED 
(
	[FaxQueueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FaxQueue]') AND name = N'IX_FaxQueue_FaxQueueCallId')
CREATE NONCLUSTERED INDEX [IX_FaxQueue_FaxQueueCallId] ON [dbo].[FaxQueue]
(
	[FaxQueueCallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FaxQueue]') AND name = N'ix_FaxQueue_FaxQueueJobId')
CREATE NONCLUSTERED INDEX [ix_FaxQueue_FaxQueueJobId] ON [dbo].[FaxQueue]
(
	[FaxQueueJobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FaxQueue]') AND name = N'IX_FaxQueue_FaxQueueSentDate')
CREATE NONCLUSTERED INDEX [IX_FaxQueue_FaxQueueSentDate] ON [dbo].[FaxQueue]
(
	[FaxQueueSentDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
