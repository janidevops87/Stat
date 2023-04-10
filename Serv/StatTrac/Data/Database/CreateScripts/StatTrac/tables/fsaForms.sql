if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fsaForms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[fsaForms]
GO

CREATE TABLE [dbo].[fsaForms] (
	[fsaFormsID] [int] IDENTITY (1, 1) NOT NULL ,
	[FormName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FileName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


