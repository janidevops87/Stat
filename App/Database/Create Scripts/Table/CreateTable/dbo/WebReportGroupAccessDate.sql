SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupAccessDate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebReportGroupAccessDate](
	[WebReportGroupAccessDateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebReportGroupID] [int] NULL,
	[AccessStartDate] [datetime] NULL,
	[AccessEndDate] [datetime] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___1__37] PRIMARY KEY CLUSTERED 
(
	[WebReportGroupAccessDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupAccessDate]') AND name = N'WebReportGroupID')
CREATE NONCLUSTERED INDEX [WebReportGroupID] ON [dbo].[WebReportGroupAccessDate]
(
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupAccessDate]'))
ALTER TABLE [dbo].[WebReportGroupAccessDate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID] FOREIGN KEY([WebReportGroupID])
REFERENCES [dbo].[WebReportGroup] ([WebReportGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupAccessDate]'))
ALTER TABLE [dbo].[WebReportGroupAccessDate] CHECK CONSTRAINT [FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]
GO
