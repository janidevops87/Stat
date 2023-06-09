SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DashBoardTimerDefault](
	[DashBoardTimerDefaultId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DashBoardWindowId] [int] NULL,
	[DashBoardTimerTypeId] [int] NULL,
	[ExpirationMinutes] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault] CHECK CONSTRAINT [FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId] FOREIGN KEY([DashBoardTimerTypeId])
REFERENCES [dbo].[DashBoardTimerType] ([DashBoardTimerTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault] CHECK CONSTRAINT [FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId] FOREIGN KEY([DashBoardWindowId])
REFERENCES [dbo].[DashBoardWindow] ([DashBoardWindowId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerDefault]'))
ALTER TABLE [dbo].[DashBoardTimerDefault] CHECK CONSTRAINT [FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]
GO
