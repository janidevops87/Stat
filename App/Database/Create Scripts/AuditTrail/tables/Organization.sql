/******************************************************************************
**	File: Organization.sql
**	Name: Organization
**	Desc: Create table and add default columns for the table Organization
**	Auth: jegerberich
**	Date: 9/24/2020
**	Revisions:	Date		Name			Description
**				09/24/2020	James Gerberich	Sync up with what's in production
**				09/24/2020	James Gerberich	Added new column FacilityEreferralCode
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Organization]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
/* Create Organization If not exists */	

	CREATE TABLE [dbo].[Organization]
	(
		[OrganizationID] [int] NOT NULL,
		[OrganizationName] [varchar](80) NULL,
		[OrganizationAddress1] [varchar](80) NULL,
		[OrganizationAddress2] [varchar](80) NULL,
		[OrganizationCity] [varchar](30) NULL,
		[StateID] [int] NULL,
		[OrganizationZipCode] [varchar](10) NULL,
		[CountyID] [int] NULL,
		[OrganizationTypeID] [int] NULL,
		[PhoneID] [int] NULL,
		[OrganizationTimeZone] [varchar](3) NULL,
		[OrganizationNotes] [varchar](255) NULL,
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
		[OrganizationLO] [smallint] NULL,
		[OrganizationLOEnabled] [smallint] NULL,
		[OrganizationLOType] [int] NULL,
		[OrganizationLOTriageEnabled] [smallint] NULL,
		[OrganizationLOFSEnabled] [smallint] NULL,
		[OrganizationArchive] [smallint] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL,
		[ContractedStatlineClient] [int] NULL,
		[CountryID] [int] NULL,
		[ProviderNumber] [nvarchar](10) NULL,
		[UnosCode] [nvarchar](4) NULL,
		[OrganizationStatusId] [int] NULL,
		[TimeZoneId] [int] NULL,
		[ObservesDaylightSavings] [int] NULL,
		[IddId] [int] NULL,
		[CountryCodeId] [int] NULL,
		[StatTracOrganization] [int] NULL,
		[FacilityEreferralCode] [VARCHAR](20) NULL
	) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID] FOREIGN KEY([OrganizationTypeID])
REFERENCES [dbo].[OrganizationType] ([OrganizationTypeID])
NOT FOR REPLICATION 
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Organization]'))
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID]
GO

IF NOT EXISTS (SELECT 1 FROM information_schema.columns  
				WHERE table_name = 'Organization'
				AND column_name = 'FacilityEreferralCode')
BEGIN
	ALTER TABLE Organization ADD [FacilityEreferralCode] VARCHAR(20) NULL;
END
GO

--rename constraint, does not match between transactional and reporting
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__StatT__573F8414]') AND type = 'D')
BEGIN
	EXEC sp_rename 'DF__Organizat__StatT__573F8414', 'DF__Organizat__StatT__25E06006', 'Object'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__StatT__25E06006]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__StatT__25E06006] DEFAULT ((0)) FOR [StatTracOrganization]
END
GO
