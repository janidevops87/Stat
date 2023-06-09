 /***************************************************************************************************
**	Name: Organization
**	Desc: Creates new table Organization 
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/7/2011	Bret Knoll		AuditTrail Script
***************************************************************************************************/


/****** Object:  Index [PK_Organization_1__24]    Script Date: 06/25/2009 12:18:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'PK_Organization_1__24')
BEGIN
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_Person_OrganizationID_Organization_OrganizationID]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[Person] DROP CONSTRAINT [FK_Person_OrganizationID_Organization_OrganizationID]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_BillTo_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[BillTo] DROP CONSTRAINT [FK_BillTo_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_SourceCodeOrganization_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[SourceCodeOrganization] DROP CONSTRAINT [FK_SourceCodeOrganization_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_WebReportGroupOrg_OrganizationID_Organization_OrganizationID]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[WebReportGroupOrg] DROP CONSTRAINT [FK_WebReportGroupOrg_OrganizationID_Organization_OrganizationID]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationAlias_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationAlias] DROP CONSTRAINT [FK_OrganizationAlias_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationAspSetting_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationASPSetting] DROP CONSTRAINT [FK_OrganizationAspSetting_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationCaseReview_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationCaseReview] DROP CONSTRAINT [FK_OrganizationCaseReview_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationDashBoardTimer_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationDashBoardTimer] DROP CONSTRAINT [FK_OrganizationDashBoardTimer_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationDisplaySetting_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationDisplaySetting] DROP CONSTRAINT [FK_OrganizationDisplaySetting_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationDuplicateSearchRule_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationDuplicateSearchRule] DROP CONSTRAINT [FK_OrganizationDuplicateSearchRule_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationFsSourceCode_OrganizationId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationFsSourceCode] DROP CONSTRAINT [FK_OrganizationFsSourceCode_OrganizationId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssRecipientOfferInformation_ClientId_Organization_OrganizationId]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[TcssRecipientOfferInformation] DROP CONSTRAINT [FK_TcssRecipientOfferInformation_ClientId_Organization_OrganizationId]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_SourceCodeTransplantCenter_OrganizationID_Organization_OrganizationID]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[SourceCodeTransplantCenter] DROP CONSTRAINT [FK_SourceCodeTransplantCenter_OrganizationID_Organization_OrganizationID]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_OrganizationPhone_OrganizationID_Organization_OrganizationID]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[OrganizationPhone] DROP CONSTRAINT [FK_OrganizationPhone_OrganizationID_Organization_OrganizationID]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_WebReportGroup_OrgHierarchyParentID_Organization_OrganizationID]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[WebReportGroup] DROP CONSTRAINT [FK_WebReportGroup_OrgHierarchyParentID_Organization_OrganizationID]
	END
	IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_ExportFile_Organization]') AND type = 'F')
	BEGIN
		ALTER TABLE [dbo].[ExportFile] DROP CONSTRAINT [FK_ExportFile_Organization]
	END
	
	/****** Object:  Index [PK_Person_1__24]    Script Date: 07/08/2011 08:17:23 ******/
	IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'PK_Organization_1__24' and OBJECTPROPERTY(Object_id(name),'IsConstraint') is null )
		DROP INDEX [PK_Organization_1__24] ON [dbo].[Organization] WITH ( ONLINE = OFF )


	/****** Object:  Index [PK_Organization]    Script Date: 07/08/2011 08:20:45 ******/
	IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'PK_Organization_1__24' and OBJECTPROPERTY(Object_id(name),'IsConstraint') = 1 )
		ALTER TABLE [dbo].[Organization] DROP CONSTRAINT [PK_Organization_1__24]


END	


	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'Organization')
BEGIN
	-- DROP TABLE dbo.Organization
	PRINT 'Creating table Organization'

CREATE TABLE [dbo].[Organization](
	[OrganizationID] [int]  NOT NULL,
	[OrganizationName] [varchar](80) NULL,
	[OrganizationAddress1] [varchar](80) NULL,
	[OrganizationAddress2] [varchar](80) NULL,
	[OrganizationCity] [varchar](30) NULL,
	[StateID] [int] NULL,
	[OrganizationZipCode] [varchar](6) NULL,
	[CountyID] [int] NULL,
	[OrganizationTypeID] [int] NULL,
	[PhoneID] [int] NULL,
	[OrganizationTimeZone] [varchar](2) NULL,
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
	[AuditLogTypeID] [int] NULL
	)
END
GO

GRANT SELECT ON Organization TO PUBLIC
GO

IF EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'Organization')
			AND sys.columns.name = 'OrganizationZipCode'
			AND sys.columns.max_length = 6
			)
BEGIN
	PRINT 'ALTERING TABLE Organization Column OrganizationZipCode'
	ALTER TABLE Organization
		ALTER COLUMN OrganizationZipCode VARCHAR(10) NULL
	
END

IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'Organization')
			AND sys.columns.name = 'ContractedStatlineClient'
			)
BEGIN
	PRINT 'ALTERING TABLE Organization Adding New Columns'
	ALTER TABLE Organization
		ADD ContractedStatlineClient int NULL,
		CountryID INT NULL,
		ProviderNumber NVARCHAR(10) NULL,
		UnosCode NVARCHAR(4) NULL,
		OrganizationStatusId INT NULL,
		TimeZoneId INT NULL
	
END
IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'Organization')
			AND sys.columns.name = 'ObservesDaylightSavings'
			)
BEGIN
	PRINT 'ALTERING TABLE Organization Adding New Columns'
	ALTER TABLE Organization
		ADD ObservesDaylightSavings int NULL	
END
IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'Organization')
			AND sys.columns.name = 'IddId'
			)
BEGIN
	PRINT 'ALTERING TABLE Organization Adding New Columns'
	ALTER TABLE Organization
		ADD IddId INT NULL,
		CountryCodeId INT NULL	
END
IF NOT EXISTS (
			select * from sys.columns where object_id in (select object_id from sys.objects where name = 'Organization')
			AND sys.columns.name = 'StatTracOrganization'
			)
BEGIN
	PRINT 'ALTERING TABLE Organization Adding New Columns'
	ALTER TABLE Organization
		ADD StatTracOrganization int DEFAULT(0) NULL
		
END


if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') 
BEGIN 
	ALTER TABLE Organization SET (LOCK_ESCALATION = TABLE) 
END	