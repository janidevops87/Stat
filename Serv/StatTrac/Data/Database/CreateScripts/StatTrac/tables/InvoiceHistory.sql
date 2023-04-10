if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InvoiceHistory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[InvoiceHistory]
GO

CREATE TABLE [dbo].[InvoiceHistory] (
	[InvoiceHistoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[InvoiceID] [int] NULL ,
	[BillingAddressID] [int] NULL ,
	[InvoiceDate] [smalldatetime] NULL 
) ON [PRIMARY]
GO


