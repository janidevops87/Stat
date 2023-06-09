SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAErrorType](
	[QAErrorTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[QATrackingTypeID] [int] NULL,
	[QAErrorLocationID] [int] NULL,
	[QAErrorTypeDescription] [varchar](255) NULL,
	[QAErrorRequireReview] [smallint] NULL,
	[QAErrorTypeActive] [smallint] NULL,
	[QAErrorTypeInactiveComments] [varchar](1000) NULL,
	[QAErrorTypeAssignedPoints] [int] NULL,
	[QAErrorTypeAutomaticZeroScore] [smallint] NULL,
	[QAErrorTypeDisplayNA] [smallint] NULL,
	[QAErrorTypeDisplayComments] [smallint] NULL,
	[QAErrorTypeGenerateLogIfNo] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[QAErrorTypeGenerateLogIfYes] [smallint] NOT NULL,
 CONSTRAINT [PK_QAErrorType] PRIMARY KEY NONCLUSTERED 
(
	[QAErrorTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__QAErrorTy__QAErr__2C4C9B1C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QAErrorType] ADD  DEFAULT (0) FOR [QAErrorTypeGenerateLogIfYes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType] CHECK CONSTRAINT [FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType] CHECK CONSTRAINT [FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID] FOREIGN KEY([QAErrorLocationID])
REFERENCES [dbo].[QAErrorLocation] ([QAErrorLocationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType] CHECK CONSTRAINT [FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID] FOREIGN KEY([QATrackingTypeID])
REFERENCES [dbo].[QATrackingType] ([QATrackingTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorType]'))
ALTER TABLE [dbo].[QAErrorType] CHECK CONSTRAINT [FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]
GO
