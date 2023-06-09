if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LifeBreachEmail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LifeBreachEmail]
GO

CREATE TABLE [dbo].[LifeBreachEmail] (
	[ReportGroupMaster] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[PersonName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[emailAddress] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RepeatMin] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RepeatString] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


