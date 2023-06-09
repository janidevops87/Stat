if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CauseOfDeath]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CauseOfDeath]
GO

CREATE TABLE [dbo].[CauseOfDeath] (
	[CauseOfDeathID] [int] IDENTITY (1, 1) NOT NULL ,
	[CauseOfDeathName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CauseOfDeathOrganPotential] [smallint] NULL ,
	[CauseOfDeathCoronerCase] [smallint] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


