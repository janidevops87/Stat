SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rotation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Rotation](
	[RotationID] [int] NULL,
	[RotationName] [varchar](50) NULL,
	[RotationFrequency] [int] NULL,
	[RotationSequence] [int] NULL,
	[RotationLastRun] [datetime] NULL,
	[RotationNextRun] [datetime] NULL,
	[RotationReportAccessDate] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RotationGroupID] [int] NULL,
	[ServiceLevelID] [int] NULL,
	[ServiceLevelName] [varchar](50) NULL,
	[CurrentRotation] [smallint] NULL,
	[RotationRemediate] [smallint] NULL
) ON [PRIMARY]
END
GO
