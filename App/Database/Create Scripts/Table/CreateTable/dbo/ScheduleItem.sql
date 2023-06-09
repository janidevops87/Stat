SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleItem](
	[ScheduleItemID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NULL,
	[ScheduleItemName] [varchar](10) NULL,
	[ScheduleItemStartDate] [smalldatetime] NULL,
	[ScheduleItemStartTime] [varchar](5) NULL,
	[ScheduleItemEndDate] [smalldatetime] NULL,
	[ScheduleItemEndTime] [varchar](5) NULL,
	[LastModified] [datetime] NULL,
	[LastWebPersonID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_ScheduleItem] PRIMARY KEY NONCLUSTERED 
(
	[ScheduleItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItem]')
	AND syscolumns.name = 'LastWebPersonID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItem Adding Column LastWebPersonID';
	ALTER TABLE ScheduleItem
		ADD LastWebPersonID int;
END	
GO
IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItem]')
	AND syscolumns.name = 'AuditLogTypeID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItem Adding Column AuditLogTypeID';
	ALTER TABLE ScheduleItem
		ADD AuditLogTypeID int;
END	
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[ScheduleItem]
(
	[ScheduleGroupID] ASC
)
INCLUDE([ScheduleItemID],[ScheduleItemName],[ScheduleItemStartDate],[ScheduleItemStartTime],[ScheduleItemEndDate],[ScheduleItemEndTime],[LastModified]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND name = N'ScheduleItemEndDate')
CREATE NONCLUSTERED INDEX [ScheduleItemEndDate] ON [dbo].[ScheduleItem]
(
	[ScheduleItemEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND name = N'ScheduleItemStartDate')
CREATE NONCLUSTERED INDEX [ScheduleItemStartDate] ON [dbo].[ScheduleItem]
(
	[ScheduleItemStartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleItem]'))
ALTER TABLE [dbo].[ScheduleItem]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleItem]'))
ALTER TABLE [dbo].[ScheduleItem] CHECK CONSTRAINT [FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
