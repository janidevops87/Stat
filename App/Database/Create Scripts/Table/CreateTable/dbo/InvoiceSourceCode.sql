SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvoiceSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InvoiceSourceCode](
	[InvoiceID] [float] NULL,
	[LineItemID] [float] NULL,
	[Price] [float] NULL,
	[SourceCode] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
