if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrgImport]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrgImport]
GO

CREATE TABLE [dbo].[OrgImport] (
	[orgimportid] [int] NOT NULL ,
	[CountyName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AreaCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Prefix] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DNIT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Column] [float] NULL ,
	[Order] [float] NULL ,
	[City, State, Zip] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Phone number] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


