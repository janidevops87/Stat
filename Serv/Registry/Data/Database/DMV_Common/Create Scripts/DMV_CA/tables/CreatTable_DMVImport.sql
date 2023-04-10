/* CA DMVIMPORT */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVIMPORT]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	PRINT 'Dropping DMVIMPORT Table'
	drop table [dbo].[DMVIMPORT]
End
GO
	PRINT 'Creating DMVIMPORT Table'
	
CREATE TABLE [DMVIMPORT] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVIMPORTLOGID] [int] NULL ,
	[CAID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FULLNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[COUNTYCODE] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IMPORTDATE] [datetime] NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREATEDATE] [smalldatetime] NULL
	CONSTRAINT [PK_DMVIMPORT] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
) ON [PRIMARY]
GO
