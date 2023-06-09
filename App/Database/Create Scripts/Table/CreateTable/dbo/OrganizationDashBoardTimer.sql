SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationDashBoardTimer](
	[OrganizationDashBoardTimerId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[DashBoardWindowId] [int] NULL,
	[DashBoardTimerTypeId] [int] NULL,
	[ExpirationMinutes] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationDashBoardTimer] PRIMARY KEY CLUSTERED 
(
	[OrganizationDashBoardTimerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationDashBoardTimer_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationDashBoardTimer] ADD  CONSTRAINT [DF_OrganizationDashBoardTimer_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer] CHECK CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId] FOREIGN KEY([DashBoardTimerTypeId])
REFERENCES [dbo].[DashBoardTimerType] ([DashBoardTimerTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer] CHECK CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId] FOREIGN KEY([DashBoardWindowId])
REFERENCES [dbo].[DashBoardWindow] ([DashBoardWindowId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer] CHECK CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationDashBoardTimer]'))
ALTER TABLE [dbo].[OrganizationDashBoardTimer] CHECK CONSTRAINT [FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID]
GO
