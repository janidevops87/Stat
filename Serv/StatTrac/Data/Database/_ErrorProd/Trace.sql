/****** Object:  Table [dbo].[Trace]    Script Date: 10/1/2004 3:16:34 PM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Trace]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Trace]
GO

/****** Object:  Table [dbo].[Trace]    Script Date: 10/1/2004 3:16:35 PM ******/
CREATE TABLE [dbo].[Trace] (
	[TraceID] [int] IDENTITY (1, 1) NOT NULL ,
	[EventID] [int] NULL ,
	[Category] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Priority] [int] NOT NULL ,
	[Severity] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Title] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Timestamp] [datetime] NOT NULL ,
	[MachineName] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AppDomainName] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ProcessID] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ProcessName] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ThreadName] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Win32ThreadId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Message] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FormattedMessage] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

