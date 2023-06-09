SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleGroupSourceCode](
	[ScheduleGroupSourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[Unused] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___4__15] PRIMARY KEY CLUSTERED 
(
	[ScheduleGroupSourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupSourceCode]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[ScheduleGroupSourceCode]
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleGroupSourceCode]') AND name = N'SourceCodeID')
CREATE NONCLUSTERED INDEX [SourceCodeID] ON [dbo].[ScheduleGroupSourceCode]
(
	[SourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupSourceCode]'))
ALTER TABLE [dbo].[ScheduleGroupSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleGroupSourceCode]'))
ALTER TABLE [dbo].[ScheduleGroupSourceCode] CHECK CONSTRAINT [FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
