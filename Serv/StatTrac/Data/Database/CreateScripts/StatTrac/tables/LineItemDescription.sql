if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LineItemDescription]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LineItemDescription]
GO

CREATE TABLE [dbo].[LineItemDescription] (
	[LineItemDescriptionID] [int] IDENTITY (1, 1) NOT NULL ,
	[LineItemDescriptionName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LineItemPrice] [decimal](9, 2) NOT NULL ,
	[LineItemProductID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LineItemDescriptionReconcile] [bit] NULL 
) ON [PRIMARY]
GO


