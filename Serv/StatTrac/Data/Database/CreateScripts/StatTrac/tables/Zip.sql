if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Zip]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Zip]
GO

CREATE TABLE [dbo].[Zip] (
	[ZipID] [int] IDENTITY (1, 1) NOT NULL ,
	[Zip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ZipCountyFIPS] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ZipStateAbbrv] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ZipCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZipCityUSPSPreferred] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZipCountyName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateID] [int] NULL ,
	[ZipSource] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


