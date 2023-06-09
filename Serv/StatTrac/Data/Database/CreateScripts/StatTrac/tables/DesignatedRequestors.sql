if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DesignatedRequestors]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DesignatedRequestors]
GO

CREATE TABLE [dbo].[DesignatedRequestors] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ORG] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[OrganizationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonID] [int] NULL ,
	[HIST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


