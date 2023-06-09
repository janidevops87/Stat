SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleGroupOrganization](
	[ScheduleGroupOrganizationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_ScheduleGroupOrganizat1__13] PRIMARY KEY CLUSTERED 
(
	[ScheduleGroupOrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]') AND name = N'OrganizationID')
CREATE NONCLUSTERED INDEX [OrganizationID] ON [dbo].[ScheduleGroupOrganization]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[ScheduleGroupOrganization]
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]'))
ALTER TABLE [dbo].[ScheduleGroupOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]'))
ALTER TABLE [dbo].[ScheduleGroupOrganization] CHECK CONSTRAINT [FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]'))
ALTER TABLE [dbo].[ScheduleGroupOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupOrganization]'))
ALTER TABLE [dbo].[ScheduleGroupOrganization] CHECK CONSTRAINT [FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
