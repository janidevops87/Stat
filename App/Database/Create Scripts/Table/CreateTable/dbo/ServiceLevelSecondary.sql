SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSecondary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelSecondary](
	[ServiceLevelID] [int] NOT NULL,
	[ServiceLevelSecondaryOn] [smallint] NULL,
	[ServiceLevelSecondaryAlert] [varchar](750) NULL,
	[ServiceLevelSecondaryHistory] [smallint] NULL,
	[ServiceLevelSecondaryHemodilution] [smallint] NULL,
	[LastModified] [smalldatetime] NULL,
	[ServiceLevelSecondaryTBIPrefix] [varchar](2) NULL,
 CONSTRAINT [PK_ServiceLevelSecondary] PRIMARY KEY NONCLUSTERED 
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
