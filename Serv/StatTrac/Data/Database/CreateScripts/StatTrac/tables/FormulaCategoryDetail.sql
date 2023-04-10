if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FormulaCategoryDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FormulaCategoryDetail]
GO

CREATE TABLE [dbo].[FormulaCategoryDetail] (
	[FormulaCategoryDetailID] [int] IDENTITY (1, 1) NOT NULL ,
	[FormulaCategoryID] [int] NOT NULL ,
	[FormulaCategoryDetailName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO


