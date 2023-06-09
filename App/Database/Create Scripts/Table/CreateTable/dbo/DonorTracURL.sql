SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracURL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracURL](
	[DonorTracURLID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DonorTracProductionURL] [varchar](100) NULL,
	[SourceCode] [varchar](50) NULL,
	[SourceCodeID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_DonorTracURL] PRIMARY KEY CLUSTERED 
(
	[DonorTracURLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_DonorTracURL_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DonorTracURL] ADD  CONSTRAINT [DF_DonorTracURL_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracURL]'))
ALTER TABLE [dbo].[DonorTracURL]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracURL]'))
ALTER TABLE [dbo].[DonorTracURL] CHECK CONSTRAINT [FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracURL]'))
ALTER TABLE [dbo].[DonorTracURL]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracURL]'))
ALTER TABLE [dbo].[DonorTracURL] CHECK CONSTRAINT [FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
