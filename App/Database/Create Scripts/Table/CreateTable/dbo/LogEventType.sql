SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogEventType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogEventType](
	[LogEventTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LogEventTypeName] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[EventColor] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK_LogEventType_1__13] PRIMARY KEY CLUSTERED 
(
	[LogEventTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEventType]') AND name = N'IDX_LogEventType_LogEventTypeName')
CREATE NONCLUSTERED INDEX [IDX_LogEventType_LogEventTypeName] ON [dbo].[LogEventType]
(
	[LogEventTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__LogEventT__Event__5C8F146D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LogEventType] ADD  DEFAULT ('n/a') FOR [EventColor]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__LogEventTy__Code__5D8338A6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LogEventType] ADD  DEFAULT ('n/a') FOR [Code]
END
GO
