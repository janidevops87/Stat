SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FsbCaseStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FsbCaseStatus](
	[FsbCaseStatusId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallId] [int] NOT NULL,
	[LastStatEmployeeId] [int] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[FamilyServicesCoordinatorId] [int] NULL,
	[ListFsbStatusId] [smallint] NULL,
	[Comment] [nvarchar](200) NULL,
 CONSTRAINT [PK_FsbCaseStatus] PRIMARY KEY CLUSTERED 
(
	[FsbCaseStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FsbCaseStatus]') AND name = N'IX_FsbCaseStatus_CallId')
CREATE NONCLUSTERED INDEX [IX_FsbCaseStatus_CallId] ON [dbo].[FsbCaseStatus]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FsbCaseStatus_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FsbCaseStatus] ADD  CONSTRAINT [DF_FsbCaseStatus_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FsbCaseStatus]'))
ALTER TABLE [dbo].[FsbCaseStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId] FOREIGN KEY([ListFsbStatusId])
REFERENCES [dbo].[ListFsbStatus] ([ListFsbStatusId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FsbCaseStatus]'))
ALTER TABLE [dbo].[FsbCaseStatus] CHECK CONSTRAINT [FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId]
GO
