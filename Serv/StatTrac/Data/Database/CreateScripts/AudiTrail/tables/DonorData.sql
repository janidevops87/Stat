if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DonorData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DonorData]
GO

CREATE TABLE [dbo].[DonorData] (
	[DonorDataId] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[DonorDataMiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataLicense] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataAddress] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataCity] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataZip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataNotAvailable] [bit] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[MultipleDonorsFound] [smallint] NULL
) ON [PRIMARY]
GO

 CREATE  INDEX [PK_DonorData] ON [dbo].[DonorData]([DonorDataId]) WITH FILLFACTOR = 90 ON [IDX]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataMiddleName] ON [dbo].[DonorData] ([DonorDataMiddleName]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataLicense] ON [dbo].[DonorData] ([DonorDataLicense]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataAddress] ON [dbo].[DonorData] ([DonorDataAddress]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataCity] ON [dbo].[DonorData] ([DonorDataCity]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataState] ON [dbo].[DonorData] ([DonorDataState]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [DonorDataZip] ON [dbo].[DonorData] ([DonorDataZip]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [LastModified] ON [dbo].[DonorData] ([LastModified]) ')
GO

 CREATE  INDEX [IX_CallId] ON [dbo].[DonorData]([CallID]) WITH  FILLFACTOR = 90 ON [IDX]
GO


