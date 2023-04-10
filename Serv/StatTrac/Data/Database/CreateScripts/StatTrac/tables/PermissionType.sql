if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PermissionType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PermissionType]
GO

CREATE TABLE [dbo].[PermissionType] (
	[PERMISSIONTYPEID] [int] IDENTITY (5, 1) NOT NULL ,
	[PERMISSIONTYPENAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


