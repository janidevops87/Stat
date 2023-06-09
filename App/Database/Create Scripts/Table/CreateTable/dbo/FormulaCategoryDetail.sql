SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FormulaCategoryDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FormulaCategoryDetail](
	[FormulaCategoryDetailID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FormulaCategoryID] [int] NOT NULL,
	[FormulaCategoryDetailName] [varchar](100) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FormulaCategoryDetail]') AND name = N'FormulaCategoryDetail_ID')
CREATE UNIQUE CLUSTERED INDEX [FormulaCategoryDetail_ID] ON [dbo].[FormulaCategoryDetail]
(
	[FormulaCategoryDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
