SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSecondaryCtls]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelSecondaryCtls](
	[ServiceLevelSecondaryCtlsID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ServiceLevelID] [int] NULL,
	[ParentID] [int] NULL,
	[ControlName] [varchar](100) NULL,
	[DisplayName] [varchar](100) NULL,
	[DisplayOrder] [int] NULL,
	[Visible] [smallint] NULL,
	[X] [int] NULL,
	[Y] [int] NULL,
	[Height] [int] NULL,
	[LeftPos] [int] NULL,
	[MaxChar] [int] NULL,
 CONSTRAINT [PK_ServiceLevelSecondaryCtls] PRIMARY KEY NONCLUSTERED 
(
	[ServiceLevelSecondaryCtlsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelSecondaryCtls]') AND name = N'FK_ServiceLevelID')
CREATE NONCLUSTERED INDEX [FK_ServiceLevelID] ON [dbo].[ServiceLevelSecondaryCtls]
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
