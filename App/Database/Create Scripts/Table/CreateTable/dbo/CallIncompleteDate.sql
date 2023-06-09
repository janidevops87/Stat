SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallIncompleteDate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallIncompleteDate](
	[CallID] [int] NOT NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CallIncompleteDate]') AND name = N'IDX_CallIncompleteDate_CallID')
CREATE CLUSTERED INDEX [IDX_CallIncompleteDate_CallID] ON [dbo].[CallIncompleteDate]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CallIncompleteDate]') AND name = N'ix_CallIncompleteDate_StatEmployeeID_includes')
CREATE NONCLUSTERED INDEX [ix_CallIncompleteDate_StatEmployeeID_includes] ON [dbo].[CallIncompleteDate]
(
	[StatEmployeeID] ASC
)
INCLUDE([CallID],[LastModified]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallIncompleteDate_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallIncompleteDate] ADD  CONSTRAINT [DF_CallIncompleteDate_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallIncompleteDate]'))
ALTER TABLE [dbo].[CallIncompleteDate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID] FOREIGN KEY([StatEmployeeID])
REFERENCES [dbo].[StatEmployee] ([StatEmployeeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallIncompleteDate]'))
ALTER TABLE [dbo].[CallIncompleteDate] CHECK CONSTRAINT [FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]
GO
