if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StagingLifeBreacharchive]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StagingLifeBreacharchive]
GO

CREATE TABLE [dbo].[StagingLifeBreacharchive] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[PersonID] [int] NULL ,
	[PersonName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BreachedName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EmailAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferralTime] [datetime] NULL ,
	[ReferralID] [int] NULL ,
	[RunTime] [datetime] NULL 
) ON [PRIMARY]
GO


