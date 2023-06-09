SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailType](
	[EmailTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EmailType] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_EmailType] PRIMARY KEY CLUSTERED 
(
	[EmailTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_EmailType_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EmailType] ADD  CONSTRAINT [DF_EmailType_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailType]'))
ALTER TABLE [dbo].[EmailType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailType]'))
ALTER TABLE [dbo].[EmailType] CHECK CONSTRAINT [FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
