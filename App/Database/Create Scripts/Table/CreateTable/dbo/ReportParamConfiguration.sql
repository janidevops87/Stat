SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportParamConfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportParamConfiguration](
	[ReportParamConfiguration] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportID] [int] NULL,
	[ReportControlID] [int] NULL,
 CONSTRAINT [PK_ReportParamConfiguration] PRIMARY KEY CLUSTERED 
(
	[ReportParamConfiguration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportParamConfiguration]'))
ALTER TABLE [dbo].[ReportParamConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID] FOREIGN KEY([ReportControlID])
REFERENCES [dbo].[ReportControl] ([ReportControlID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportParamConfiguration]'))
ALTER TABLE [dbo].[ReportParamConfiguration] CHECK CONSTRAINT [FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportParamConfiguration]'))
ALTER TABLE [dbo].[ReportParamConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportParamConfiguration]'))
ALTER TABLE [dbo].[ReportParamConfiguration] CHECK CONSTRAINT [FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID]
GO
