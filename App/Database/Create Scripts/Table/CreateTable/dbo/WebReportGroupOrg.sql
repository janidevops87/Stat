SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebReportGroupOrg](
	[WebReportGroupOrgID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[WebReportGroupID] [int] NULL,
	[OrganizationID] [int] NULL,
	[PersonID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_WebReportGroupOrg_1__13] PRIMARY KEY CLUSTERED 
(
	[WebReportGroupOrgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]') AND name = N'OrganizationID')
CREATE NONCLUSTERED INDEX [OrganizationID] ON [dbo].[WebReportGroupOrg]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]') AND name = N'WebReportGroupID')
CREATE NONCLUSTERED INDEX [WebReportGroupID] ON [dbo].[WebReportGroupOrg]
(
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]') AND name = N'WebReportGroupOrg0')
CREATE NONCLUSTERED INDEX [WebReportGroupOrg0] ON [dbo].[WebReportGroupOrg]
(
	[OrganizationID] ASC,
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg] CHECK CONSTRAINT [FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg] CHECK CONSTRAINT [FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID] FOREIGN KEY([WebReportGroupID])
REFERENCES [dbo].[WebReportGroup] ([WebReportGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupOrg]'))
ALTER TABLE [dbo].[WebReportGroupOrg] CHECK CONSTRAINT [FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]
GO
