SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Invoice_backup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Invoice_backup](
	[InvoiceID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[BillingAddressID] [int] NULL,
	[InvoiceEnabled] [bit] NOT NULL,
	[InvoiceComment] [varchar](250) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID] FOREIGN KEY([BillingAddressID])
REFERENCES [dbo].[BillingAddress] ([BillingAddressID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup] CHECK CONSTRAINT [FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup] CHECK CONSTRAINT [FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Invoice_backup]'))
ALTER TABLE [dbo].[Invoice_backup] CHECK CONSTRAINT [FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID]
GO
