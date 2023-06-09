SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactRoleMergeLog](
	[WebPersonId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[RoleName] [varchar](512) NULL,
	[LastModified] [datetime] NOT NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
	[Hidden] [bit] NULL,
 CONSTRAINT [PK_ContactRoleMergeLog] PRIMARY KEY CLUSTERED 
(
	[WebPersonId] ASC,
	[PersonId] ASC,
	[RoleId] ASC,
	[LastModified] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog] CHECK CONSTRAINT [FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog] CHECK CONSTRAINT [FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog] CHECK CONSTRAINT [FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID] FOREIGN KEY([WebPersonId])
REFERENCES [dbo].[WebPerson] ([WebPersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactRoleMergeLog]'))
ALTER TABLE [dbo].[ContactRoleMergeLog] CHECK CONSTRAINT [FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID]
GO
