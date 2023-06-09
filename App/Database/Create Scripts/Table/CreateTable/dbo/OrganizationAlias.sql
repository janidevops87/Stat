SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationAlias](
	[OrganizationAliasId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[OrganizationAliasName] [nvarchar](80) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationAlias] PRIMARY KEY CLUSTERED 
(
	[OrganizationAliasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]') AND name = N'IDX_OrganizationAlias_OrganizationAliasName')
CREATE NONCLUSTERED INDEX [IDX_OrganizationAlias_OrganizationAliasName] ON [dbo].[OrganizationAlias]
(
	[OrganizationAliasName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationAlias_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationAlias] ADD  CONSTRAINT [DF_OrganizationAlias_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]'))
ALTER TABLE [dbo].[OrganizationAlias]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]'))
ALTER TABLE [dbo].[OrganizationAlias] CHECK CONSTRAINT [FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]'))
ALTER TABLE [dbo].[OrganizationAlias]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationAlias]'))
ALTER TABLE [dbo].[OrganizationAlias] CHECK CONSTRAINT [FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID]
GO
