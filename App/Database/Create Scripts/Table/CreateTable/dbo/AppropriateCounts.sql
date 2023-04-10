SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppropriateCounts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AppropriateCounts](
	[CallID] [int] NULL,
	[appropriateType] [int] NULL,
	[IndicationID] [int] NULL,
	[DynamicCategory] [varchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AppropriateCounts]') AND name = N'IDX_AppropriateCounts_CallId')
CREATE CLUSTERED INDEX [IDX_AppropriateCounts_CallId] ON [dbo].[AppropriateCounts]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO
