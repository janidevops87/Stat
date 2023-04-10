if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Functions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Functions]
GO

CREATE TABLE [dbo].[Functions] (
	[FUNCTIONID] [int] IDENTITY (5, 1) NOT NULL ,
	[FUNCTIONNAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FUNCTIONSTRING] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FUNCTIONDESCRIPTION] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


