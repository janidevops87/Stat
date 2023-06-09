if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Permission]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Permission]
GO

CREATE TABLE [dbo].[Permission] (
	[PERMISSIONID] [int] IDENTITY (175, 1) NOT NULL ,
	[PERMISSIONNAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PERMISSIONTYPEID] [int] NULL ,
	[FUNCTIONID] [int] NULL ,
	[PERMISSIONDESCRIPTION] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACTIVE] [bit] NULL 
) ON [PRIMARY]
GO


