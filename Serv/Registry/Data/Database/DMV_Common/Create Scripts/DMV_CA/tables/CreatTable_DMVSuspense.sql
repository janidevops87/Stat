/* CA DMVSUSPENSE */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVSUSPENSE]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	PRINT 'Dropping DMVSUSPENSE Table'
	drop table [dbo].[DMVSUSPENSE]
End
GO

	PRINT 'Creating DMVSUSPENSE Table'
GO

CREATE TABLE [DMVSUSPENSE] (
	[ID] [int] NULL ,
	[DMVIMPORTLOGID] [int] NULL ,
	[CAID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FULLNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IMPORTDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COUNTYCODE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO
