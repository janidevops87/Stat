SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleLog](
	[ScheduleLogID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleGroupID] [int] NOT NULL,
	[ScheduleLogDateTime] [smalldatetime] NULL,
	[PersonID] [int] NULL,
	[ScheduleLogType] [varchar](20) NULL,
	[ScheduleLogShift] [varchar](80) NULL,
	[ScheduleLogChange] [varchar](200) NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_ScheduleLog] PRIMARY KEY NONCLUSTERED 
(
	[ScheduleLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleLog]'))
ALTER TABLE [dbo].[ScheduleLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleLog]'))
ALTER TABLE [dbo].[ScheduleLog] CHECK CONSTRAINT [FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleLog]'))
ALTER TABLE [dbo].[ScheduleLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID] FOREIGN KEY([ScheduleGroupID])
REFERENCES [dbo].[ScheduleGroup] ([ScheduleGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ScheduleLog]'))
ALTER TABLE [dbo].[ScheduleLog] CHECK CONSTRAINT [FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID]
GO
