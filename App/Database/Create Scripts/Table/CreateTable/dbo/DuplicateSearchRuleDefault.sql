SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DuplicateSearchRuleDefault](
	[DuplicateSearchRuleDefaultID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DuplicateSearchRuleID] [int] NULL,
	[CallTypeID] [int] NULL,
	[NumberOfDaysToSearch] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault] CHECK CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID] FOREIGN KEY([CallTypeID])
REFERENCES [dbo].[CallType] ([CallTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault] CHECK CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId] FOREIGN KEY([DuplicateSearchRuleID])
REFERENCES [dbo].[DuplicateSearchRule] ([DuplicateSearchRuleId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRuleDefault]'))
ALTER TABLE [dbo].[DuplicateSearchRuleDefault] CHECK CONSTRAINT [FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId]
GO
