SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempInvoicePriceUpdate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempInvoicePriceUpdate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[LineItemNumber] [int] NULL,
	[LineItemDescriptionID] [int] NULL,
	[LineItemDescriptionName] [nvarchar](250) NULL,
	[LineItemPrice] [float] NULL,
	[NewLineItemDescriptionID] [int] NULL,
	[NewLineItemPrice] [float] NULL
) ON [PRIMARY]
END
GO
