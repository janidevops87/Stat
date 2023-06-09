if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BillingAddress]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BillingAddress]
GO

CREATE TABLE [dbo].[BillingAddress] (
	[BillingAddressID] [int] IDENTITY (1, 1) NOT NULL ,
	[BillingAddressName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[QBooksID] [int] NULL ,
	[BillingAddress1] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingAddress2] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingAddress3] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingAddress4] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingAddress5] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingCity] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillingStateID] [int] NULL ,
	[BillingZipCode] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


