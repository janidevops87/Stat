SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QATrackingStatus](
	[QATrackingStatusID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QATrackingStatusDescription] [varchar](250) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QATrackingStatus] PRIMARY KEY NONCLUSTERED 
(
	[QATrackingStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingStatus]'))
ALTER TABLE [dbo].[QATrackingStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingStatus]'))
ALTER TABLE [dbo].[QATrackingStatus] CHECK CONSTRAINT [FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
