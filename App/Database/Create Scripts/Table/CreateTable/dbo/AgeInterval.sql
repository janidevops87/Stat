SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AgeInterval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AgeInterval](
	[AgeIntervalID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AgeInterval] [varchar](10) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL
) ON [PRIMARY]
END
GO
