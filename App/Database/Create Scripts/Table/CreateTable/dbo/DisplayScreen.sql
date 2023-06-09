SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DisplayScreen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DisplayScreen](
	[DisplayScreenID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DisplayScreen] [nvarchar](10) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL
) ON [PRIMARY]
END
GO
