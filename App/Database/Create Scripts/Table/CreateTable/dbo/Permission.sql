SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Permission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Permission](
	[PERMISSIONID] [int] IDENTITY(175,1) NOT FOR REPLICATION NOT NULL,
	[PERMISSIONNAME] [varchar](500) NULL,
	[PERMISSIONTYPEID] [int] NULL,
	[FUNCTIONID] [int] NULL,
	[PERMISSIONDESCRIPTION] [varchar](1000) NULL,
	[ACTIVE] [bit] NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY NONCLUSTERED 
(
	[PERMISSIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Permission]'))
ALTER TABLE [dbo].[Permission]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID] FOREIGN KEY([PERMISSIONTYPEID])
REFERENCES [dbo].[PermissionType] ([PERMISSIONTYPEID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Permission]'))
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID]
GO
--Need to remove this permission as functions doesn't look to be used anymore and is stopping the insert of new rows for new reporting site
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_dbo_Permission_FUNCTIONID_dbo_Functions_FUNCTIONID]') AND type = 'F')
BEGIN
	ALTER TABLE [dbo].[Permission] DROP CONSTRAINT [FK_dbo_Permission_FUNCTIONID_dbo_Functions_FUNCTIONID]
END
GO
