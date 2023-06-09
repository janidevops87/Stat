SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleLock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleLock](
	[ScheduleGroupID] [int] NOT NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_ScheduleLock_1_1] PRIMARY KEY CLUSTERED 
(
	[ScheduleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ScheduleLock_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ScheduleLock] ADD  CONSTRAINT [DF_ScheduleLock_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
