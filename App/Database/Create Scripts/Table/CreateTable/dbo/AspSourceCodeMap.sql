SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspSourceCodeMap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspSourceCodeMap](
	[AspSourceCodeMapID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeID] [int] NULL,
	[AspSourceCodeID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[AspSourceCodeName] [varchar](10) NULL,
 CONSTRAINT [PK_AspSourceCodeMap] PRIMARY KEY CLUSTERED 
(
	[AspSourceCodeMapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_AspSourceCodeMap_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AspSourceCodeMap] ADD  CONSTRAINT [DF_AspSourceCodeMap_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspSourceCodeMap]'))
ALTER TABLE [dbo].[AspSourceCodeMap]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspSourceCodeMap]'))
ALTER TABLE [dbo].[AspSourceCodeMap] CHECK CONSTRAINT [FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspSourceCodeMap]'))
ALTER TABLE [dbo].[AspSourceCodeMap]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspSourceCodeMap]'))
ALTER TABLE [dbo].[AspSourceCodeMap] CHECK CONSTRAINT [FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
