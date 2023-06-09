SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaScheduleGroup](
	[CriteriaScheduleGroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NULL,
	[ScheduleGroupID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[CriteriaScheduleGroupOrgan] [smallint] NULL,
	[CriteriaScheduleGroupBone] [smallint] NULL,
	[CriteriaScheduleGroupTissue] [smallint] NULL,
	[CriteriaScheduleGroupSkin] [smallint] NULL,
	[CriteriaScheduleGroupValves] [smallint] NULL,
	[CriteriaScheduleGroupEyes] [smallint] NULL,
	[CriteriaScheduleGroupResearch] [smallint] NULL,
	[CriteriaScheduleNoContactOnDny] [smallint] NULL,
	[CriteriaScheduleContactOnCnsnt] [smallint] NULL,
	[CriteriaScheduleContactOnAprch] [smallint] NULL,
	[CriteriaScheduleContactOnCrnr] [smallint] NULL,
	[CriteriaScheduleContactOnStatSec] [smallint] NULL,
	[CriteriaScheduleContactOnStatCnsnt] [smallint] NULL,
	[CriteriaScheduleContactOnCoronerOnly] [smallint] NULL,
 CONSTRAINT [PK___1__19] PRIMARY KEY CLUSTERED 
(
	[CriteriaScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]') AND name = N'CriteriaID')
CREATE NONCLUSTERED INDEX [CriteriaID] ON [dbo].[CriteriaScheduleGroup]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]') AND name = N'IDX_CriteriaScheduleGroup_CriteriaScheduleContactOnStatCnsnt_includes')
CREATE NONCLUSTERED INDEX [IDX_CriteriaScheduleGroup_CriteriaScheduleContactOnStatCnsnt_includes] ON [dbo].[CriteriaScheduleGroup]
(
	[CriteriaScheduleContactOnStatCnsnt] ASC
)
INCLUDE([CriteriaID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[CriteriaScheduleGroup]
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch3__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch3__19]  DEFAULT (0) FOR [CriteriaScheduleGroupOrgan]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch1__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch1__19]  DEFAULT (0) FOR [CriteriaScheduleGroupBone]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch6__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch6__19]  DEFAULT (0) FOR [CriteriaScheduleGroupTissue]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch5__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch5__19]  DEFAULT (0) FOR [CriteriaScheduleGroupSkin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch7__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch7__19]  DEFAULT (0) FOR [CriteriaScheduleGroupValves]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch2__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch2__19]  DEFAULT (0) FOR [CriteriaScheduleGroupEyes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch4__19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch4__19]  DEFAULT (0) FOR [CriteriaScheduleGroupResearch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch2__31]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch2__31]  DEFAULT (0) FOR [CriteriaScheduleNoContactOnDny]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch1__31]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch1__31]  DEFAULT (0) FOR [CriteriaScheduleContactOnCnsnt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaSc_CriteriaSch1__17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaSc_CriteriaSch1__17]  DEFAULT (0) FOR [CriteriaScheduleContactOnAprch]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaScheduleGroup_CriteriaScheduleContactOnCrnr]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaScheduleGroup_CriteriaScheduleContactOnCrnr]  DEFAULT (0) FOR [CriteriaScheduleContactOnCrnr]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaScheduleGroup_CriteriaScheduleContactOnStatSec]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaScheduleGroup_CriteriaScheduleContactOnStatSec]  DEFAULT (0) FOR [CriteriaScheduleContactOnStatSec]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaScheduleGroup_CriteriaScheduleContactOnStatCnsnt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaScheduleGroup_CriteriaScheduleContactOnStatCnsnt]  DEFAULT (0) FOR [CriteriaScheduleContactOnStatCnsnt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaScheduleGroup_CriteriaScheduleContactOnCoronerOnly]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaScheduleGroup] ADD  CONSTRAINT [DF_CriteriaScheduleGroup_CriteriaScheduleContactOnCoronerOnly]  DEFAULT (0) FOR [CriteriaScheduleContactOnCoronerOnly]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]'))
ALTER TABLE [dbo].[CriteriaScheduleGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]'))
ALTER TABLE [dbo].[CriteriaScheduleGroup] CHECK CONSTRAINT [FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]'))
ALTER TABLE [dbo].[CriteriaScheduleGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaScheduleGroup]'))
ALTER TABLE [dbo].[CriteriaScheduleGroup] CHECK CONSTRAINT [FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
