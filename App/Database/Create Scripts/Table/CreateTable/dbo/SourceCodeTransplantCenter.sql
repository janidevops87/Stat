SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceCodeTransplantCenter](
	[SourceCodeTransplantCenterID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeID] [int] NULL,
	[OrganizationID] [int] NULL,
	[TransplantCode] [varchar](50) NULL,
	[OrganizationName] [nvarchar](80) NULL,
	[OrganType] [nvarchar](50) NULL,
	[MessageOrganizationID] [int] NULL,
	[MessageOrganizationName] [nvarchar](80) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_SourceCodeTransplantCenter] PRIMARY KEY CLUSTERED 
(
	[SourceCodeTransplantCenterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SourceCodeTransplantCenter_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCodeTransplantCenter] ADD  CONSTRAINT [DF_SourceCodeTransplantCenter_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter] CHECK CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter] CHECK CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeTransplantCenter]'))
ALTER TABLE [dbo].[SourceCodeTransplantCenter] CHECK CONSTRAINT [FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
