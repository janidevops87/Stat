SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QATracking]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QATracking](
	[QATrackingID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[QATrackingTypeID] [int] NULL,
	[QATrackingNumber] [varchar](20) NULL,
	[QATrackingNotes] [varchar](1000) NULL,
	[QATrackingSourceCode] [varchar](15) NULL,
	[QATrackingReferralDateTime] [datetime] NULL,
	[QATrackingReferralTypeID] [int] NULL,
	[QATrackingStatusID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QATracking] PRIMARY KEY NONCLUSTERED 
(
	[QATrackingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QATracking]') AND name = N'IDX_QATracking_QATrackingReferralDateTime')
CREATE NONCLUSTERED INDEX [IDX_QATracking_QATrackingReferralDateTime] ON [dbo].[QATracking]
(
	[QATrackingReferralDateTime] ASC
)
INCLUDE([QATrackingID],[OrganizationID],[QATrackingTypeID],[QATrackingNumber],[QATrackingSourceCode],[QATrackingReferralTypeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking] CHECK CONSTRAINT [FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking] CHECK CONSTRAINT [FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID] FOREIGN KEY([QATrackingStatusID])
REFERENCES [dbo].[QATrackingStatus] ([QATrackingStatusID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking] CHECK CONSTRAINT [FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID] FOREIGN KEY([QATrackingTypeID])
REFERENCES [dbo].[QATrackingType] ([QATrackingTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QATracking]'))
ALTER TABLE [dbo].[QATracking] CHECK CONSTRAINT [FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID]
GO
