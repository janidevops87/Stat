SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DashBoardTimerType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DashBoardTimerType](
	[DashBoardTimerTypeId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DashBoardTimerType] [nvarchar](100) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_DashBoardTimerType] PRIMARY KEY CLUSTERED 
(
	[DashBoardTimerTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_DashBoardTimerType_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DashBoardTimerType] ADD  CONSTRAINT [DF_DashBoardTimerType_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerType]'))
ALTER TABLE [dbo].[DashBoardTimerType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeId])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DashBoardTimerType]'))
ALTER TABLE [dbo].[DashBoardTimerType] CHECK CONSTRAINT [FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId]
GO
