SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebPerson]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebPerson](
	[WebPersonID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebPersonUserName] [varchar](15) NULL,
	[PersonID] [int] NULL,
	[WebPersonPassword] [varchar](20) NULL,
	[UnusedField1] [int] NULL,
	[LastModified] [datetime] NULL,
	[WebPersonSessionCounter] [int] NULL,
	[UnusedField2] [int] NULL,
	[WebPersonLastSessionAccess] [smalldatetime] NULL,
	[WebPersonEmail] [varchar](100) NULL,
	[UpdatedFlag] [smallint] NULL,
	[WebPersonUserAgent] [varchar](100) NULL,
	[Access] [int] NOT NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[SaltValue] [varchar](100) NULL,
	[HashedPassword] [varchar](50) NULL,
	[InternalSessionID] [uniqueidentifier] NULL,
	[PasswordExpiration] [datetime] NULL,
 CONSTRAINT [PK_WebPerson] PRIMARY KEY CLUSTERED 
(
	[WebPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebPerson]') AND name = N'IDX_WebPerson_PersonID_includes')
CREATE NONCLUSTERED INDEX [IDX_WebPerson_PersonID_includes] ON [dbo].[WebPerson]
(
	[PersonID] ASC
)
INCLUDE([WebPersonID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebPerson]') AND name = N'IDX_WebPerson_UserName_Password')
CREATE NONCLUSTERED INDEX [IDX_WebPerson_UserName_Password] ON [dbo].[WebPerson]
(
	[WebPersonUserName] ASC,
	[WebPersonPassword] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebPerson_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebPerson] ADD  CONSTRAINT [DF_WebPerson_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebPerson_WebPersonSes1__46]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebPerson] ADD  CONSTRAINT [DF_WebPerson_WebPersonSes1__46]  DEFAULT (0) FOR [WebPersonSessionCounter]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebPerson_Access]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebPerson] ADD  CONSTRAINT [DF_WebPerson_Access]  DEFAULT (511) FOR [Access]
END
GO
IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[WebPerson]') AND syscolumns.name = 'PasswordExpiration')
BEGIN
	PRINT 'ALTERING TABLE WebPerson Adding Column PasswordExpiration';
	ALTER TABLE [WebPerson] ADD [PasswordExpiration] [datetime] NULL;
END	
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPerson]'))
ALTER TABLE [dbo].[WebPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPerson]'))
ALTER TABLE [dbo].[WebPerson] CHECK CONSTRAINT [FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPerson_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPerson]'))
ALTER TABLE [dbo].[WebPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebPerson_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPerson_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPerson]'))
ALTER TABLE [dbo].[WebPerson] CHECK CONSTRAINT [FK_dbo_WebPerson_PersonID_dbo_Person_PersonID]
GO
