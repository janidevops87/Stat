SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceCodeLineItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceCodeLineItem](
	[Organization] [nvarchar](255) NULL,
	[InvoiceID] [float] NULL,
	[LineItemID] [float] NULL,
	[Type] [nvarchar](255) NULL,
	[Price] [float] NULL,
	[SourceCode] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
