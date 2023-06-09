SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationReportGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationReportGroup](
	[RotationID] [int] NULL,
	[RotationGroupID] [int] NULL,
	[RotationReportGroupName] [varchar](255) NULL,
	[RotationReportGroupID] [int] NULL,
	[RotationReportGroupType] [int] NULL,
	[RotationReportGroupTypeName] [varchar](255) NULL,
	[RotationAddAccessDate] [smallint] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationReportGroup]') AND name = N'IX_RotationGroupId')
CREATE NONCLUSTERED INDEX [IX_RotationGroupId] ON [dbo].[RotationReportGroup]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
