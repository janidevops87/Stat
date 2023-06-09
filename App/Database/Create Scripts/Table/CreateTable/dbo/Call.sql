SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Call](
	[CallID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallNumber] [varchar](15) NULL,
	[CallTypeID] [int] NULL,
	[CallDateTime] [smalldatetime] NULL,
	[StatEmployeeID] [smallint] NULL,
	[CallTotalTime] [varchar](15) NULL,
	[CallTempExclusive] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[CallSeconds] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[CallTemp] [smallint] NULL,
	[SourceCodeID] [int] NULL,
	[CallOpenByID] [int] NULL,
	[CallTempSavedByID] [int] NULL,
	[CallExtension] [numeric](5, 0) NULL,
	[UpdatedFlag] [smallint] NULL,
	[CallOpenByWebPersonId] [int] NULL,
	[RecycleNCFlag] [smallint] NULL,
	[CallActive] [smallint] NULL,
	[CallSaveLastByID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_Call] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallActive')
CREATE NONCLUSTERED INDEX [IDX_Call_CallActive] ON [dbo].[Call]
(
	[CallActive] ASC
)
INCLUDE([CallID],[CallNumber],[CallTypeID],[CallDateTime],[StatEmployeeID],[SourceCodeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallDateTime_CallID_CallActive')
CREATE NONCLUSTERED INDEX [IDX_Call_CallDateTime_CallID_CallActive] ON [dbo].[Call]
(
	[CallDateTime] ASC,
	[CallID] ASC,
	[CallActive] ASC
)
INCLUDE([CallNumber],[StatEmployeeID],[SourceCodeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallTemp')
CREATE NONCLUSTERED INDEX [IDX_Call_CallTemp] ON [dbo].[Call]
(
	[CallTemp] ASC
)
INCLUDE([CallID],[CallNumber],[CallDateTime],[CallTempExclusive],[SourceCodeID],[CallTempSavedByID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallTempSavedByID_CallTemp')
CREATE NONCLUSTERED INDEX [IDX_CallTempSavedByID_CallTemp] ON [dbo].[Call]
(
	[CallTempSavedByID] ASC,
	[CallTemp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_SourceCodeID_CallDateTime_includes')
CREATE NONCLUSTERED INDEX [IDX_Call_SourceCodeID_CallDateTime_includes] ON [dbo].[Call]
(
	[SourceCodeID] ASC,
	[CallDateTime] ASC
)
INCLUDE([CallID],[CallNumber],[StatEmployeeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_CallTempExclusive4__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_CallTempExclusive4__32]  DEFAULT (0) FOR [CallTempExclusive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_Inactive_6__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_Inactive_6__32]  DEFAULT (0) FOR [Inactive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_CallTemp_3__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_CallTemp_3__32]  DEFAULT (0) FOR [CallTemp]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_SourceCodeID_7__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_SourceCodeID_7__32]  DEFAULT (0) FOR [SourceCodeID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_CallOpenByID_2__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_CallOpenByID_2__32]  DEFAULT (0) FOR [CallOpenByID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_CallTempSavedByID5__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_CallTempSavedByID5__32]  DEFAULT (0) FOR [CallTempSavedByID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Call_CallExtension_1__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [DF_Call_CallExtension_1__32]  DEFAULT (0) FOR [CallExtension]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddCallOpenByWebPersonIdDflt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [AddCallOpenByWebPersonIdDflt]  DEFAULT ((-1)) FOR [CallOpenByWebPersonId]
END
GO
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = 'CallID' AND is_nullable = 1)
BEGIN
	ALTER TABLE dbo.Call ALTER COLUMN CallID INT NOT NULL;
END
GO
