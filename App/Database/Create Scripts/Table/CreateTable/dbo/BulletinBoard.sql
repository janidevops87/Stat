SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BulletinBoard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BulletinBoard](
	[BulletinBoardID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Organization] [nvarchar](80) NULL,
	[Alert] [nvarchar](255) NULL,
	[CreateDate] [datetime] NOT NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_BulletinBoard] PRIMARY KEY CLUSTERED 
(
	[BulletinBoardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_BulletinBoard_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BulletinBoard] ADD  CONSTRAINT [DF_BulletinBoard_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BulletinBoard]'))
ALTER TABLE [dbo].[BulletinBoard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BulletinBoard]'))
ALTER TABLE [dbo].[BulletinBoard] CHECK CONSTRAINT [FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BulletinBoard]'))
ALTER TABLE [dbo].[BulletinBoard]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BulletinBoard]'))
ALTER TABLE [dbo].[BulletinBoard] CHECK CONSTRAINT [FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID]
GO
