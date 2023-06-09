SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationFsSourceCode](
	[OrganizationFsSourceCodeId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[SourceCodeId] [int] NULL,
	[FsSourceCodeId] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationFsSourceCode] PRIMARY KEY CLUSTERED 
(
	[OrganizationFsSourceCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationFsSourceCode_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationFsSourceCode] ADD  CONSTRAINT [DF_OrganizationFsSourceCode_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode] CHECK CONSTRAINT [FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode] CHECK CONSTRAINT [FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeId])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationFsSourceCode]'))
ALTER TABLE [dbo].[OrganizationFsSourceCode] CHECK CONSTRAINT [FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID]
GO
