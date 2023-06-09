SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransplantCenter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TransplantCenter](
	[TransplantCenterID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Code] [nvarchar](50) NULL,
	[OrganizationName] [nvarchar](80) NULL,
	[OrganType] [nvarchar](50) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TransplantCenter]'))
ALTER TABLE [dbo].[TransplantCenter]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TransplantCenter]'))
ALTER TABLE [dbo].[TransplantCenter] CHECK CONSTRAINT [FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
