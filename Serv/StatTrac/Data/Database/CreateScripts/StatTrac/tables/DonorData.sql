if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DonorData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DonorData]
GO

CREATE TABLE [dbo].[DonorData] (
	[DonorDataId] [int] IDENTITY (1, 1) NOT NULL ,
	[CallID] [int] NULL ,
	[DonorDataMiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataLicense] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataAddress] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataCity] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataZip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorDataNotAvailable] [bit] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


