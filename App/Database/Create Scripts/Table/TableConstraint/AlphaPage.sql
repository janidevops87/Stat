

/****** Object:  Index [IX_AlphaPage_CallID]    Script Date: 03/13/2010 16:31:01 ******/
IF NOT EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[AlphaPage]') AND name = N'IX_AlphaPage_AlphaPageSent')
CREATE NONCLUSTERED INDEX [IX_AlphaPage_AlphaPageSent] ON [dbo].[AlphaPage] 
(
	[AlphaPageSent] ASC
) ON [IDX]
GO 