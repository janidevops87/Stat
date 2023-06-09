SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationRun]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationRun](
	[RotationGroupID] [int] NULL,
	[RotationID] [int] NULL,
	[RotationGroupName] [varchar](255) NULL,
	[RotationName] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
