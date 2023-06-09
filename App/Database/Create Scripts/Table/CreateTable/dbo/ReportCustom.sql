SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportCustom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportCustom](
	[ReportCustomID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportCustomReportID] [int] NULL,
	[ReportCustomOrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_ReportCustom] PRIMARY KEY NONCLUSTERED 
(
	[ReportCustomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
