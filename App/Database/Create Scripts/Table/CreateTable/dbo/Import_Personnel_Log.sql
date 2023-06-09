SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Personnel_Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Personnel_Log](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RunStart] [datetime] NULL,
	[RunEnd] [datetime] NULL,
	[RunStatus] [varchar](12) NULL,
	[RecordsTotal] [int] NULL,
	[RecordsSuspended] [int] NULL,
	[RecordsAdded] [int] NULL,
	[RecordsUpdated] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_Import_Personnel_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RunStart]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RunStart]  DEFAULT (getdate()) FOR [RunStart]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RunStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RunStatus]  DEFAULT ('LOADING') FOR [RunStatus]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RecordsTotal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RecordsTotal]  DEFAULT (0) FOR [RecordsTotal]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RecordsSuspended]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RecordsSuspended]  DEFAULT (0) FOR [RecordsSuspended]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RecordsAdded]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RecordsAdded]  DEFAULT (0) FOR [RecordsAdded]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Import_Personnel_Log_RecordsUpdated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Import_Personnel_Log] ADD  CONSTRAINT [DF_Import_Personnel_Log_RecordsUpdated]  DEFAULT (0) FOR [RecordsUpdated]
END
GO
