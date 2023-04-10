if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CODAdMethods]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CODAdMethods]
GO

CREATE TABLE [dbo].[CODAdMethods] (
	[CODAdMethodsValue] [int] NOT NULL ,
	[CODAdMethodsName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


