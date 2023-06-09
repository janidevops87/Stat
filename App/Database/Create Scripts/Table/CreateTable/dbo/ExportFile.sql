SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExportFile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExportFile](
	[ExportFileID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[WebReportGroupID] [int] NULL,
	[ExportFileDirectoryPath] [varchar](255) NULL,
	[ExportFileRecurringDateType] [int] NULL,
	[ExportFileLastRefresh] [datetime] NULL,
	[ExportFileOn] [tinyint] NULL,
	[ExportFileTypeID] [int] NULL,
	[LastModified] [datetime] NULL,
	[ExportFileFromDate] [datetime] NULL,
	[ExportFileToDate] [datetime] NULL,
	[ExportFileName] [varchar](30) NULL,
	[ExportFileFrequency] [smallint] NULL,
	[ExportFileDateType] [smallint] NULL,
	[ExportFileOccursAt] [varchar](255) NULL,
	[ExportFileFileDateType] [smallint] NULL,
	[ExportFileSeparateFiles] [smallint] NULL,
	[ExportFileTZ] [varchar](2) NULL,
	[UpdatedFlag] [smallint] NULL,
	[CloseCaseTriggerID] [int] NULL,
	[CloseCaseOverride] [int] NULL,
	[ExportFileFrequencyQuantity] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK___1__16] PRIMARY KEY CLUSTERED 
(
	[ExportFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ExportFile_CloseCaseTriggerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ExportFile] ADD  CONSTRAINT [DF_ExportFile_CloseCaseTriggerID]  DEFAULT (0) FOR [CloseCaseTriggerID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ExportFile_CloseCaseOverride]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ExportFile] ADD  CONSTRAINT [DF_ExportFile_CloseCaseOverride]  DEFAULT (0) FOR [CloseCaseOverride]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ExportFile_ExportFileFrequencyQuantity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ExportFile] ADD  CONSTRAINT [DF_ExportFile_ExportFileFrequencyQuantity]  DEFAULT (1) FOR [ExportFileFrequencyQuantity]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile] CHECK CONSTRAINT [FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID] FOREIGN KEY([CloseCaseTriggerID])
REFERENCES [dbo].[CloseCaseTrigger] ([CloseCaseTriggerID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile] CHECK CONSTRAINT [FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID] FOREIGN KEY([ExportFileTypeID])
REFERENCES [dbo].[ExportFileType] ([ExportFileTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile] CHECK CONSTRAINT [FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile] CHECK CONSTRAINT [FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID] FOREIGN KEY([WebReportGroupID])
REFERENCES [dbo].[WebReportGroup] ([WebReportGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFile]'))
ALTER TABLE [dbo].[ExportFile] CHECK CONSTRAINT [FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]
GO
