SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RegistryStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RegistryStatus](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RegistryStatus] [int] NULL,
	[CallID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_RegistryStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RegistryStatus]') AND name = N'IDX_RegistryStatus_CallID')
CREATE NONCLUSTERED INDEX [IDX_RegistryStatus_CallID] ON [dbo].[RegistryStatus]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[RegistryStatus]'))
ALTER TABLE [dbo].[RegistryStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[RegistryStatus]'))
ALTER TABLE [dbo].[RegistryStatus] CHECK CONSTRAINT [FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
