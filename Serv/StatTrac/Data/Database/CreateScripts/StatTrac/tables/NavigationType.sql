if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NavigationType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NavigationType]
GO

CREATE TABLE [dbo].[NavigationType] (
	[NAVIGATIONTYPEID] [int] IDENTITY (3, 1) NOT NULL ,
	[NAVIGATIONTYPENAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


