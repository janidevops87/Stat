SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DuplicateSearchRule](
	[DuplicateSearchRuleId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DuplicateSearchRule] [nvarchar](100) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_DuplicateSearchRule] PRIMARY KEY CLUSTERED 
(
	[DuplicateSearchRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_DuplicateSearchRule_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DuplicateSearchRule] ADD  CONSTRAINT [DF_DuplicateSearchRule_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRule]'))
ALTER TABLE [dbo].[DuplicateSearchRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DuplicateSearchRule]'))
ALTER TABLE [dbo].[DuplicateSearchRule] CHECK CONSTRAINT [FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
