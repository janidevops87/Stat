SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportGroupListDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportGroupListDetail](
	[ReportGroupListDetailID] [char](10) NOT NULL,
	[ReportGroupListID] [char](10) NULL
) ON [PRIMARY]
END
GO
