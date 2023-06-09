if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OnlinePermission]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OnlinePermission]
GO

CREATE TABLE [dbo].[OnlinePermission] (
	[OnlinePermissionId] [int] IDENTITY (1, 1) NOT NULL ,
	[OnlinePermissionName] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlinePermissionString] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlinePermissionDescription] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


