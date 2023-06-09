if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Navigation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Navigation]
GO

CREATE TABLE [dbo].[Navigation] (
	[NAVID] [int] IDENTITY (20, 1) NOT NULL ,
	[NAVTYPEID] [int] NULL ,
	[HREF] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HREFTEXT] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TARGET] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IMAGE] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IMAGEOVER] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SEQ] [int] NULL ,
	[ACTIVE] [bit] NULL 
) ON [PRIMARY]
GO


