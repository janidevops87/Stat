if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[County]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[County]
GO

CREATE TABLE [dbo].[County] (
	[CountyID] [int] IDENTITY (1, 1) NOT NULL ,
	[CountyName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateID] [int] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


