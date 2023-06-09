SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempInvoicepriceList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempInvoicepriceList](
	[OrganizationName] [nvarchar](255) NULL,
	[InvoiceID] [int] NULL,
	[LineItemNumber] [tinyint] NULL,
	[LineItemDescriptionName] [nvarchar](255) NULL,
	[LineItemPrice] [decimal](9, 2) NULL,
	[NewLineItemPrice] [decimal](9, 2) NULL,
	[SourceCode] [nvarchar](125) NULL,
	[LineItemDescriptionID] [int] NULL,
	[lineitemdescriptionReconcile] [bit] NULL
) ON [PRIMARY]
END
GO
