SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportDateTimeConfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportDateTimeConfiguration](
	[ReportDateTimeConfigurationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[ReportDateTimeID] [int] NULL,
	[IsArchived] [bit] NOT NULL,
	[IsDateOnly] [bit] NOT NULL,
 CONSTRAINT [PK_ReportDateTimeConfiguration] PRIMARY KEY CLUSTERED 
(
	[ReportDateTimeConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ReportDateTimeConfiguration_IsArchived]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ReportDateTimeConfiguration] ADD  CONSTRAINT [DF_ReportDateTimeConfiguration_IsArchived]  DEFAULT (0) FOR [IsArchived]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ReportDateTimeConfiguration_IsDateOnly]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ReportDateTimeConfiguration] ADD  CONSTRAINT [DF_ReportDateTimeConfiguration_IsDateOnly]  DEFAULT (0) FOR [IsDateOnly]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTimeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTimeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID] FOREIGN KEY([ReportDateTimeID])
REFERENCES [dbo].[ReportDateTime] ([ReportDateTimeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTimeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTimeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTimeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTimeConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportDateTimeConfiguration]'))
ALTER TABLE [dbo].[ReportDateTimeConfiguration] CHECK CONSTRAINT [FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID]
GO
