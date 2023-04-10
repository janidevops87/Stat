SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Api].[Secrets]') AND type in (N'U'))
BEGIN
CREATE TABLE [Api].[Secrets](
	[AzureStatTracQueue] [varbinary](128) NULL
) ON [PRIMARY]
END
GO
