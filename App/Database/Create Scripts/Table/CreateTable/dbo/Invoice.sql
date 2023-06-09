SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[BillingAddressID] [int] NULL,
	[InvoiceEnabled] [bit] NOT NULL,
	[InvoiceComment] [varchar](250) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY NONCLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'Invoice_InvoiceID-OrgID-BillingAddrID')
CREATE NONCLUSTERED INDEX [Invoice_InvoiceID-OrgID-BillingAddrID] ON [dbo].[Invoice]
(
	[InvoiceID] ASC,
	[OrganizationID] ASC,
	[BillingAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice]'))
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID] FOREIGN KEY([BillingAddressID])
REFERENCES [dbo].[BillingAddress] ([BillingAddressID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice]'))
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice]'))
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice]'))
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID]
GO
