SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationSequence]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationSequence](
	[RotationGroupID] [int] NULL,
	[RotationID] [int] NULL,
	[RotationName] [varchar](50) NULL,
	[Sequence] [int] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CurrentRotation] [smallint] NULL,
	[NextRotation] [smallint] NULL
) ON [PRIMARY]
END
GO
