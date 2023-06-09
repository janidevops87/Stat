SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSCase]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSCase](
	[FSCaseId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallId] [int] NOT NULL,
	[FSCaseCreateUserId] [int] NULL,
	[FSCaseCreateDateTime] [datetime] NULL,
	[FSCaseOpenUserId] [int] NULL,
	[FSCaseOpenDateTime] [datetime] NULL,
	[FSCaseSysEventsUserId] [int] NULL,
	[FSCaseSysEventsDateTime] [datetime] NULL,
	[FSCaseSecCompUserId] [int] NULL,
	[FSCaseSecCompDateTime] [datetime] NULL,
	[FSCaseApproachUserId] [int] NULL,
	[FSCaseApproachDateTime] [datetime] NULL,
	[FSCaseFinalUserId] [int] NULL,
	[FSCaseFinalDateTime] [datetime] NULL,
	[FSCaseUpdate] [datetime] NULL,
	[FSCaseUserId] [int] NULL,
	[FSCaseBillSecondaryUserID] [int] NULL,
	[FSCaseBillDateTime] [datetime] NULL,
	[FSCaseBillApproachUserID] [int] NULL,
	[FSCaseBillApproachDateTime] [datetime] NULL,
	[FSCaseBillMedSocUserID] [int] NULL,
	[FSCaseBillMedSocDateTime] [datetime] NULL,
	[SecondaryManualBillPersonId] [int] NULL,
	[SecondaryUpdatedFlag] [smallint] NULL,
	[FSCaseTotalTime] [varchar](15) NULL,
	[FSCaseSeconds] [int] NULL,
	[FSCaseBillFamUnavailUserId] [int] NULL,
	[FSCaseBillFamUnavailDateTime] [datetime] NULL,
	[FSCaseBillCryoFormUserId] [int] NULL,
	[FSCaseBillCryoFormDateTime] [datetime] NULL,
	[FSCaseBillApproachCount] [smallint] NULL,
	[FSCaseBillMedSocCount] [smallint] NULL,
	[FSCaseBillCryoFormCount] [smallint] NULL,
	[FSCaseBillOTEPerson] [varchar](50) NULL,
	[FSCaseBillOTEUserID] [smallint] NULL,
	[FSCaseBillOTEDateTime] [datetime] NULL,
	[FSCaseBillOTECount] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_FSCase] PRIMARY KEY NONCLUSTERED 
(
	[FSCaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
) ON [IDX]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FSCase]') AND name = N'IDX_FSCase_CallId')
CREATE CLUSTERED INDEX [IDX_FSCase_CallId] ON [dbo].[FSCase]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FSCase]') AND name = N'IX_FSCase_CallId')
CREATE NONCLUSTERED INDEX [IX_FSCase_CallId] ON [dbo].[FSCase]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FSCase]') AND name = N'IX_FSCase_FSCaseFinalUserId_CallID_FSCaseOpenUserId')
CREATE NONCLUSTERED INDEX [IX_FSCase_FSCaseFinalUserId_CallID_FSCaseOpenUserId] ON [dbo].[FSCase]
(
	[FSCaseFinalUserId] ASC,
	[CallId] ASC,
	[FSCaseOpenUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSCase]'))
ALTER TABLE [dbo].[FSCase]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSCase]'))
ALTER TABLE [dbo].[FSCase] CHECK CONSTRAINT [FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
