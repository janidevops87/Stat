SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogEvent](
	[LogEventID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[LogEventTypeID] [int] NULL,
	[LogEventDateTime] [smalldatetime] NULL,
	[LogEventNumber] [int] NULL,
	[LogEventName] [varchar](50) NULL,
	[LogEventPhone] [varchar](100) NULL,
	[LogEventOrg] [varchar](80) NULL,
	[LogEventDesc] [varchar](1000) NULL,
	[StatEmployeeID] [int] NULL,
	[LogEventCallbackPending] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[ScheduleGroupID] [int] NULL,
	[PersonID] [int] NULL,
	[OrganizationID] [int] NULL,
	[PhoneID] [int] NULL,
	[LogEventContactConfirmed] [smallint] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LogEventCalloutDateTime] [smalldatetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LogEventDeleted] [bit] NULL,
 CONSTRAINT [PK_LogEvent_1__13] PRIMARY KEY NONCLUSTERED 
(
	[LogEventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_CallID')
CREATE CLUSTERED INDEX [IDX_LogEvent_CallID] ON [dbo].[LogEvent]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_LogEventCallbackPending_LogEventTypeID')
CREATE NONCLUSTERED INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID] ON [dbo].[LogEvent]
(
	[LogEventCallbackPending] ASC,
	[LogEventTypeID] ASC
)
INCLUDE([LogEventID],[CallID],[LogEventDateTime],[LogEventName],[LogEventOrg],[StatEmployeeID],[LogEventCalloutDateTime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_LogEvent_LogEventConta1__24]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LogEvent] ADD  CONSTRAINT [DF_LogEvent_LogEventConta1__24]  DEFAULT (0) FOR [LogEventContactConfirmed]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__LogEvent__LogEve__4226024B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LogEvent] ADD  DEFAULT (0) FOR [LogEventDeleted]
END
GO
