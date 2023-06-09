SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecurityRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecurityRule](
	[SecurityRuleID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SecurityRule] [nvarchar](100) NULL,
	[Expression] [nvarchar](max) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_SecurityRule] PRIMARY KEY CLUSTERED 
(
	[SecurityRuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SecurityRule_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SecurityRule] ADD  CONSTRAINT [DF_SecurityRule_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecurityRule]'))
ALTER TABLE [dbo].[SecurityRule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecurityRule]'))
ALTER TABLE [dbo].[SecurityRule] CHECK CONSTRAINT [FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF EXISTS (SELECT 1 FROM information_schema.columns  
				WHERE table_name = 'SecurityRule'
				AND column_name = 'Expression'
				AND data_type = 'nvarchar'
				AND character_maximum_length <= 4000)
BEGIN
	ALTER TABLE SecurityRule ALTER COLUMN [Expression] NVARCHAR(MAX) NULL;
END
GO
