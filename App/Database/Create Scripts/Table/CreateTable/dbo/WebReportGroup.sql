SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebReportGroup](
	[WebReportGroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebReportGroupName] [varchar](80) NULL,
	[OrgHierarchyParentID] [int] NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[WebReportGroupMaster] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[BatchFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_WebReportGroup_1__13] PRIMARY KEY CLUSTERED 
(
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroup]') AND name = N'OrgHierarchyParentID')
CREATE NONCLUSTERED INDEX [OrgHierarchyParentID] ON [dbo].[WebReportGroup]
(
	[OrgHierarchyParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroup]') AND name = N'WebReportGroupMaster')
CREATE NONCLUSTERED INDEX [WebReportGroupMaster] ON [dbo].[WebReportGroup]
(
	[WebReportGroupMaster] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
