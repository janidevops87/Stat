SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSBCaseCommentLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSBCaseCommentLog](
	[FSBCaseCommentLogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Comment] [nvarchar](1000) NOT NULL,
	[FSBCaseId] [int] NOT NULL,
	[InsertedBy] [nvarchar](50) NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [FSBCaseCommentLog_PK] PRIMARY KEY NONCLUSTERED 
(
	[FSBCaseCommentLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBCaseCo__DateI__2F5D469A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBCaseCommentLog] ADD  DEFAULT (getdate()) FOR [DateInserted]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBCaseCo__DateU__30516AD3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBCaseCommentLog] ADD  DEFAULT (getdate()) FOR [DateUpdated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseCommentLog]'))
ALTER TABLE [dbo].[FSBCaseCommentLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId] FOREIGN KEY([FSBCaseId])
REFERENCES [dbo].[FSBCase] ([FSBCaseId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCaseCommentLog]'))
ALTER TABLE [dbo].[FSBCaseCommentLog] CHECK CONSTRAINT [FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId]
GO
