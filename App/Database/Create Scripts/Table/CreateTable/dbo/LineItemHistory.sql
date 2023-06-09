SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItemHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItemHistory](
	[LineItemHistoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[InvoiceHistoryID] [int] NULL,
	[LineItemNumber] [tinyint] NULL,
	[LineItemHistoryQty] [smallint] NOT NULL,
	[LineItemHistoryDescriptionID] [int] NULL,
	[LineItemHistoryPricePercentage] [decimal](5, 4) NULL,
	[LineItemHistoryPriceOperator] [char](1) NULL,
	[LineItemHistoryComment] [varchar](250) NULL,
	[LineItemHistoryEnabled] [bit] NULL,
 CONSTRAINT [PK_LineItemHistory] PRIMARY KEY NONCLUSTERED 
(
	[LineItemHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LineItemHistory]') AND name = N'IDX_LineItemHistory_InvoiceHistoryID')
CREATE NONCLUSTERED INDEX [IDX_LineItemHistory_InvoiceHistoryID] ON [dbo].[LineItemHistory]
(
	[InvoiceHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemHistory]'))
ALTER TABLE [dbo].[LineItemHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID] FOREIGN KEY([InvoiceHistoryID])
REFERENCES [dbo].[InvoiceHistory] ([InvoiceHistoryID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[LineItemHistory]'))
ALTER TABLE [dbo].[LineItemHistory] CHECK CONSTRAINT [FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID]
GO
