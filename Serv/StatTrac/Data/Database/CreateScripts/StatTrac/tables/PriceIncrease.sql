if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PriceIncrease]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PriceIncrease]
GO

CREATE TABLE [dbo].[PriceIncrease] (
	[InvoiceID] [int] NULL ,
	[Client] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TriageReferralTotal] [decimal](9, 2) NULL ,
	[Message] [decimal](9, 2) NULL ,
	[ASP] [decimal](9, 2) NULL ,
	[TOTALSECRATE] [decimal](9, 2) NULL ,
	[Approach] [decimal](9, 2) NULL ,
	[Med-SocHistories] [decimal](9, 2) NULL ,
	[GlobalRate] [decimal](9, 2) NULL ,
	[MonthlyRetainer] [decimal](9, 2) NULL 
) ON [PRIMARY]
GO


