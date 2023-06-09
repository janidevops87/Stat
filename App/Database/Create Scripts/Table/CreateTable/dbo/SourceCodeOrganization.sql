SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceCodeOrganization](
	[SourceCodeOrganizationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeID] [int] NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_SourceCodeOrganization] PRIMARY KEY CLUSTERED 
(
	[SourceCodeOrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]') AND name = N'OrgID')
CREATE NONCLUSTERED INDEX [OrgID] ON [dbo].[SourceCodeOrganization]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]') AND name = N'SourceCodeID')
CREATE NONCLUSTERED INDEX [SourceCodeID] ON [dbo].[SourceCodeOrganization]
(
	[SourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SourceCodeOrganization_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCodeOrganization] ADD  CONSTRAINT [DF_SourceCodeOrganization_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization] CHECK CONSTRAINT [FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization] CHECK CONSTRAINT [FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeOrganization]'))
ALTER TABLE [dbo].[SourceCodeOrganization] CHECK CONSTRAINT [FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
