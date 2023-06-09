SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DictionaryItemMisspelling]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DictionaryItemMisspelling](
	[DictionaryItemMisspellingID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DictionaryItemID] [int] NULL,
	[DictionaryItemMisspellingName] [varchar](50) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_DictionaryItemMisspell1__13] PRIMARY KEY CLUSTERED 
(
	[DictionaryItemMisspellingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DictionaryItemMisspelling]') AND name = N'DictionaryItemID')
CREATE NONCLUSTERED INDEX [DictionaryItemID] ON [dbo].[DictionaryItemMisspelling]
(
	[DictionaryItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DictionaryItemMisspelling]') AND name = N'DictionaryItemMisspellingName')
CREATE NONCLUSTERED INDEX [DictionaryItemMisspellingName] ON [dbo].[DictionaryItemMisspelling]
(
	[DictionaryItemMisspellingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DictionaryItemMisspelling]'))
ALTER TABLE [dbo].[DictionaryItemMisspelling]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID] FOREIGN KEY([DictionaryItemID])
REFERENCES [dbo].[DictionaryItem] ([DictionaryItemID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DictionaryItemMisspelling]'))
ALTER TABLE [dbo].[DictionaryItemMisspelling] CHECK CONSTRAINT [FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID]
GO
