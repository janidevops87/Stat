SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationGroupName]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationGroupName](
	[RotationGroupName] [varchar](255) NOT NULL,
	[RotationGroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RotationID] [int] NULL,
	[RotationFrequency] [int] NULL,
	[RotationActive] [smallint] NULL,
	[RotationTimeZone] [varchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationGroupName]') AND name = N'PK_RotationGroupId')
CREATE CLUSTERED INDEX [PK_RotationGroupId] ON [dbo].[RotationGroupName]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
