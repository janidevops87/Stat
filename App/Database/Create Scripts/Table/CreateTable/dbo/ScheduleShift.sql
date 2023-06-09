SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleShift]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleShift](
	[ScheduleShiftID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NULL,
	[ScheduleShiftName] [varchar](50) NULL,
	[WeekdayID] [int] NULL,
	[ScheduleShiftStartTime] [varchar](5) NULL,
	[ScheduleShiftEndTime] [varchar](5) NULL,
	[LastModified] [datetime] NULL,
	[ScheduleShiftDate] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_ScheduleShift_1__13] PRIMARY KEY CLUSTERED 
(
	[ScheduleShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleShift]') AND name = N'ScheduleGroupID')
CREATE NONCLUSTERED INDEX [ScheduleGroupID] ON [dbo].[ScheduleShift]
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleShift]') AND name = N'WeekdayID')
CREATE NONCLUSTERED INDEX [WeekdayID] ON [dbo].[ScheduleShift]
(
	[WeekdayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleShift]'))
ALTER TABLE [dbo].[ScheduleShift]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleShift]'))
ALTER TABLE [dbo].[ScheduleShift] CHECK CONSTRAINT [FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleShift]'))
ALTER TABLE [dbo].[ScheduleShift]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID] FOREIGN KEY([WeekdayID])
REFERENCES [dbo].[Weekday] ([WeekdayID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleShift]'))
ALTER TABLE [dbo].[ScheduleShift] CHECK CONSTRAINT [FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID]
GO
