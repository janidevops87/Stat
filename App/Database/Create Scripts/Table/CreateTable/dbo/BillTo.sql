SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillTo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BillTo](
	[BillToID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Address1] [nvarchar](80) NULL,
	[Address2] [nvarchar](80) NULL,
	[City] [nvarchar](30) NULL,
	[StateID] [int] NULL,
	[PostalCode] [nvarchar](10) NULL,
	[CountryID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_BillTo] PRIMARY KEY CLUSTERED 
(
	[BillToID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_BillTo_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BillTo] ADD  CONSTRAINT [DF_BillTo_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo] CHECK CONSTRAINT [FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([COUNTRYID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo] CHECK CONSTRAINT [FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo] CHECK CONSTRAINT [FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_BillTo_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_BillTo_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[BillTo]'))
ALTER TABLE [dbo].[BillTo] CHECK CONSTRAINT [FK_dbo_BillTo_StateID_dbo_State_StateID]
GO
