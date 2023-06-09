if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Invoice]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Invoice]
GO

CREATE TABLE [dbo].[Invoice] (
	[InvoiceID] [int] IDENTITY (1, 1) NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[BillingAddressID] [int] NULL ,
	[InvoiceEnabled] [bit] NOT NULL ,
	[InvoiceComment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


