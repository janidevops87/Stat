SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleGroupPerson](
	[ScheduleGroupPersonID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_ScheduleGroupPerson] PRIMARY KEY NONCLUSTERED 
(
	[ScheduleGroupPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]') AND name = N'PersonID')
CREATE NONCLUSTERED INDEX [PersonID] ON [dbo].[ScheduleGroupPerson]
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[ScheduleGroupPerson]
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]'))
ALTER TABLE [dbo].[ScheduleGroupPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]'))
ALTER TABLE [dbo].[ScheduleGroupPerson] CHECK CONSTRAINT [FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]'))
ALTER TABLE [dbo].[ScheduleGroupPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupPerson]'))
ALTER TABLE [dbo].[ScheduleGroupPerson] CHECK CONSTRAINT [FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
