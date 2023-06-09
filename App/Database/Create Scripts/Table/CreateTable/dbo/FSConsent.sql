SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSConsent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSConsent](
	[FSConsentID] [int] NOT NULL,
	[FSConsentName] [varchar](50) NULL,
	[FSConsentReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[FSConsentReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[FSConsentReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_FSConsent] PRIMARY KEY NONCLUSTERED 
(
	[FSConsentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
