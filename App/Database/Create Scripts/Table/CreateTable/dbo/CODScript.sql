SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CODScript]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CODScript](
	[CODScriptID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CODScriptTab] [varchar](50) NULL,
	[CODScriptArea] [varchar](50) NULL,
	[CODScriptCODGEN] [varchar](255) NULL,
	[CODScriptCODAA] [varchar](255) NULL,
	[CODScriptCODSPAN] [varchar](255) NULL,
	[CODScriptFieldName] [varchar](50) NULL,
	[CODScriptArrayIndex] [int] NULL,
	[CODScriptType] [varchar](10) NULL,
 CONSTRAINT [PK_CODScript] PRIMARY KEY NONCLUSTERED 
(
	[CODScriptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
