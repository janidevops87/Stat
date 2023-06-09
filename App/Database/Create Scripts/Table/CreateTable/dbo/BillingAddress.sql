SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BillingAddress](
	[BillingAddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[BillingAddressName] [varchar](80) NULL,
	[QBooksID] [int] NULL,
	[BillingAddress1] [varchar](80) NULL,
	[BillingAddress2] [varchar](80) NULL,
	[BillingAddress3] [varchar](80) NULL,
	[BillingAddress4] [varchar](80) NULL,
	[BillingAddress5] [varchar](80) NULL,
	[BillingCity] [varchar](30) NULL,
	[BillingStateID] [int] NULL,
	[BillingZipCode] [varchar](6) NULL,
 CONSTRAINT [PK_BillingAddress] PRIMARY KEY NONCLUSTERED 
(
	[BillingAddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
