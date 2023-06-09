SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationSourceCode](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RotationGroupID] [int] NULL,
	[RotationID] [int] NULL,
	[RotationSourceCodeID] [int] NULL,
	[RotationSourcecodeName] [char](50) NULL,
	[RotationSourceCodeType] [int] NULL
) ON [PRIMARY]
END
GO
