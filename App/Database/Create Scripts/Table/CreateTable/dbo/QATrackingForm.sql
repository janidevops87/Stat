SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QATrackingForm](
	[QATrackingFormID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QAProcessStepID] [int] NULL,
	[PersonID] [int] NULL,
	[QATrackingEventDateTime] [datetime] NULL,
	[QATrackingCAPANumber] [varchar](20) NULL,
	[QATrackingApproved] [smallint] NULL,
	[QATrackingStatusID] [int] NULL,
	[QATrackingFormPoints] [numeric](5, 4) NULL,
	[QATrackingFormComments] [varchar](1000) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QATrackingForm] PRIMARY KEY NONCLUSTERED 
(
	[QATrackingFormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm] CHECK CONSTRAINT [FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm] CHECK CONSTRAINT [FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID] FOREIGN KEY([QAProcessStepID])
REFERENCES [dbo].[QAProcessStep] ([QAProcessStepID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingForm]'))
ALTER TABLE [dbo].[QATrackingForm] CHECK CONSTRAINT [FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID]
GO
