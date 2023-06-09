SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InvoiceHistory](
	[InvoiceHistoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[InvoiceID] [int] NULL,
	[BillingAddressID] [int] NULL,
	[InvoiceDate] [smalldatetime] NULL,
 CONSTRAINT [PK_InvoiceHistory] PRIMARY KEY NONCLUSTERED 
(
	[InvoiceHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]') AND name = N'IDX_InvoiceHistory_InvoiceID_InvoiceDate')
CREATE NONCLUSTERED INDEX [IDX_InvoiceHistory_InvoiceID_InvoiceDate] ON [dbo].[InvoiceHistory]
(
	[InvoiceID] ASC,
	[InvoiceDate] ASC
)
INCLUDE([InvoiceHistoryID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]'))
ALTER TABLE [dbo].[InvoiceHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID] FOREIGN KEY([BillingAddressID])
REFERENCES [dbo].[BillingAddress] ([BillingAddressID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]'))
ALTER TABLE [dbo].[InvoiceHistory] CHECK CONSTRAINT [FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]'))
ALTER TABLE [dbo].[InvoiceHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[InvoiceHistory]'))
ALTER TABLE [dbo].[InvoiceHistory] CHECK CONSTRAINT [FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID]
GO
