SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Functions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Functions](
	[FUNCTIONID] [int] IDENTITY(5,1) NOT FOR REPLICATION NOT NULL,
	[FUNCTIONNAME] [varchar](500) NULL,
	[FUNCTIONSTRING] [varchar](1000) NULL,
	[FUNCTIONDESCRIPTION] [varchar](1000) NULL,
 CONSTRAINT [PK_Functions] PRIMARY KEY CLUSTERED 
(
	[FUNCTIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
