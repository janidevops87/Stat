SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HistoryStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HistoryStatus](
	[HistoryStatusId] [int] NOT NULL,
	[HistoryStatusName] [varchar](15) NULL,
	[HistoryStatusDescription] [varchar](100) NULL,
 CONSTRAINT [PK_HistoryStatus] PRIMARY KEY NONCLUSTERED 
(
	[HistoryStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
