if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecurityPermissions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecurityPermissions]
GO

CREATE TABLE [dbo].[SecurityPermissions] (
	[SecurityPermissionsValue] [int] NOT NULL ,
	[SecurityPermissionsName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecurityPermissionsDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


