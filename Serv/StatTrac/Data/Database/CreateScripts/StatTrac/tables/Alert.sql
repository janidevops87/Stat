if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Alert]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Alert]
GO

CREATE TABLE [dbo].[Alert] (
	[AlertID] [int] IDENTITY (1, 1) NOT NULL ,
	[AlertGroupName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlertMessage1] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlertMessage2] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[AlertTypeID] [int] NULL ,
	[AlertLookupCode] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlertScheduleMessage] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[AlertQAMessage1] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlertQAMessage2] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


