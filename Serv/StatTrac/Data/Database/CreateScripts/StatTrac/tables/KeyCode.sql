if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KeyCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KeyCode]
GO

CREATE TABLE [dbo].[KeyCode] (
	[KeyCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[KeyCodeName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[KeyCodeNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


