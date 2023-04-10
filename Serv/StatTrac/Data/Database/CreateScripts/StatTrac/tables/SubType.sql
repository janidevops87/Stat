if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SubType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SubType]
GO

CREATE TABLE [dbo].[SubType] (
	[SubTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[SubTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubTypeDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


