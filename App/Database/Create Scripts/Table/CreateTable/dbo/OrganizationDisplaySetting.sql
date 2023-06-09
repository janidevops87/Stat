SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationDisplaySetting](
	[OrganizationDisplaySettingId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[DashBoardDisplaySettingId] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationDisplaySetting] PRIMARY KEY CLUSTERED 
(
	[OrganizationDisplaySettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationDisplaySetting_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationDisplaySetting] ADD  CONSTRAINT [DF_OrganizationDisplaySetting_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting] CHECK CONSTRAINT [FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId] FOREIGN KEY([DashBoardDisplaySettingId])
REFERENCES [dbo].[DashBoardDisplaySetting] ([DashBoardDisplaySettingId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting] CHECK CONSTRAINT [FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDisplaySetting]'))
ALTER TABLE [dbo].[OrganizationDisplaySetting] CHECK CONSTRAINT [FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID]
GO
