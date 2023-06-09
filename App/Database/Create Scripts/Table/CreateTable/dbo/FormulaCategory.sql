SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FormulaCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FormulaCategory](
	[FormulaCategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FormulaCategoryName] [varchar](100) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FormulaCategory]') AND name = N'FormulaCategory_ID')
CREATE UNIQUE CLUSTERED INDEX [FormulaCategory_ID] ON [dbo].[FormulaCategory]
(
	[FormulaCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
