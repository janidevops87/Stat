SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryDisposition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecondaryDisposition](
	[SecondaryDispositionID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NOT NULL,
	[SubCriteriaID] [int] NOT NULL,
	[SecondaryDispositionAppropriate] [smallint] NULL,
	[SecondaryDispositionApproach] [smallint] NULL,
	[SecondaryDispositionConsent] [smallint] NULL,
	[SecondaryDispositionConversion] [smallint] NULL,
	[SecondaryDispositionCRO] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_SecondaryDisposition] PRIMARY KEY NONCLUSTERED 
(
	[SecondaryDispositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryDisposition]') AND name = N'IDX_SecondaryDisposition_CallId')
CREATE CLUSTERED INDEX [IDX_SecondaryDisposition_CallId] ON [dbo].[SecondaryDisposition]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryDisposition]'))
ALTER TABLE [dbo].[SecondaryDisposition]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryDisposition]'))
ALTER TABLE [dbo].[SecondaryDisposition] CHECK CONSTRAINT [FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
