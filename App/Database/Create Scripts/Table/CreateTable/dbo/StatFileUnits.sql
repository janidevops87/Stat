SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatFileUnits]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatFileUnits](
	[UnitID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Units] [varchar](50) NULL
) ON [PRIMARY]
END
GO
