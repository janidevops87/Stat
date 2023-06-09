SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dbSpace]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dbSpace](
	[dbSpaceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[tableName] [varchar](50) NULL,
	[date] [datetime] NULL,
	[reserved] [decimal](15, 0) NULL,
	[data] [decimal](15, 0) NULL,
	[indexp] [decimal](15, 0) NULL,
	[unused] [decimal](15, 0) NULL,
	[LastModified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[dbSpaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
