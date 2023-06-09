SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Consent](
	[ConsentID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ConsentName] [varchar](50) NULL,
	[ConsentReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[ConsentReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[ConsentReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_Consent_1__13] PRIMARY KEY CLUSTERED 
(
	[ConsentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
