if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelSecondary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelSecondary]
GO

CREATE TABLE [dbo].[ServiceLevelSecondary] (
	[ServiceLevelID] [int] NOT NULL ,
	[ServiceLevelSecondaryOn] [smallint] NULL ,
	[ServiceLevelSecondaryAlert] [varchar] (750) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelSecondaryHistory] [smallint] NULL ,
	[ServiceLevelSecondaryHemodilution] [smallint] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


