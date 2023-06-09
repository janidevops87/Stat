SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationASPSetting](
	[OrganizationASPSettingId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[AspSettingTypeId] [int] NULL,
	[LinkToStatlinePhoneSystem] [bit] NULL,
	[AutoDisplaySourceCode] [bit] NULL,
	[AutoDisplaySourceCodeId] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationAspSetting] PRIMARY KEY CLUSTERED 
(
	[OrganizationASPSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationAspSetting_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationASPSetting] ADD  CONSTRAINT [DF_OrganizationAspSetting_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId] FOREIGN KEY([AspSettingTypeId])
REFERENCES [dbo].[AspSettingType] ([AspSettingTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting] CHECK CONSTRAINT [FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting] CHECK CONSTRAINT [FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationASPSetting]'))
ALTER TABLE [dbo].[OrganizationASPSetting] CHECK CONSTRAINT [FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID]
GO
