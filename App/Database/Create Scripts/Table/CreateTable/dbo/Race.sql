SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Race]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Race](
	[RaceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RaceName] [varchar](80) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_Race] PRIMARY KEY CLUSTERED 
(
	[RaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Race_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Race] ADD  CONSTRAINT [DF_Race_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
