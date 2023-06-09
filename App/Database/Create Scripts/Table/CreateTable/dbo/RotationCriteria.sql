SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationCriteria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationCriteria](
	[RotationID] [int] NULL,
	[RotationGroupID] [int] NULL,
	[CriteriaID] [int] NULL,
	[CriteriaType] [int] NULL,
	[CriteriaGroupName] [varchar](255) NULL,
	[CriteriaGroupID] [int] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationCriteria]') AND name = N'IX_RotationGroupId')
CREATE NONCLUSTERED INDEX [IX_RotationGroupId] ON [dbo].[RotationCriteria]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
