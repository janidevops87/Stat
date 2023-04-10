SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FS_CauseOfDeath]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FS_CauseOfDeath](
	[FS_CauseOfDeathId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FS_CauseOfDeathName] [varchar](100) NULL,
 CONSTRAINT [PK_FS_CauseOfDeath] PRIMARY KEY NONCLUSTERED 
(
	[FS_CauseOfDeathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
