if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LifeBreachImport]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LifeBreachImport]
GO

CREATE TABLE [dbo].[LifeBreachImport] (
	[Organization] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Id] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


