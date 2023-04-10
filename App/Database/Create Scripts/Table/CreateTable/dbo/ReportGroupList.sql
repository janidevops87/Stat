SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportGroupList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportGroupList](
	[ReportGroupListID] [char](10) NOT NULL,
	[ReportGroupListName] [char](10) NULL
) ON [PRIMARY]
END
GO
