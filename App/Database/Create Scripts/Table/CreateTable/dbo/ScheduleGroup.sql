SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleGroup](
	[ScheduleGroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[ScheduleGroupName] [varchar](50) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[ScheduleGroupReferralNotes] [ntext] NULL,
	[ScheduleGroupMessageNotes] [ntext] NULL,
	[ScheduleGroupCode] [varchar](10) NULL,
	[UpdatedFlag] [smallint] NULL,
	[UseNewSchedule] [smallint] NULL,
 CONSTRAINT [PK_ScheduleGroup_1__13] PRIMARY KEY CLUSTERED 
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroup]') AND name = N'OrganizationID')
CREATE NONCLUSTERED INDEX [OrganizationID] ON [dbo].[ScheduleGroup]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroup]') AND name = N'ScheduleGroupName')
CREATE NONCLUSTERED INDEX [ScheduleGroupName] ON [dbo].[ScheduleGroup]
(
	[ScheduleGroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ScheduleGroup_UseNewSchedule]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ScheduleGroup] ADD  CONSTRAINT [DF_ScheduleGroup_UseNewSchedule]  DEFAULT (1) FOR [UseNewSchedule]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroup]'))
ALTER TABLE [dbo].[ScheduleGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroup]'))
ALTER TABLE [dbo].[ScheduleGroup] CHECK CONSTRAINT [FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID]
GO
