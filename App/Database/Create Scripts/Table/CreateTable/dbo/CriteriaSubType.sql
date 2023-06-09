SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaSubType](
	[CriteriaSubTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NOT NULL,
	[SubTypeID] [int] NOT NULL,
	[SubCriteriaPrecedence] [int] NULL,
 CONSTRAINT [PK_CriteriaSubType] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaSubTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]') AND name = N'FK_CriteriaID')
CREATE NONCLUSTERED INDEX [FK_CriteriaID] ON [dbo].[CriteriaSubType]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]'))
ALTER TABLE [dbo].[CriteriaSubType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]'))
ALTER TABLE [dbo].[CriteriaSubType] CHECK CONSTRAINT [FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]'))
ALTER TABLE [dbo].[CriteriaSubType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID] FOREIGN KEY([SubTypeID])
REFERENCES [dbo].[SubType] ([SubTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaSubType]'))
ALTER TABLE [dbo].[CriteriaSubType] CHECK CONSTRAINT [FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID]
GO
