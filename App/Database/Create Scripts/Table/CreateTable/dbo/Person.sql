SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Person](
	[PersonID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PersonFirst] [varchar](50) NULL,
	[PersonMI] [varchar](1) NULL,
	[PersonLast] [varchar](50) NULL,
	[PersonTypeID] [int] NULL,
	[OrganizationID] [int] NULL,
	[PersonNotes] [varchar](255) NULL,
	[PersonBusy] [smallint] NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[PersonBusyUntil] [smalldatetime] NULL,
	[PersonTempNoteActive] [smallint] NULL,
	[PersonTempNoteExpires] [smalldatetime] NULL,
	[PersonTempNote] [varchar](255) NULL,
	[Unused] [varchar](30) NULL,
	[UpdatedFlag] [smallint] NULL,
	[AllowInternetScheduleAccess] [smallint] NULL,
	[PersonSecurity] [int] NULL,
	[PersonArchive] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[GenderID] [int] NULL,
	[RaceID] [int] NULL,
	[Credential] [varchar](25) NULL,
	[TrainedRequestorID] [int] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'IDX_Person_OrganizationID_Inactive_includes')
CREATE NONCLUSTERED INDEX [IDX_Person_OrganizationID_Inactive_includes] ON [dbo].[Person]
(
	[OrganizationID] ASC,
	[Inactive] ASC
)
INCLUDE([PersonID],[PersonFirst],[PersonMI],[PersonLast],[PersonTypeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND name = N'IDX_Person_OrganizationID_PersonFirst_PersonLast')
CREATE NONCLUSTERED INDEX [IDX_Person_OrganizationID_PersonFirst_PersonLast] ON [dbo].[Person]
(
	[OrganizationID] ASC,
	[PersonFirst] ASC,
	[PersonLast] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Person_Verified_2__21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Verified_2__21]  DEFAULT (0) FOR [Verified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Person_Inactive_1__21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Inactive_1__21]  DEFAULT (0) FOR [Inactive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Person_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_GenderID_dbo_Gender_GenderID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Person_GenderID_dbo_Gender_GenderID] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_GenderID_dbo_Gender_GenderID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo_Person_GenderID_dbo_Gender_GenderID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID] FOREIGN KEY([PersonTypeID])
REFERENCES [dbo].[PersonType] ([PersonTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_RaceID_dbo_Race_RaceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Person_RaceID_dbo_Race_RaceID] FOREIGN KEY([RaceID])
REFERENCES [dbo].[Race] ([RaceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Person_RaceID_dbo_Race_RaceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Person]'))
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_dbo_Person_RaceID_dbo_Race_RaceID]
GO
