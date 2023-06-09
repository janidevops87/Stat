SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAMonitoringForm](
	[QAMonitoringFormID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[QATrackingTypeID] [int] NULL,
	[QAMonitoringFormName] [varchar](255) NULL,
	[QAMonitoringFormCalculateScore] [smallint] NULL,
	[QAMonitoringFormRequireReview] [smallint] NULL,
	[QAMonitoringFormActive] [smallint] NULL,
	[QAMonitoringFormInactiveComments] [varchar](1000) NULL,
	[QAMonitoringFormScore] [decimal](5, 5) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QAMonitoringForm] PRIMARY KEY NONCLUSTERED 
(
	[QAMonitoringFormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__QAMonitor__QAMon__3DE13B72]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QAMonitoringForm] ADD  DEFAULT (0) FOR [QAMonitoringFormCalculateScore]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__QAMonitor__QAMon__3ED55FAB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QAMonitoringForm] ADD  DEFAULT (0) FOR [QAMonitoringFormRequireReview]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__QAMonitor__QAMon__3FC983E4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QAMonitoringForm] ADD  DEFAULT (1) FOR [QAMonitoringFormActive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm] CHECK CONSTRAINT [FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm] CHECK CONSTRAINT [FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID] FOREIGN KEY([QATrackingTypeID])
REFERENCES [dbo].[QATrackingType] ([QATrackingTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAMonitoringForm]'))
ALTER TABLE [dbo].[QAMonitoringForm] CHECK CONSTRAINT [FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]
GO
