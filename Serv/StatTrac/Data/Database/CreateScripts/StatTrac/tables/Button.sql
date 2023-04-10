if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Button]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Button]
GO

CREATE TABLE [dbo].[Button] (
	[BUTTONID] [int] IDENTITY (1, 1) NOT NULL ,
	[BUTTONNAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BUTTONSTRING] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BUTTONDESCRIPTION] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


