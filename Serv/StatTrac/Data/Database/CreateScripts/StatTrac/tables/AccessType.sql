if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccessType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AccessType]
GO

CREATE TABLE [dbo].[AccessType] (
	[AccessID] [int] NOT NULL ,
	[Access] [int] NOT NULL ,
	[AccessName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AccessDescription] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


