if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LineItemFormula]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LineItemFormula]
GO

CREATE TABLE [dbo].[LineItemFormula] (
	[LineItemFormulaID] [int] IDENTITY (1, 1) NOT NULL ,
	[LineItemFormulaNumber] [tinyint] NOT NULL ,
	[InvoiceID] [int] NOT NULL ,
	[LineItemID] [int] NOT NULL ,
	[LineItemFormula] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO


