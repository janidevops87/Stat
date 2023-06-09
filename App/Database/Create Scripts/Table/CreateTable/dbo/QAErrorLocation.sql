SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorLocation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAErrorLocation](
	[QAErrorLocationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[QAErrorLocationDescription] [varchar](255) NULL,
	[QAErrorLocationActive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QAErrorLocation] PRIMARY KEY NONCLUSTERED 
(
	[QAErrorLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorLocation]'))
ALTER TABLE [dbo].[QAErrorLocation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorLocation]'))
ALTER TABLE [dbo].[QAErrorLocation] CHECK CONSTRAINT [FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorLocation]'))
ALTER TABLE [dbo].[QAErrorLocation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QAErrorLocation]'))
ALTER TABLE [dbo].[QAErrorLocation] CHECK CONSTRAINT [FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID]
GO
