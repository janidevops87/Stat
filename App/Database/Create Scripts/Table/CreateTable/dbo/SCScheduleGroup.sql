SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCScheduleGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCScheduleGroup](
	[SCScheduleGroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NOT NULL,
	[SubCriteriaID] [int] NOT NULL,
	[SCScheduleGroupOrgan] [smallint] NULL,
	[SCScheduleGroupBone] [smallint] NULL,
	[SCScheduleGroupTissue] [smallint] NULL,
	[SCScheduleGroupSkin] [smallint] NULL,
	[SCScheduleGroupValves] [smallint] NULL,
	[SCScheduleGroupEyes] [smallint] NULL,
	[SCScheduleGroupResearch] [smallint] NULL,
	[SCScheduleNoContactOnDny] [smallint] NULL,
	[SCScheduleContactOnCnsnt] [smallint] NULL,
	[SCScheduleContactOnAprch] [smallint] NULL,
	[SCScheduleContactOnCrnr] [smallint] NULL,
	[SCScheduleContactOnStatSec] [smallint] NULL,
	[SCScheduleContactOnStatCnsnt] [smallint] NULL,
	[SCScheduleContactOnCoronerOnly] [smallint] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_SCScheduleGroup] PRIMARY KEY NONCLUSTERED 
(
	[SCScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCScheduleGroup]'))
ALTER TABLE [dbo].[SCScheduleGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCScheduleGroup]'))
ALTER TABLE [dbo].[SCScheduleGroup] CHECK CONSTRAINT [FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCScheduleGroup]'))
ALTER TABLE [dbo].[SCScheduleGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID] FOREIGN KEY([SubCriteriaID])
REFERENCES [dbo].[SubCriteria] ([SubCriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCScheduleGroup]'))
ALTER TABLE [dbo].[SCScheduleGroup] CHECK CONSTRAINT [FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID]
GO
