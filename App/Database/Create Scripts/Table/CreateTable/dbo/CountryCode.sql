SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountryCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CountryCode](
	[CountryCodeId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CountryCode] [nvarchar](10) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_CountryCode] PRIMARY KEY CLUSTERED 
(
	[CountryCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CountryCode_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CountryCode] ADD  CONSTRAINT [DF_CountryCode_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CountryCode]'))
ALTER TABLE [dbo].[CountryCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CountryCode]'))
ALTER TABLE [dbo].[CountryCode] CHECK CONSTRAINT [FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CountryCode]'))
ALTER TABLE [dbo].[CountryCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([COUNTRYID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CountryCode]'))
ALTER TABLE [dbo].[CountryCode] CHECK CONSTRAINT [FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID]
GO
