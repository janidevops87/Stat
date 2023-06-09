SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaSourceCode](
	[CriteriaSourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_CriteriaSourceCode_5__15] PRIMARY KEY CLUSTERED 
(
	[CriteriaSourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaSourceCode]') AND name = N'CriteriaID')
CREATE NONCLUSTERED INDEX [CriteriaID] ON [dbo].[CriteriaSourceCode]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaSourceCode]') AND name = N'IDX_CriteriaSourceCode_SourceCodeID_includes')
CREATE NONCLUSTERED INDEX [IDX_CriteriaSourceCode_SourceCodeID_includes] ON [dbo].[CriteriaSourceCode]
(
	[SourceCodeID] ASC
)
INCLUDE([CriteriaID],[CriteriaSourceCodeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSourceCode]'))
ALTER TABLE [dbo].[CriteriaSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSourceCode]'))
ALTER TABLE [dbo].[CriteriaSourceCode] CHECK CONSTRAINT [FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID]
GO
