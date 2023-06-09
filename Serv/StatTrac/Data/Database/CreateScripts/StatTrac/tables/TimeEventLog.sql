if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TimeEventLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TimeEventLog]
GO

CREATE TABLE [dbo].[TimeEventLog] (
	[TimeEventLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimeEventLogType] [int] NULL ,
	[TimeEventLogItem] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TimeEventLogNote] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


