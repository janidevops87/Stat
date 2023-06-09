SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracIdentifier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracIdentifier](
	[DonorTracIdentifierID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeID] [int] NULL,
	[DonorTracIdentifier] [varchar](200) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_DonorTracIdentifier] PRIMARY KEY CLUSTERED 
(
	[DonorTracIdentifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_DonorTracIdentifier_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DonorTracIdentifier] ADD  CONSTRAINT [DF_DonorTracIdentifier_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracIdentifier]'))
ALTER TABLE [dbo].[DonorTracIdentifier]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracIdentifier]'))
ALTER TABLE [dbo].[DonorTracIdentifier] CHECK CONSTRAINT [FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracIdentifier]'))
ALTER TABLE [dbo].[DonorTracIdentifier]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracIdentifier]'))
ALTER TABLE [dbo].[DonorTracIdentifier] CHECK CONSTRAINT [FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
