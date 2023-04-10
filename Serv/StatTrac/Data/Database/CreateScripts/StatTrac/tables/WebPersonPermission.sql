if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebPersonPermission]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WebPersonPermission]
GO

CREATE TABLE [dbo].[WebPersonPermission] (
	[WEBPERSONPERMISSIONID] [int] IDENTITY (1, 1) NOT NULL ,
	[WEBPERSONID] [int] NULL ,
	[PERMISSIONID] [int] NULL 
) ON [PRIMARY]
GO


