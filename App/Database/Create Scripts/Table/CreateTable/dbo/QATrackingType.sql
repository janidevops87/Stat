SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QATrackingType](
	[QATrackingTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[QATrackingTypeDescription] [varchar](255) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QATrackingType] PRIMARY KEY NONCLUSTERED 
(
	[QATrackingTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingType]'))
ALTER TABLE [dbo].[QATrackingType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingType]'))
ALTER TABLE [dbo].[QATrackingType] CHECK CONSTRAINT [FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingType]'))
ALTER TABLE [dbo].[QATrackingType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATrackingType]'))
ALTER TABLE [dbo].[QATrackingType] CHECK CONSTRAINT [FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID]
GO
