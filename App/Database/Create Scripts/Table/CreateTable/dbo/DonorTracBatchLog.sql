SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracBatchLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracBatchLog](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeID] [int] NULL,
	[SourceCodeName] [varchar](50) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[RunTime] [datetime] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracBatchLog]'))
ALTER TABLE [dbo].[DonorTracBatchLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracBatchLog]'))
ALTER TABLE [dbo].[DonorTracBatchLog] CHECK CONSTRAINT [FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
