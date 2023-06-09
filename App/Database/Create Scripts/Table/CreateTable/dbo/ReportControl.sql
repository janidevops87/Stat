SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportControl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportControl](
	[ReportControlID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportControlName] [varchar](50) NULL,
	[ReportParamSectionID] [int] NULL,
 CONSTRAINT [PK_ReportControl] PRIMARY KEY CLUSTERED 
(
	[ReportControlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportControl]'))
ALTER TABLE [dbo].[ReportControl]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID] FOREIGN KEY([ReportParamSectionID])
REFERENCES [dbo].[ReportParamSection] ([ReportParamSectionID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportControl]'))
ALTER TABLE [dbo].[ReportControl] CHECK CONSTRAINT [FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID]
GO
