if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AlphaPage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AlphaPage]
GO

CREATE TABLE [dbo].[AlphaPage] (
	[AlphaPageId] [int] IDENTITY (1, 1) NOT NULL ,
	[CallId] [int] NULL ,
	[AlphaPageRecipient] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageSender] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageBC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageCC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageSubject] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageBody] [varchar] (7500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AlphaPageCreated] [datetime] NOT NULL ,
	[AlphaPageSent] [datetime] NULL ,
	[AlphaPageComplete] [int] NULL 
) ON [PRIMARY]
GO


