if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Race]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Race]
GO

CREATE TABLE [dbo].[Race] (
	[RaceID] [int] IDENTITY (1, 1) NOT NULL ,
	[RaceName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


