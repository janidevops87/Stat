SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListFsbStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ListFsbStatus](
	[ListFsbStatusId] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastStatEmployeeId] [int] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [nvarchar](100) NULL,
	[ListFsbStatusColorId] [smallint] NOT NULL,
	[ThresholdMinutes] [smallint] NOT NULL,
 CONSTRAINT [PK_ListFsbStatus] PRIMARY KEY CLUSTERED 
(
	[ListFsbStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ListFsbStatus]') AND name = N'IX_ListFsbStatus_FieldValue')
CREATE UNIQUE NONCLUSTERED INDEX [IX_ListFsbStatus_FieldValue] ON [dbo].[ListFsbStatus]
(
	[FieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatus_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatus] ADD  CONSTRAINT [DF_ListFsbStatus_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatus_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatus] ADD  CONSTRAINT [DF_ListFsbStatus_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatus_ListFsbStatusColorId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatus] ADD  CONSTRAINT [DF_ListFsbStatus_ListFsbStatusColorId]  DEFAULT (1) FOR [ListFsbStatusColorId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatus_ThresholdMinutes]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatus] ADD  CONSTRAINT [DF_ListFsbStatus_ThresholdMinutes]  DEFAULT (0) FOR [ThresholdMinutes]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ListFsbStatus]'))
ALTER TABLE [dbo].[ListFsbStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId] FOREIGN KEY([ListFsbStatusColorId])
REFERENCES [dbo].[ListFsbStatusColor] ([ListFsbStatusColorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ListFsbStatus]'))
ALTER TABLE [dbo].[ListFsbStatus] CHECK CONSTRAINT [FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId]
GO
