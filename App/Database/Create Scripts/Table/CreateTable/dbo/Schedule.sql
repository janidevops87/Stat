SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[PhoneID] [int] NULL,
	[ScheduleGroupID] [int] NULL,
	[ScheduleShiftID] [int] NULL,
	[ScheduleShiftCutover] [varchar](10) NULL,
	[ScheduleDate] [smalldatetime] NULL,
	[ScheduleCall1PersonID] [int] NULL,
	[ScheduleCall2PersonID] [int] NULL,
	[ScheduleCall3PersonID] [int] NULL,
	[ScheduleCall4PersonID] [int] NULL,
	[ScheduleCall5PersonID] [int] NULL,
	[ScheduleCall6PersonID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UnusedField] [varchar](255) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_Schedule_1__13] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND name = N'ScheduleShiftID')
CREATE NONCLUSTERED INDEX [ScheduleShiftID] ON [dbo].[Schedule]
(
	[ScheduleShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID] FOREIGN KEY([ScheduleShiftID])
REFERENCES [dbo].[ScheduleShift] ([ScheduleShiftID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID]
GO
