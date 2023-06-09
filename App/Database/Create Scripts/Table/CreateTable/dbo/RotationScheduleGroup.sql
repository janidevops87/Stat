SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationScheduleGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationScheduleGroup](
	[RotationID] [int] NULL,
	[RotationGroupID] [int] NULL,
	[RotationScheduleGroupName] [varchar](255) NULL,
	[RotationScheduleGroupID] [int] NULL,
	[RotationScheduleGroupType] [int] NULL,
	[RotationScheduleGroupTypeName] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationScheduleGroup]') AND name = N'IX_RotationGroupId')
CREATE NONCLUSTERED INDEX [IX_RotationGroupId] ON [dbo].[RotationScheduleGroup]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
