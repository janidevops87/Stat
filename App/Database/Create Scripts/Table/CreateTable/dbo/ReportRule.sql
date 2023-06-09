SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportRule](
	[ReportRuleID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[RoleID] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_ReportRule] PRIMARY KEY CLUSTERED 
(
	[ReportRuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ReportRule]') AND name = N'FK_RolesID')
CREATE NONCLUSTERED INDEX [FK_RolesID] ON [dbo].[ReportRule]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule] CHECK CONSTRAINT [FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportRule_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule] CHECK CONSTRAINT [FK_dbo_ReportRule_ReportID_dbo_Report_ReportID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportRule]'))
ALTER TABLE [dbo].[ReportRule] CHECK CONSTRAINT [FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID]
GO
