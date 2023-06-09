if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LineItemHistory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LineItemHistory]
GO

CREATE TABLE [dbo].[LineItemHistory] (
	[LineItemHistoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[InvoiceHistoryID] [int] NULL ,
	[LineItemNumber] [tinyint] NULL ,
	[LineItemHistoryQty] [smallint] NOT NULL ,
	[LineItemHistoryDescriptionID] [int] NULL ,
	[LineItemHistoryPricePercentage] [decimal](5, 4) NULL ,
	[LineItemHistoryPriceOperator] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LineItemHistoryComment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LineItemHistoryEnabled] [bit] NULL 
) ON [PRIMARY]
GO


