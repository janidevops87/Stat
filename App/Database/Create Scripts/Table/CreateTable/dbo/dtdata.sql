SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dtdata]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dtdata](
	[StatTracID] [int] NULL
) ON [PRIMARY]
END
GO
