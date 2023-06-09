if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LogEventType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LogEventType]
GO

CREATE TABLE [dbo].[LogEventType] (
	[LogEventTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[LogEventTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[EventColor] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


