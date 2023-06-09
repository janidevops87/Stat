SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportSortTypeConfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportSortTypeConfiguration](
	[ReportSortTypeConfigurationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[ReportSortTypeID] [int] NULL,
 CONSTRAINT [PK_ReportSortTypeConfiguration] PRIMARY KEY CLUSTERED 
(
	[ReportSortTypeConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportSortTypeConfiguration]'))
ALTER TABLE [dbo].[ReportSortTypeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportSortTypeConfiguration]'))
ALTER TABLE [dbo].[ReportSortTypeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportSortTypeConfiguration]'))
ALTER TABLE [dbo].[ReportSortTypeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID] FOREIGN KEY([ReportSortTypeID])
REFERENCES [dbo].[ReportSortType] ([ReportSortTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportSortTypeConfiguration]'))
ALTER TABLE [dbo].[ReportSortTypeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID]
GO
