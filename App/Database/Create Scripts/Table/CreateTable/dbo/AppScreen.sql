SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppScreen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AppScreen](
	[AppScreenId] [int] NOT NULL,
	[ParentId] [int] NULL,
	[ScreenName] [varchar](100) NULL,
	[SortOrder] [int] NOT NULL,
	[ShortCutKey] [varchar](10) NULL,
 CONSTRAINT [PK_AppScreen] PRIMARY KEY CLUSTERED 
(
	[AppScreenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
