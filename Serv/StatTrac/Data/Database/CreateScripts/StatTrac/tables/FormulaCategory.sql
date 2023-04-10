if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FormulaCategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FormulaCategory]
GO

CREATE TABLE [dbo].[FormulaCategory] (
	[FormulaCategoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[FormulaCategoryName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO


