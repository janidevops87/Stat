SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportLog](
	[ReportLogID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReportLogDateTime] [datetime] NULL,
	[ReportID] [int] NULL,
	[WebPersonID] [int] NULL,
	[ReportLogRemoteAddress] [varchar](20) NULL,
	[ReportLogQueryString] [varchar](200) NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___7__15] PRIMARY KEY CLUSTERED 
(
	[ReportLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportLog_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportLog]'))
ALTER TABLE [dbo].[ReportLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportLog_ReportID_dbo_Report_ReportID] FOREIGN KEY([ReportID])
REFERENCES [dbo].[Report] ([ReportID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportLog_ReportID_dbo_Report_ReportID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportLog]'))
ALTER TABLE [dbo].[ReportLog] CHECK CONSTRAINT [FK_dbo_ReportLog_ReportID_dbo_Report_ReportID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportLog]'))
ALTER TABLE [dbo].[ReportLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID] FOREIGN KEY([WebPersonID])
REFERENCES [dbo].[WebPerson] ([WebPersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ReportLog]'))
ALTER TABLE [dbo].[ReportLog] CHECK CONSTRAINT [FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID]
GO
