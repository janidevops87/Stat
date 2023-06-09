SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportDateTypeConfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportDateTypeConfiguration](
	[ReportDateTypeConfigurationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[ReportDateTypeID] [int] NULL,
	[ReportDateTypeConfigurationIsDefault] [bit] NULL,
 CONSTRAINT [PK_ReportDateTypeConfiguration] PRIMARY KEY CLUSTERED 
(
	[ReportDateTypeConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTypeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTypeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID] FOREIGN KEY([ReportDateTypeID])
REFERENCES [dbo].[ReportDateType] ([ReportDateTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTypeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTypeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTypeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTypeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTypeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTypeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID]
GO
