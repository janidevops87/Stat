SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationPhone](
	[OrganizationPhoneID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[PhoneID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
	[SubLocationID] [int] NULL,
	[SubLocationLevelID] [int] NULL,
	[Inactive] [smallint] NOT NULL,
 CONSTRAINT [PK_OrganizationPhone] PRIMARY KEY CLUSTERED 
(
	[OrganizationPhoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]') AND name = N'IDX_OrganizationPhone_PhoneID_includes')
CREATE NONCLUSTERED INDEX [IDX_OrganizationPhone_PhoneID_includes] ON [dbo].[OrganizationPhone]
(
	[PhoneID] ASC
)
INCLUDE([OrganizationID],[SubLocationID],[SubLocationLevelID],[Inactive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]') AND name = N'IX_OrganizationPhone_OrganizationID')
CREATE NONCLUSTERED INDEX [IX_OrganizationPhone_OrganizationID] ON [dbo].[OrganizationPhone]
(
	[OrganizationID] ASC
)
INCLUDE([PhoneID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationPhone_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationPhone] ADD  CONSTRAINT [DF_OrganizationPhone_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
--rename constraint, does not match between transactional and reporting
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Inact__0C42EB99]') AND type = 'D')
BEGIN
	EXEC sp_rename 'DF__Organizat__Inact__0C42EB99', 'DF__Organizat__Inact__2E75A607', 'Object'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Inact__2E75A607]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationPhone] ADD CONSTRAINT [DF__Organizat__Inact__2E75A607] DEFAULT ((0)) FOR [Inactive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone] CHECK CONSTRAINT [FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone] CHECK CONSTRAINT [FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID] FOREIGN KEY([PhoneID])
REFERENCES [dbo].[Phone] ([PhoneID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone] CHECK CONSTRAINT [FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID] FOREIGN KEY([SubLocationID])
REFERENCES [dbo].[SubLocation] ([SubLocationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone] CHECK CONSTRAINT [FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID] FOREIGN KEY([SubLocationLevelID])
REFERENCES [dbo].[SubLocationLevel] ([SubLocationLevelID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationPhone]'))
ALTER TABLE [dbo].[OrganizationPhone] CHECK CONSTRAINT [FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID]
GO

IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[OrganizationPhone]')
	AND syscolumns.name = 'SubLocationLevel'
	)
BEGIN
	PRINT 'ALTERING TABLE OrganizationPhone Adding Column SubLocationLevel';
	ALTER TABLE [OrganizationPhone]
		ADD [SubLocationLevel] varchar(5) NULL;
END	
GO
