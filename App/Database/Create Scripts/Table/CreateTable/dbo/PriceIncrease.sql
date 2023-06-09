SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PriceIncrease]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PriceIncrease](
	[InvoiceID] [int] NULL,
	[Client] [nvarchar](255) NULL,
	[SourceCode] [nvarchar](255) NULL,
	[TriageReferralTotal] [decimal](9, 2) NULL,
	[Message] [decimal](9, 2) NULL,
	[ASP] [decimal](9, 2) NULL,
	[TOTALSECRATE] [decimal](9, 2) NULL,
	[Approach] [decimal](9, 2) NULL,
	[Med-SocHistories] [decimal](9, 2) NULL,
	[GlobalRate] [decimal](9, 2) NULL,
	[MonthlyRetainer] [decimal](9, 2) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PriceIncrease]'))
ALTER TABLE [dbo].[PriceIncrease]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PriceIncrease]'))
ALTER TABLE [dbo].[PriceIncrease] CHECK CONSTRAINT [FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID]
GO
