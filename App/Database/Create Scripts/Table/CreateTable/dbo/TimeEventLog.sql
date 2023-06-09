SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TimeEventLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TimeEventLog](
	[TimeEventLogID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TimeEventLogType] [int] NULL,
	[TimeEventLogItem] [varchar](250) NULL,
	[TimeEventLogNote] [varchar](250) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeEventLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
