SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DictionaryItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DictionaryItem](
	[DictionaryItemID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DictionaryItemName] [varchar](50) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_DictionaryItem_1__13] PRIMARY KEY CLUSTERED 
(
	[DictionaryItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DictionaryItem]') AND name = N'DictionaryItem')
CREATE NONCLUSTERED INDEX [DictionaryItem] ON [dbo].[DictionaryItem]
(
	[DictionaryItemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
