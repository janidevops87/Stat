SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Report]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Report](
	[ReportID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportDisplayName] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[ReportLocalOnly] [int] NULL,
	[ReportVirtualURL] [varchar](100) NULL,
	[ReportTypeID] [smallint] NULL,
	[Unused] [varbinary](50) NULL,
	[ReportDescFileName] [varchar](50) NULL,
	[UpdatedFlag] [smallint] NULL,
	[ReportSortOrderID] [smallint] NULL,
	[ReportInDevelopment] [smallint] NULL,
	[ReportFromDate] [smallint] NULL,
	[ReportToDate] [smallint] NULL,
	[ReportGroup] [smallint] NULL,
	[ReportOrganization] [smallint] NULL,
 CONSTRAINT [PK_Report_1__13] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Report_ReportFromDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_ReportFromDate]  DEFAULT (1) FOR [ReportFromDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Report_ReportToDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_ReportToDate]  DEFAULT (1) FOR [ReportToDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Report_ReportGroup]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_ReportGroup]  DEFAULT (1) FOR [ReportGroup]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Report_ReportOrganization]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_ReportOrganization]  DEFAULT (1) FOR [ReportOrganization]
END
GO

-- adding a column to hold default sourcecodetype for a report instead of determining by report name
IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[Report]')
	AND syscolumns.name = 'SourceCodeTypeId'
	)
BEGIN
	PRINT 'ALTERING TABLE Report Adding Column SourceCodeTypeId';
	ALTER TABLE [Report]
		ADD [SourceCodeTypeId] [int] NULL;
END	
GO
