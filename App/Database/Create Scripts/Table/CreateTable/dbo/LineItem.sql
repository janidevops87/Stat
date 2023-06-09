SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItem](
	[LineItemID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[LineItemPercentage] [decimal](5, 4) NOT NULL,
	[LineItemOperator] [char](1) NOT NULL,
	[LineItemDescriptionID] [int] NULL,
	[LineItemNumber] [tinyint] NULL,
	[LineItemComment] [varchar](250) NOT NULL,
	[LineItemEnabled] [bit] NULL,
 CONSTRAINT [PK_LineItem] PRIMARY KEY NONCLUSTERED 
(
	[LineItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND name = N'LineItem_LineItemID-InvoiceID')
CREATE NONCLUSTERED INDEX [LineItem_LineItemID-InvoiceID] ON [dbo].[LineItem]
(
	[LineItemID] ASC,
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItem]') AND name = N'LineItem_LineItemID-InvoiceID-DescID')
CREATE NONCLUSTERED INDEX [LineItem_LineItemID-InvoiceID-DescID] ON [dbo].[LineItem]
(
	[InvoiceID] ASC,
	[LineItemDescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_LineItem_LineItemComment]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LineItem] ADD  CONSTRAINT [DF_LineItem_LineItemComment]  DEFAULT (' ') FOR [LineItemComment]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem] CHECK CONSTRAINT [FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID] FOREIGN KEY([LineItemDescriptionID])
REFERENCES [dbo].[LineItemDescription] ([LineItemDescriptionID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItem]'))
ALTER TABLE [dbo].[LineItem] CHECK CONSTRAINT [FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID]
GO
