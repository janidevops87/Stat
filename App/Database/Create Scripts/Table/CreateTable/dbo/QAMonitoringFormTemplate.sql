SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAMonitoringFormTemplate](
	[QAMonitoringFormTemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QAMonitoringFormID] [int] NULL,
	[QAErrorTypeID] [int] NOT NULL,
	[QAMonitoringFormTemplateOrder] [int] NULL,
	[QAMonitoringFormTemplateActive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QAMonitoringFormTemplate] PRIMARY KEY NONCLUSTERED 
(
	[QAMonitoringFormTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate] CHECK CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID] FOREIGN KEY([QAErrorTypeID])
REFERENCES [dbo].[QAErrorType] ([QAErrorTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate] CHECK CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID] FOREIGN KEY([QAMonitoringFormID])
REFERENCES [dbo].[QAMonitoringForm] ([QAMonitoringFormID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringFormTemplate]'))
ALTER TABLE [dbo].[QAMonitoringFormTemplate] CHECK CONSTRAINT [FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID]
GO
