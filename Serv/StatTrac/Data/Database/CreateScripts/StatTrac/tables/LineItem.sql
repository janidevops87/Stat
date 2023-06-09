if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LineItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LineItem]
GO

CREATE TABLE [dbo].[LineItem] (
	[LineItemID] [int] IDENTITY (1, 1) NOT NULL ,
	[InvoiceID] [int] NOT NULL ,
	[LineItemPercentage] [decimal](5, 4) NOT NULL ,
	[LineItemOperator] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LineItemDescriptionID] [int] NULL ,
	[LineItemNumber] [tinyint] NULL ,
	[LineItemComment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LineItemEnabled] [bit] NULL 
) ON [PRIMARY]
GO


