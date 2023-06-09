SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItemFormula]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItemFormula](
	[LineItemFormulaID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LineItemFormulaNumber] [tinyint] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[LineItemID] [int] NOT NULL,
	[LineItemFormula] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_LineItemFormula] PRIMARY KEY NONCLUSTERED 
(
	[LineItemFormulaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItemFormula]') AND name = N'LineItem_InvoiceID-LineItemID')
CREATE NONCLUSTERED INDEX [LineItem_InvoiceID-LineItemID] ON [dbo].[LineItemFormula]
(
	[InvoiceID] ASC,
	[LineItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemFormula]'))
ALTER TABLE [dbo].[LineItemFormula]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemFormula]'))
ALTER TABLE [dbo].[LineItemFormula] CHECK CONSTRAINT [FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID]
GO
