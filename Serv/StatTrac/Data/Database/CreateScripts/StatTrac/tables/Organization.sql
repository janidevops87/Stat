if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Organization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Organization]
GO

CREATE TABLE [dbo].[Organization] (
	[OrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[OrganizationName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationAddress1] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationAddress2] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationCity] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateID] [int] NULL ,
	[OrganizationZipCode] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CountyID] [int] NULL ,
	[OrganizationTypeID] [int] NULL ,
	[PhoneID] [int] NULL ,
	[OrganizationTimeZone] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationNotes] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationNoPatientName] [smallint] NULL ,
	[OrganizationNoRecordNum] [smallint] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[OrganizationNoAdmitDateTime] [smallint] NULL ,
	[OrganizationNoWeight] [smallint] NULL ,
	[OrganizationConfCallCust] [smallint] NULL ,
	[Unused2] [smallint] NULL ,
	[Unused3] [smallint] NULL ,
	[Unused4] [smallint] NULL ,
	[Unused5] [smallint] NULL ,
	[Unused6] [smallint] NULL ,
	[OrganizationPageInterval] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[Unused8] [smallint] NULL ,
	[OrganizationUserCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationReferralNotes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationMessageNotes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationConsentInterval] [int] NULL ,
	[OrganizationLO] [smallint] NOT NULL ,
	[OrganizationLOEnabled] [smallint] NOT NULL ,
	[OrganizationLOType] [int] NULL ,
	[OrganizationLOTriageEnabled] [smallint] NULL ,
	[OrganizationLOFSEnabled] [smallint] NULL ,
	[OrganizationArchive] [smallint] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


