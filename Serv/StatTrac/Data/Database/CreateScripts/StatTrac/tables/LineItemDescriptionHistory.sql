if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LineItemDescriptionHistory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LineItemDescriptionHistory]
GO

CREATE TABLE [dbo].[LineItemDescriptionHistory] (
	[LineItemDescriptionHistoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[LineItemDescriptionHistoryName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LineItemDescriptionHistoryProductID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LineItemDescriptionPrice] [decimal](9, 2) NOT NULL 
) ON [PRIMARY]
GO


