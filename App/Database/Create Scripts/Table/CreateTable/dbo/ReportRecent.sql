SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportRecent]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[ReportRecent](
        [ReportRecentID]    INT IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
        [ReportID]          INT NOT NULL,
        [WebPersonID]       INT NOT NULL,
        [LastModified]      DATETIME NULL
     CONSTRAINT [PK_ReportRecent] PRIMARY KEY CLUSTERED ([ReportRecentID] ASC) 
     WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
     ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ReportRecent]') AND name = N'IDX_ReportRecent_WebPersonID')
BEGIN
    CREATE NONCLUSTERED INDEX [IDX_ReportRecent_WebPersonID] ON [dbo].[ReportRecent]
    ([WebPersonID] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, 
    ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX];
END
GO
