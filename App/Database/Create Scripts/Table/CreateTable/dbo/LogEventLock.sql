SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogEventLock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogEventLock](
	[CallID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[LogEventOrg] [nvarchar](80) NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LogEventID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEventLock]') AND name = N'IDX_LogEventLock_CallId')
CREATE CLUSTERED INDEX [IDX_LogEventLock_CallId] ON [dbo].[LogEventLock]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_LogEventLock_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LogEventLock] ADD  CONSTRAINT [DF_LogEventLock_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
