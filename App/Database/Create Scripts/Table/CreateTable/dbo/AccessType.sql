SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccessType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AccessType](
	[AccessID] [int] NOT NULL,
	[Access] [int] NOT NULL,
	[AccessName] [varchar](100) NULL,
	[AccessDescription] [varchar](1000) NULL,
 CONSTRAINT [PK_AccessType] PRIMARY KEY NONCLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
