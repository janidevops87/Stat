SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelSourceCode](
	[ServiceLevelSourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ServiceLevelID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[Unused] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___5__15] PRIMARY KEY CLUSTERED 
(
	[ServiceLevelSourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSourceCode]') AND name = N'ServiceLevelID')
CREATE NONCLUSTERED INDEX [ServiceLevelID] ON [dbo].[ServiceLevelSourceCode]
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSourceCode]') AND name = N'SourceCodeID')
CREATE NONCLUSTERED INDEX [SourceCodeID] ON [dbo].[ServiceLevelSourceCode]
(
	[SourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelSourceCode]'))
ALTER TABLE [dbo].[ServiceLevelSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelSourceCode]'))
ALTER TABLE [dbo].[ServiceLevelSourceCode] CHECK CONSTRAINT [FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
