SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationTasks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationTasks](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RotationGroupID] [int] NULL,
	[RotationID] [int] NULL,
	[Type] [varchar](50) NULL,
	[TypeID] [int] NULL,
	[TypeName] [varchar](255) NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar](255) NULL,
	[StoredProc] [varchar](255) NULL
) ON [PRIMARY]
END
GO
