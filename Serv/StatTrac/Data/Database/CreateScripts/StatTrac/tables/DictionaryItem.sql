if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DictionaryItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DictionaryItem]
GO

CREATE TABLE [dbo].[DictionaryItem] (
	[DictionaryItemID] [int] IDENTITY (1, 1) NOT NULL ,
	[DictionaryItemName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


