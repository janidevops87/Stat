SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeASP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceCodeASP](
	[SourceCodeASPId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeId] [int] NULL,
	[ASP] [bit] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_SourceCodeASP] PRIMARY KEY CLUSTERED 
(
	[SourceCodeASPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SourceCodeASP_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCodeASP] ADD  CONSTRAINT [DF_SourceCodeASP_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeASP]'))
ALTER TABLE [dbo].[SourceCodeASP]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeASP]'))
ALTER TABLE [dbo].[SourceCodeASP] CHECK CONSTRAINT [FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeASP]'))
ALTER TABLE [dbo].[SourceCodeASP]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeId])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCodeASP]'))
ALTER TABLE [dbo].[SourceCodeASP] CHECK CONSTRAINT [FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID]
GO
