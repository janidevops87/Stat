SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AlphaPage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AlphaPage](
	[AlphaPageId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallId] [int] NULL,
	[AlphaPageRecipient] [varchar](100) NULL,
	[AlphaPageSender] [varchar](100) NULL,
	[AlphaPageBC] [varchar](100) NULL,
	[AlphaPageCC] [varchar](100) NULL,
	[AlphaPageSubject] [varchar](150) NULL,
	[AlphaPageBody] [varchar](7500) NULL,
	[AlphaPageCreated] [datetime] NOT NULL,
	[AlphaPageSent] [datetime] NULL,
	[AlphaPageComplete] [int] NULL,
 CONSTRAINT [PK_AlphaPage] PRIMARY KEY CLUSTERED 
(
	[AlphaPageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AlphaPage]') AND name = N'IX_AlphaPage_AlphaPageSent')
CREATE NONCLUSTERED INDEX [IX_AlphaPage_AlphaPageSent] ON [dbo].[AlphaPage]
(
	[AlphaPageSent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_AlphaPage_AlphaPageCreated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AlphaPage] ADD  CONSTRAINT [DF_AlphaPage_AlphaPageCreated]  DEFAULT (getdate()) FOR [AlphaPageCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_AlphaPage_AlphaPageComplete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AlphaPage] ADD  CONSTRAINT [DF_AlphaPage_AlphaPageComplete]  DEFAULT (0) FOR [AlphaPageComplete]
END
GO
