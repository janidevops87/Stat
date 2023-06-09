SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebPersonPermission](
	[WEBPERSONPERMISSIONID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WEBPERSONID] [int] NULL,
	[PERMISSIONID] [int] NULL,
 CONSTRAINT [PK_WebPersonPermission] PRIMARY KEY NONCLUSTERED 
(
	[WEBPERSONPERMISSIONID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]') AND name = N'FK_WebPersonId')
CREATE NONCLUSTERED INDEX [FK_WebPersonId] ON [dbo].[WebPersonPermission]
(
	[WEBPERSONID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]') AND name = N'IDX_WebPersonPermission_PERMISSIONID')
CREATE NONCLUSTERED INDEX [IDX_WebPersonPermission_PERMISSIONID] ON [dbo].[WebPersonPermission]
(
	[PERMISSIONID] ASC
)
INCLUDE([WEBPERSONID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]'))
ALTER TABLE [dbo].[WebPersonPermission]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID] FOREIGN KEY([PERMISSIONID])
REFERENCES [dbo].[Permission] ([PERMISSIONID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]'))
ALTER TABLE [dbo].[WebPersonPermission] CHECK CONSTRAINT [FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]'))
ALTER TABLE [dbo].[WebPersonPermission]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID] FOREIGN KEY([WEBPERSONID])
REFERENCES [dbo].[WebPerson] ([WebPersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebPersonPermission]'))
ALTER TABLE [dbo].[WebPersonPermission] CHECK CONSTRAINT [FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID]
GO
