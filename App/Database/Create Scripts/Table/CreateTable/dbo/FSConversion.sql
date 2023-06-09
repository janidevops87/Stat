SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSConversion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSConversion](
	[FSConversionID] [int] NOT NULL,
	[FSConversionName] [varchar](50) NULL,
	[FSConversionReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[FSConversionReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[FSConversionReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_FSConversion] PRIMARY KEY NONCLUSTERED 
(
	[FSConversionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
