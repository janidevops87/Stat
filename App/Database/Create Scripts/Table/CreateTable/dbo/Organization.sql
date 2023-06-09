SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Organization](
	[OrganizationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationName] [varchar](80) NULL,
	[OrganizationAddress1] [varchar](80) NULL,
	[OrganizationAddress2] [varchar](80) NULL,
	[OrganizationCity] [varchar](30) NULL,
	[StateID] [int] NULL,
	[OrganizationZipCode] [varchar](10) NULL,
	[CountyID] [int] NULL,
	[OrganizationTypeID] [int] NULL,
	[PhoneID] [int] NULL,
	[OrganizationTimeZone] [varchar](2) NULL,
	[OrganizationNotes] [varchar](1000) NULL,
	[OrganizationNoPatientName] [smallint] NULL,
	[OrganizationNoRecordNum] [smallint] NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[OrganizationNoAdmitDateTime] [smallint] NULL,
	[OrganizationNoWeight] [smallint] NULL,
	[OrganizationConfCallCust] [smallint] NULL,
	[Unused2] [smallint] NULL,
	[Unused3] [smallint] NULL,
	[Unused4] [smallint] NULL,
	[Unused5] [smallint] NULL,
	[Unused6] [smallint] NULL,
	[OrganizationPageInterval] [int] NULL,
	[LastModified] [datetime] NULL,
	[Unused8] [smallint] NULL,
	[OrganizationUserCode] [varchar](10) NULL,
	[OrganizationReferralNotes] [ntext] NULL,
	[OrganizationMessageNotes] [ntext] NULL,
	[OrganizationConsentInterval] [int] NULL,
	[OrganizationLO] [smallint] NOT NULL,
	[OrganizationLOEnabled] [smallint] NOT NULL,
	[OrganizationLOType] [int] NULL,
	[OrganizationLOTriageEnabled] [smallint] NULL,
	[OrganizationLOFSEnabled] [smallint] NULL,
	[OrganizationArchive] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[ContractedStatlineClient] [bit] NULL,
	[CountryID] [int] NULL,
	[ProviderNumber] [nvarchar](10) NULL,
	[UnosCode] [nvarchar](4) NULL,
	[OrganizationStatusId] [int] NULL,
	[TimeZoneId] [int] NULL,
	[ObservesDaylightSavings] [bit] NULL,
	[IddId] [int] NULL,
	[CountryCodeId] [int] NULL,
	[StatTracOrganization] [bit] NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_CountyID')
CREATE NONCLUSTERED INDEX [IDX_Organization_CountyID] ON [dbo].[Organization]
(
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_OrganizationName')
CREATE NONCLUSTERED INDEX [IDX_Organization_OrganizationName] ON [dbo].[Organization]
(
	[OrganizationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_OrganizationTypeId_includes')
CREATE NONCLUSTERED INDEX [IDX_Organization_OrganizationTypeId_includes] ON [dbo].[Organization]
(
	[OrganizationTypeID] ASC
)
INCLUDE([OrganizationID],[OrganizationName],[OrganizationLO],[OrganizationLOEnabled],[OrganizationStatusId],[StateID],[CountyID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_StateID_OrganizationTypeID_includes')
CREATE NONCLUSTERED INDEX [IDX_Organization_StateID_OrganizationTypeID_includes] ON [dbo].[Organization]
(
	[StateID] ASC,
	[OrganizationTypeID] ASC
)
INCLUDE([OrganizationID],[OrganizationName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Organizati_Organizatio1__14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organizati_Organizatio1__14]  DEFAULT (0) FOR [OrganizationConfCallCust]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Organization_Unused2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organization_Unused2]  DEFAULT (0) FOR [Unused2]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Organization_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organization_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Organ__68543626]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__Organ__68543626]  DEFAULT (0) FOR [OrganizationLO]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Organ__69485A5F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__Organ__69485A5F]  DEFAULT (0) FOR [OrganizationLOEnabled]
END
GO
--rename constraint, does not match between transactional and reporting
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__StatT__646A0469]') AND type = 'D')
BEGIN
	EXEC sp_rename 'DF__Organizat__StatT__646A0469', 'DF__Organizat__StatT__25E06006', 'Object'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__StatT__25E06006]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__StatT__25E06006] DEFAULT ((0)) FOR [StatTracOrganization]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId] FOREIGN KEY([CountryCodeId])
REFERENCES [dbo].[CountryCode] ([CountryCodeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([COUNTRYID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountyID_dbo_County_CountyID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_CountyID_dbo_County_CountyID] FOREIGN KEY([CountyID])
REFERENCES [dbo].[County] ([CountyID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_CountyID_dbo_County_CountyID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_CountyID_dbo_County_CountyID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_IddId_dbo_Idd_IddId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_IddId_dbo_Idd_IddId] FOREIGN KEY([IddId])
REFERENCES [dbo].[Idd] ([IddId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_IddId_dbo_Idd_IddId]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_IddId_dbo_Idd_IddId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID] FOREIGN KEY([OrganizationStatusId])
REFERENCES [dbo].[OrganizationStatus] ([OrganizationStatusID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID] FOREIGN KEY([OrganizationTypeID])
REFERENCES [dbo].[OrganizationType] ([OrganizationTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID] FOREIGN KEY([PhoneID])
REFERENCES [dbo].[Phone] ([PhoneID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_StateID_dbo_State_StateID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID] FOREIGN KEY([TimeZoneId])
REFERENCES [dbo].[TimeZone] ([TimeZoneID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID]
GO
IF EXISTS (SELECT 1 FROM information_schema.columns  
				WHERE table_name = 'Organization'
				AND column_name = 'OrganizationNotes'
				AND data_type = 'varchar'
				AND character_maximum_length <= 255)
BEGIN
	ALTER TABLE Organization ALTER COLUMN [OrganizationNotes] VARCHAR(1000) NULL;
END
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns  
				WHERE table_name = 'Organization'
				AND column_name = 'FacilityEreferralCode')
BEGIN
	ALTER TABLE Organization ADD [FacilityEreferralCode] VARCHAR(20) NULL;
END
GO
