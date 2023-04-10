if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ABORef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ABORef]
GO

CREATE TABLE [dbo].[ABORef] (
	[ABORefId] [int] IDENTITY (1, 1) NOT NULL ,
	[ABORefName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


