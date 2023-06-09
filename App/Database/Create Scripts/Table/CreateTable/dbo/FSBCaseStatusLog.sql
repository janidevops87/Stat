SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSBCaseStatusLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSBCaseStatusLog](
	[FSBCaseId] [int] NOT NULL,
	[FSBStatusId] [int] NOT NULL,
	[StatusChangedDateTime] [datetime] NOT NULL,
	[InsertedBy] [nvarchar](50) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [FSBCaseStatusLog_PK] PRIMARY KEY NONCLUSTERED 
(
	[FSBCaseId] ASC,
	[FSBStatusId] ASC,
	[StatusChangedDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBCaseSt__DateI__332DD77E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBCaseStatusLog] ADD  DEFAULT (getdate()) FOR [DateInserted]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBCaseSt__DateU__3421FBB7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBCaseStatusLog] ADD  DEFAULT (getdate()) FOR [DateUpdated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseStatusLog]'))
ALTER TABLE [dbo].[FSBCaseStatusLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId] FOREIGN KEY([FSBCaseId])
REFERENCES [dbo].[FSBCase] ([FSBCaseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseStatusLog]'))
ALTER TABLE [dbo].[FSBCaseStatusLog] CHECK CONSTRAINT [FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseStatusLog]'))
ALTER TABLE [dbo].[FSBCaseStatusLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId] FOREIGN KEY([FSBStatusId])
REFERENCES [dbo].[FSBStatus] ([FSBStatusId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseStatusLog]'))
ALTER TABLE [dbo].[FSBCaseStatusLog] CHECK CONSTRAINT [FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId]
GO
