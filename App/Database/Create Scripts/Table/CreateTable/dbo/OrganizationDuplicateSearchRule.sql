SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationDuplicateSearchRule](
	[OrganizationDuplicateSearchRuleId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[DuplicateSearchRuleId] [int] NULL,
	[CallTypeID] [int] NULL,
	[NumberOfDaysToSearch] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationDuplicateSearchRule] PRIMARY KEY CLUSTERED 
(
	[OrganizationDuplicateSearchRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationDuplicateSearchRule_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] ADD  CONSTRAINT [DF_OrganizationDuplicateSearchRule_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] CHECK CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID] FOREIGN KEY([CallTypeID])
REFERENCES [dbo].[CallType] ([CallTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] CHECK CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId] FOREIGN KEY([DuplicateSearchRuleId])
REFERENCES [dbo].[DuplicateSearchRule] ([DuplicateSearchRuleId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] CHECK CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDuplicateSearchRule]'))
ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] CHECK CONSTRAINT [FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID]
GO
