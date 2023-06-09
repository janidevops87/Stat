SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoResponseCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AutoResponseCode](
	[AutoResponseCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[AutoResponseCode] [int] NULL,
	[LogeventID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AutoResponseCode]') AND name = N'IDX_AutoResponseCode_CallID_AutoResponseCode')
CREATE CLUSTERED INDEX [IDX_AutoResponseCode_CallID_AutoResponseCode] ON [dbo].[AutoResponseCode]
(
	[CallID] ASC,
	[AutoResponseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AutoResponseCode]') AND name = N'IDX_AutoResponseCode_AutoResponseCodeID')
CREATE NONCLUSTERED INDEX [IDX_AutoResponseCode_AutoResponseCodeID] ON [dbo].[AutoResponseCode]
(
	[AutoResponseCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
