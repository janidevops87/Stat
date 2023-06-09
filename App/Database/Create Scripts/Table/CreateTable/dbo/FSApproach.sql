SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSApproach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSApproach](
	[FSApproachID] [int] NOT NULL,
	[FSApproachName] [varchar](50) NULL,
	[FSApproachReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[FSApproachReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[FSApproachReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_FSApproach] PRIMARY KEY NONCLUSTERED 
(
	[FSApproachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
